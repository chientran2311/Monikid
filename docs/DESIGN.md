# MoniKid - Design Document

> **Version:** 1.0  
> **Date:** 2026-01-27  
> **Status:** Design Approved ✅

---

## 1. Executive Summary

### What is MoniKid?
MoniKid is a **Family Fintech/Banking platform** that digitizes allowances and spending management for children under parental supervision.

### Target Users
- **Parents (Phụ huynh):** Mom & Dad who manage family finances and monitor children's spending
- **Children (Con cái):** Kids who learn financial responsibility through supervised spending

### Project Scope
- **Type:** Academic project ("Đồ án")
- **Platform:** Android first, iOS later
- **Scale:** Demo/learning focused, not production scale

---

## 2. Core Features

### 💳 Financial Management (Cashless & Allowance)

| Feature | Parent | Child |
|---------|--------|-------|
| Mock Bank Account | ✅ Own account | ❌ |
| E-Wallet | ✅ Own wallet | ✅ Created by parent |
| Deposit to Wallet | ✅ From mock bank | ❌ |
| Withdraw to Bank | ✅ | ❌ |
| Send Allowance | ✅ To children | ❌ |
| Schedule Allowance | ✅ Daily/Weekly/Monthly | ❌ |
| QR Payment | ❌ | ✅ Scan to pay |
| Request Money | ❌ | ✅ Request from parent |
| Approve/Deny Requests | ✅ | ❌ |

### 👁️ Parental Control & Monitoring

| Feature | Description |
|---------|-------------|
| Transaction History | View all family transactions |
| Spending Statistics | Charts and reports |
| Receipt Gallery | View scanned receipts with images |
| GPS Location | 15-min intervals + on transaction |
| Lock Child Wallet | Emergency lock (children only) |
| Spending Limits | Daily limits for children |
| Transparency | Parents see each other's data |

### 🤖 Smart Features

| Feature | Technology |
|---------|------------|
| Receipt OCR | ML Kit (extract amount, store, date) |
| Real-time Chat | Supabase Realtime |
| Push Notifications | Firebase Cloud Messaging |
| Family Invite | 6-digit invite code |

---

## 3. User Roles & Permissions

### Family Structure
```
                    ┌─────────────┐
                    │   Family    │
                    │  (Nguyễn)   │
                    └──────┬──────┘
                           │
         ┌─────────────────┼─────────────────┐
         │                 │                 │
    ┌────┴────┐      ┌─────┴─────┐     ┌─────┴─────┐
    │  Dad    │      │   Mom     │     │   Child   │
    │ (owner) │      │ (parent)  │     │  (child)  │
    └────┬────┘      └─────┬─────┘     └─────┬─────┘
         │                 │                 │
    ┌────┴────┐      ┌─────┴─────┐     ┌─────┴─────┐
    │ Wallet  │      │  Wallet   │     │  Wallet   │
    │ 🏦+💰   │      │  🏦+💰    │     │    💰     │
    └─────────┘      └───────────┘     │ 🔒lockable│
                                       └───────────┘
```

### Permission Matrix

| Action | Owner | Parent | Child |
|--------|-------|--------|-------|
| Access MockBank | ✅ | ✅ | ❌ |
| View own transactions | ✅ | ✅ | ✅ |
| View spouse transactions | ✅ | ✅ | ❌ |
| View children transactions | ✅ | ✅ | ❌ |
| Lock child wallet | ✅ | ✅ | ❌ |
| Lock spouse wallet | ❌ | ❌ | ❌ |
| Transfer to child | ✅ | ✅ | ❌ |
| Invite members | ✅ | ✅ | ❌ |
| Remove members | ✅ | ❌ | ❌ |

---

## 4. Tech Stack

| Layer | Technology |
|-------|------------|
| **Framework** | Flutter |
| **Architecture** | Simplified 2-Layer (Services + Screens) |
| **State Management** | Riverpod (riverpod_generator) |
| **Routing** | GoRouter |
| **Backend** | Supabase (Auth, PostgreSQL, Realtime, Storage) |
| **Push Notifications** | Firebase Cloud Messaging |
| **Local Storage** | SharedPreferences |
| **Localization** | flutter_localization |
| **OCR** | ML Kit Text Recognition |
| **Maps** | Google Maps Flutter |

### Key Packages
```yaml
dependencies:
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0
  go_router: ^14.0.0
  supabase_flutter: ^2.5.0
  geolocator: ^12.0.0
  google_maps_flutter: ^2.6.0
  google_mlkit_text_recognition: ^0.11.0
  camera: ^0.10.5
  qr_code_scanner: ^1.0.1
  firebase_core: ^2.30.0
  firebase_messaging: ^14.9.0
  fl_chart: ^0.68.0
  flutter_svg: ^2.0.0
  cached_network_image: ^3.3.0
  shared_preferences: ^2.2.0
  intl: ^0.19.0
```

---

## 5. Project Structure

```
lib/
├── main.dart
├── app/
│   ├── app.dart                 # MaterialApp + GoRouter
│   ├── router.dart              # All routes defined here
│   └── theme.dart               # Colors, text styles
│
├── core/
│   ├── constants.dart           # Enums, app constants
│   ├── supabase_client.dart     # Supabase initialization
│   ├── assets.dart              # Centralized asset paths
│   └── utils.dart               # Formatters, helpers
│
├── models/                      # Data models
│   ├── user_model.dart
│   ├── family_model.dart
│   ├── transaction_model.dart
│   ├── wallet_model.dart
│   └── receipt_model.dart
│
├── services/                    # Data layer (Supabase calls)
│   ├── auth_service.dart
│   ├── family_service.dart
│   ├── wallet_service.dart
│   ├── transaction_service.dart
│   ├── receipt_service.dart
│   ├── location_service.dart
│   └── chat_service.dart
│
├── providers/                   # Riverpod providers
│   ├── auth_provider.dart
│   ├── family_provider.dart
│   ├── wallet_provider.dart
│   └── ...
│
├── screens/                     # UI screens
│   ├── auth/
│   ├── parent/
│   ├── child/
│   └── shared/
│
└── widgets/                     # Reusable components
    ├── common/
    └── charts/
```

---

## 6. Database Schema

### Tables Overview

| Table | Description |
|-------|-------------|
| `profiles` | User profiles with role (parent/child) |
| `families` | Family groups with invite codes |
| `family_members` | Junction table: user ↔ family with roles |
| `wallets` | E-wallets (parent type or child type) |
| `mock_bank_accounts` | Simulated bank accounts (parents only) |
| `transactions` | All money movements |
| `money_requests` | Child requesting money from parent |
| `receipts` | Scanned receipt data + images |
| `location_logs` | GPS tracking history |
| `messages` | Family chat messages |
| `allowance_schedules` | Recurring allowance setup |

### Entity Relationships
```
profiles ─────┬───── families (via family_members)
              │
              ├───── wallets (1:1)
              │
              ├───── mock_bank_accounts (1:1, parents only)
              │
              ├───── transactions (1:N)
              │
              ├───── money_requests
              │
              ├───── receipts
              │
              └───── location_logs
```

---

## 7. Screen Flows

### Authentication Flow
```
Splash → Welcome → Login/Register
                      │
        ┌─────────────┴─────────────┐
        │                           │
    Register                     Login
    - Email                      - Email
    - Password                   - Password
    - Full Name                      │
    - Phone [Verify]                 ▼
    - Role (permanent)          Dashboard
        │
        ▼
    Create/Join Family
        │
        ▼
    Dashboard
```

### Parent Screens (~21)
- Dashboard, Mock Bank, Children Management
- Child Detail, Transaction History, Reports
- Allowance Schedules, Chat, Settings

### Child Screens (~17)
- Dashboard, QR Payment, Request Money
- Receipt Scanner, Spending History
- Chat, Settings

---

## 8. Notifications

| Event | Recipient | Priority |
|-------|-----------|----------|
| Child makes payment | Parents | 🔴 HIGH |
| Spending limit warning | Child | 🔴 HIGH |
| Money request | Parent | 🟡 NORMAL |
| Request approved/denied | Child | 🟡 NORMAL |
| New chat message | Recipient | 🟡 NORMAL |
| Allowance sent | Child | 🟡 NORMAL |

---

## 9. Assets Structure

```
assets/
├── images/
│   ├── logo/
│   ├── onboarding/
│   ├── placeholders/
│   └── illustrations/
│
├── icons/
│   ├── nav/
│   ├── actions/
│   ├── status/
│   ├── finance/
│   └── misc/
│
└── lottie/
```

All assets referenced via `lib/core/assets.dart` for type safety.

---

## 10. Decision Log

| # | Decision | Reason |
|---|----------|--------|
| 1 | Single app with role-based views | Easier for families |
| 2 | Parent invites child via code | Children own accounts safely |
| 3 | Fully simulated money | "Đồ án" scope |
| 4 | 15-min + transaction GPS | Battery efficient |
| 5 | OCR for expense logging | Educational focus |
| 6 | Simple text chat | Keep it simple |
| 7 | Supabase-first | Relational data, Realtime built-in |
| 8 | Simplified 2-layer architecture | Faster to build for demo |
| 9 | Multiple parents per family | Real family structure |
| 10 | Immutable role at registration | Prevent abuse |
| 11 | ML Kit for OCR | Free, offline |
| 12 | Centralized assets | Type safety |

---

## 11. Assumptions

1. One family owner (creator), can add spouse + children
2. Vietnamese language primary, English optional
3. No real money integration (all simulated)
4. Mock merchants with static QR codes for testing
5. Supabase handles most backend logic
6. OTP verification simulated for demo (accept "123456")

---

## 12. Next Steps

1. ☐ Set up Flutter project structure
2. ☐ Configure Supabase project
3. ☐ Create database tables
4. ☐ Implement authentication flow
5. ☐ Build core screens
6. ☐ Implement features incrementally

---

*Document created during brainstorming session. Ready for implementation.*
