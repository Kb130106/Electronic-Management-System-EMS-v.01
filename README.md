# VLL-Pro-Integrated-Offline-Accounting-Suite
A specialized financial management tool designed for business to replace manual "Rozmel" paper systems. This suite integrates a Party Ledger for tracking individual customer credits/debits and a Daily Cashbook for real-time liquidity monitoring.
Description:
A specialized financial management tool designed for footwear wholesalers to replace manual "Rozmel" paper systems. This suite integrates a Party Ledger for tracking individual customer credits/debits and a Daily Cashbook for real-time liquidity monitoring.
Key Features:

Immutable Records: Implements SHA-256 cryptographic hashing to ensure that financial entries cannot be tampered with.

Offline-First Architecture: Built using Browser LocalStorage for zero-latency performance in areas with poor connectivity.

Data Portability: Features JSON-based backup and "Universal Sync" logic to merge data across different devices without duplication.

Multi-Mode Tracking: Specifically handles Cash, Online, and Credit reconciliations with automatic closing balance calculations.

# VLL Pro — Vikas Enterprise Accounting Suite v6.4

**VLL Pro (Vikas Ledger Logic)** is a high-performance, offline-first accounting ecosystem designed for footwear wholesalers. It bridges the gap between traditional Tally/Excel workflows and modern, zero-latency web interfaces.

## 🚀 Core Modules
- **Office Cashbook:** A digital "Rozmel" with dual-entry logic (Credit/Debit) and real-time closing balance calculations.
- **Party Ledger:** Universal Sync-enabled customer tracking with automated alphabetization and transaction history.
- **Tally Bridge:** An atomic data injection engine that uses fuzzy column mapping to import Tally Prime and Excel exports directly.

## 🛠️ Technical Excellence
- **Immutable Data:** Every imported row undergoes **SHA-256 Hashing** to create a verifiable audit trail.
- **Atomic Transactions:** Uses `db.transaction` and IndexedDB (via 1.js) to ensure zero data corruption during large imports.
- **Zero-Backend Architecture:** Engineered to run entirely in the browser using `LocalStorage` and `IndexedDB`. No hosting fees, total privacy.
- **SheetJS Integration:** Advanced binary processing for `.xlsx` and `.csv` files.

## 📂 Installation & Usage
1. Clone this repository or download the ZIP.
2. Open `index.html` in any modern browser (Chrome/Edge recommended).
3. Use the **Tally Bridge** to import your existing spreadsheets or start fresh in the **Cashbook**.

## 👨‍💻 Developer
**Kartik Bhatia** *Full-Stack Developer & Cybersecurity Follower* [LinkedIn](https://www.linkedin.com/in/kartikbhatia1301) | [GitHub](https://github.com/Kb130106)


