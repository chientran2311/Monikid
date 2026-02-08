# MoniKid 💰👶

> **Family Fintech App** - Digitizing allowances and spending management for children under parental supervision.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

---

## 📱 About

MoniKid is a **Family Banking platform** that helps parents:
- 💳 Manage children's digital allowances
- 👁️ Monitor spending with full transparency
- 🔒 Control with spending limits and wallet locks
- 📍 Track location for safety
- 🤖 Use AI/OCR for receipt scanning

## ✨ Features

### For Parents (Phụ huynh)
- 🏦 **Mock Bank Integration** - Simulate bank deposits/withdrawals
- 💸 **Send Allowance** - Manual or scheduled transfers to children
- 📊 **Spending Reports** - Charts and statistics
- 🧾 **Receipt Gallery** - View scanned receipts from children
- 📍 **GPS Tracking** - Location updates every 15 min + on transactions
- 🔒 **Wallet Control** - Lock/unlock child wallets, set limits
- 💬 **Family Chat** - Simple messaging with children

### For Children (Con cái)
- 💰 **Digital Wallet** - Receive allowance from parents
- 📱 **QR Payment** - Scan merchant QR to pay
- 🙋 **Request Money** - Ask parents for more money
- 📸 **Receipt Scanner** - OCR to log expenses
- 📊 **My Spending** - Track where money goes
- 💬 **Family Chat** - Message parents

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Framework | Flutter 3.10+ |
| State Management | Riverpod + Generator |
| Routing | GoRouter |
| Backend | Supabase (Auth, PostgreSQL, Realtime, Storage) |
| Push Notifications | Firebase Cloud Messaging |
| OCR | Google ML Kit |
| Maps | Google Maps Flutter |

## 📁 Project Structure

```
lib/
├── main.dart              # Entry point
├── app/                   # App configuration
│   ├── app.dart          # Main app widget
│   ├── router.dart       # GoRouter configuration
│   └── theme.dart        # App theme
├── core/                  # Core utilities
│   ├── assets.dart       # Asset paths
│   ├── constants.dart    # Enums & constants
│   ├── supabase_client.dart
│   └── utils.dart        # Helpers
├── models/               # Data models
├── services/             # Business logic
├── providers/            # Riverpod providers
├── screens/              # UI screens
│   ├── auth/
│   ├── parent/
│   ├── child/
│   └── shared/
└── widgets/              # Reusable components
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10+
- Dart 3.0+
- Supabase account
- Firebase project (for FCM)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/monikid.git
cd monikid
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Supabase:
   - Create a Supabase project
   - Run the SQL schema from `supabase/schema.sql`
   - Update `lib/core/constants.dart` with your Supabase URL and anon key

4. Configure Firebase (optional, for push notifications):
   - Create a Firebase project
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)

5. Run the app:
```bash
flutter run
```

## 📝 Database Setup

Run the SQL schema in your Supabase SQL editor:
```bash
supabase/schema.sql
```

This creates all necessary tables with Row Level Security (RLS) policies.

## 📄 Documentation

- [Design Document](docs/DESIGN.md) - Full design specification
- [API Reference](docs/API.md) - Service layer documentation

## 👥 User Roles

| Role | Description |
|------|-------------|
| **Owner** | Created the family, full control |
| **Parent** | Spouse, can manage children |
| **Child** | Limited access, monitored |

## 📱 Screens Overview

### Auth Flow (7 screens)
Splash → Welcome → Login/Register → OTP → Create/Join Family

### Parent Dashboard (21+ screens)
Home, Bank, Children, Child Detail, Allowance, Reports, Chat, Settings

### Child Dashboard (17+ screens)
Home, QR Pay, Receipts, Request Money, Spending, Chat, Settings

## 🔐 Security

- Row Level Security (RLS) on all tables
- Phone verification at registration
- Role-based access control
- Parents can lock child wallets

## 📄 License

This project is for educational purposes (Đồ án).

---

**Made with ❤️ using Flutter & Supabase**
