# Electronic Management System (EMS) — v1.0

A robust, full-stack **ASP.NET Web Forms** application designed for electronic inventory tracking and customer booking management. This project demonstrates enterprise-level architecture using **C#**, **ADO.NET**, and **SQL Server**.

## 🚀 Key Features
- **Dual-Portal System:** Separate, secure interfaces for **Admin** (Inventory/User Management) and **Customers** (Booking/Profile).
- **Automated Database Lifecycle:** Features a self-seeding mechanism in `Global.asax.cs` that automatically generates the SQL schema and initial data on the first run.
- **Secure Authentication:** Custom session-based login system with dedicated `Logout.aspx` logic to prevent unauthorized back-navigation.
- **Dynamic Data Binding:** Advanced use of ASP.NET server controls (`GridView`, `Repeater`, and `DataList`) for real-time database interaction.

## 🛠️ Tech Stack
- **Frontend:** ASP.NET Web Forms (ASPX), CSS3, JavaScript.
- **Backend:** C# (.NET Framework), ADO.NET for high-performance data access.
- **Database:** Microsoft SQL Server (`.mdf` LocalDB).
- **Server:** IIS Express.

## 📂 Project Structure
- **/Admin:** Contains `AdminDashboard.aspx` and `AdminLogin.aspx` for administrative control.
- **/App_Data:** Stores the local SQL Server database instance.
- **Global.asax:** Managed application-level events and DB initialization logic.
- **Web.config:** Centralized configuration for connection strings and security settings.

## ⚙️ Installation & Setup
1. Clone the repository to your local machine.
2. Open `ElectronicManagementSystem.sln` in **Visual Studio 2019/2022**.
3. Ensure **SQL Server Express** is installed.
4. Press `F5` to run. The system will automatically detect the connection string in `Web.config` and initialize the database.

## 👨‍💻 Developer
**Kartik Bhatia** *Full-Stack Developer | B.Sc. IT Student @ SRKI* [LinkedIn](https://www.linkedin.com/in/kartikbhatia1301) | [GitHub](https://github.com/Kb130106)
