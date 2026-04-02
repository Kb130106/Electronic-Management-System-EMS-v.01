using System;
using System.Data.SqlClient;
using System.IO;
using System.Web;

namespace ElectronicManagementSystem
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            try
            {
                string dataDir    = Server.MapPath("~/App_Data/");
                string uploadsDir = Server.MapPath("~/Uploads/");
                if (!Directory.Exists(dataDir))    Directory.CreateDirectory(dataDir);
                if (!Directory.Exists(uploadsDir)) Directory.CreateDirectory(uploadsDir);

                string mdfPath = Path.Combine(dataDir, "dbElectronics.mdf");
                string ldfPath = Path.Combine(dataDir, "dbElectronics_log.ldf");

                // Only create the .mdf if it does not exist yet — never drop/recreate
                if (!File.Exists(mdfPath))
                {
                    string masterConn = @"Data Source=(LocalDB)\MSSQLLocalDB;Initial Catalog=master;Integrated Security=True";
                    using (SqlConnection con = new SqlConnection(masterConn))
                    {
                        con.Open();
                        // Detach cleanly if a stale reference exists (no DROP)
                        try
                        {
                            RunQ(con, "IF DB_ID('dbElectronics') IS NOT NULL " +
                                      "EXEC sp_detach_db 'dbElectronics', 'true'");
                        }
                        catch { }

                        RunQ(con, string.Format(
                            "CREATE DATABASE dbElectronics " +
                            "ON PRIMARY (NAME='dbElectronics', FILENAME='{0}') " +
                            "LOG ON (NAME='dbElectronics_log', FILENAME='{1}')",
                            mdfPath, ldfPath));
                    }
                }

                // Connect with AttachDbFilename — creates tables + data on first run
                string appConn = string.Format(
                    @"Data Source=(LocalDB)\MSSQLLocalDB;" +
                    "AttachDbFilename={0};" +
                    "Integrated Security=True;MultipleActiveResultSets=True", mdfPath);

                using (SqlConnection con = new SqlConnection(appConn))
                {
                    con.Open();
                    CreateTables(con);
                    SeedData(con);
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("STARTUP ERROR: " + ex.Message);
            }
        }

        void CreateTables(SqlConnection con)
        {
            RunQ(con, @"IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblType' AND xtype='U')
                CREATE TABLE tblType (
                    t_id INT IDENTITY(1,1) PRIMARY KEY,
                    type NVARCHAR(50) NOT NULL
                )");

            RunQ(con, @"IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblBrand' AND xtype='U')
                CREATE TABLE tblBrand (
                    b_id      INT IDENTITY(1,1) PRIMARY KEY,
                    t_id      INT NOT NULL REFERENCES tblType(t_id),
                    BrandName NVARCHAR(100) NOT NULL
                )");

            RunQ(con, @"IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblDevice' AND xtype='U')
                CREATE TABLE tblDevice (
                    d_id        INT IDENTITY(1,1) PRIMARY KEY,
                    b_id        INT NOT NULL REFERENCES tblBrand(b_id),
                    model       NVARCHAR(100),
                    description NVARCHAR(500),
                    Price       DECIMAL(10,2),
                    quantity    INT,
                    color       NVARCHAR(50),
                    accessories NVARCHAR(300),
                    img         NVARCHAR(300)
                )");

            RunQ(con, @"IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='tblCustomer' AND xtype='U')
                CREATE TABLE tblCustomer (
                    Name     NVARCHAR(100) NOT NULL,
                    Email    NVARCHAR(100) PRIMARY KEY,
                    Phone    NVARCHAR(15),
                    Address  NVARCHAR(300),
                    Password NVARCHAR(100),
                    City     NVARCHAR(100),
                    picture  NVARCHAR(300)
                )");
        }

        void SeedData(SqlConnection con)
        {
            if (CountQ(con, "SELECT COUNT(*) FROM tblType") == 0)
                RunQ(con, "INSERT INTO tblType(type) VALUES ('Mobile'),('Laptop'),('Tablet')");

            if (CountQ(con, "SELECT COUNT(*) FROM tblBrand") == 0)
                RunQ(con, @"INSERT INTO tblBrand(t_id, BrandName) VALUES
                    (1,'Samsung'), (1,'Apple'),
                    (2,'Dell'),    (2,'Lenovo'),
                    (3,'Apple iPad'), (3,'Samsung Tab')");

            if (CountQ(con, "SELECT COUNT(*) FROM tblCustomer") == 0)
                RunQ(con, @"INSERT INTO tblCustomer(Name,Email,Phone,Address,Password,City,picture) VALUES
                    ('Manav Shah',   'manav@gmail.com',   '9825011101', '12 Rander Road, Adajan',  'pass123', 'Surat',     NULL),
                    ('Pratham Patel','pratham@gmail.com', '9825022202', '45 VIP Road, Vesu',        'pass123', 'Surat',     NULL),
                    ('Dev Mehta',    'dev@gmail.com',     '9825033303', '7 CG Road, Navrangpura',   'pass123', 'Ahmedabad', NULL),
                    ('Kartik Desai', 'kartik@gmail.com',  '9825044404', '3 Ring Road, Majura Gate', 'pass123', 'Surat',     NULL),
                    ('Nethan Joshi', 'nethan@gmail.com',  '9825055505', '22 Satellite Road',        'pass123', 'Ahmedabad', NULL),
                    ('Yug Trivedi',  'yug@gmail.com',     '9825066606', '8 Pal Gam Road',           'pass123', 'Surat',     NULL),
                    ('Jash Modi',    'jash@gmail.com',    '9825077707', '15 Lal Darwaja',           'pass123', 'Ahmedabad', NULL),
                    ('Yash Kapoor',  'yash@gmail.com',    '9825088808', '30 Bhatar Road',           'pass123', 'Surat',     NULL)");

            if (CountQ(con, "SELECT COUNT(*) FROM tblDevice") == 0)
                RunQ(con, @"INSERT INTO tblDevice(b_id,model,description,Price,quantity,color,accessories,img) VALUES
                    (1,'Samsung Galaxy S24 Ultra','200MP camera, S Pen, Snapdragon 8 Gen 3',         129999, 20, 'Titanium Black',   'Charger,Headphones', NULL),
                    (1,'Samsung Galaxy A55 5G',   '50MP camera, 5000mAh battery, Exynos 1480',        37999, 35, 'Awesome Navy',     'Charger',            NULL),
                    (2,'Apple iPhone 15 Pro',     'A17 Pro chip, titanium body, 48MP ProRAW',         134900, 15, 'Natural Titanium', 'Charger',            NULL),
                    (2,'Apple iPhone 15',         'A16 Bionic, 48MP camera, Dynamic Island',          79900, 25, 'Black',            'Charger',            NULL),
                    (3,'Dell Inspiron 15 3530',   'Intel i5 13th Gen, 16GB RAM, 512GB SSD',           62990, 12, 'Platinum Silver',  'Charger,Wireless Mouse', NULL),
                    (3,'Dell XPS 15 9530',        'Intel i7, 32GB RAM, OLED 3.5K, RTX 4060',         189990,  6, 'Platinum Silver',  'Charger',            NULL),
                    (4,'Lenovo IdeaPad Slim 5',   'Intel i5 13th Gen, 16GB RAM, 512GB SSD, FHD',      58999, 14, 'Storm Grey',       'Charger',            NULL),
                    (4,'Lenovo ThinkPad E14',     'Intel i7, 16GB RAM, 512GB SSD, business',          75000,  8, 'Black',            'Charger,Wireless Mouse', NULL),
                    (5,'Apple iPad Pro 12.9 M2',  'M2 chip, Liquid Retina XDR, 256GB WiFi',          112900, 10, 'Space Grey',       'Touch Pen,Charger',  NULL),
                    (5,'Apple iPad 10th Gen',     'A14 Bionic, 10.9 inch Retina, 64GB WiFi',          44900, 18, 'Silver',           'Charger',            NULL),
                    (6,'Samsung Galaxy Tab S9',   'Snapdragon 8 Gen 2, 12GB RAM, IP68, AMOLED',       74999, 12, 'Beige',            'Touch Pen,Charger',  NULL),
                    (6,'Samsung Galaxy Tab A9+',  'Snapdragon 695, 8GB RAM, 11 inch display',         24999, 22, 'Graphite',         'Charger',            NULL)");
        }

        void RunQ(SqlConnection con, string sql)
        { using (var cmd = new SqlCommand(sql, con)) cmd.ExecuteNonQuery(); }

        int CountQ(SqlConnection con, string sql)
        { using (var cmd = new SqlCommand(sql, con)) return Convert.ToInt32(cmd.ExecuteScalar()); }

        void Session_Start(object sender, EventArgs e) { }
        void Session_End(object sender, EventArgs e) { }
        void Application_End(object sender, EventArgs e) { }
        void Application_Error(object sender, EventArgs e) { }
    }
}
