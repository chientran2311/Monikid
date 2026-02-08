# Test Firebase Authentication & Firestore Sync

## Các logs bạn sẽ thấy khi Sign Up thành công:

### 1. Repository Level (auth_repository_impl.dart):
```
📝 Starting sign up process for email: test@example.com
🔍 Sign up details - Name: Test User, Phone: 0123456789, Role: parent
🔐 Creating Firebase Auth account...
✅ Auth account created with UID: xyz123abc456
💾 Syncing user data to Firestore...
🔍 User data to save: {uid: xyz123abc456, email: test@example.com, ...}
✅ Firestore sync completed successfully!
💰 Wallet initialized with 1,000,000 VND
🏦 Bank account created for parent
```

### 2. Provider Level (auth_provider.dart):
```
📝 Auth Provider: Starting sign up for test@example.com
📝 Details - Name: Test User, Phone: 0123456789, Role: parent
✅ Auth Provider: Sign up successful
💾 Firestore sync completed by repository
```

## Kiểm tra Firestore sau khi đăng ký:

1. Vào Firebase Console: https://console.firebase.google.com
2. Chọn project của bạn
3. Vào **Firestore Database**
4. Kiểm tra collection `users`
5. Document với ID = UID của user vừa tạo
6. Cấu trúc dữ liệu:

```json
{
  "uid": "xyz123abc456",
  "email": "test@example.com",
  "full_name": "Test User",
  "phone": "0123456789",
  "role": "parent",
  "avatar_url": "https://i.pravatar.cc/150?img=11",
  "created_at": Timestamp,
  "wallet": {
    "balance": 1000000.0,
    "currency": "VND",
    "is_locked": false
  },
  "bank_account": {
    "account_number": "BK-1738569600000",
    "bank_balance": 1000000.0,
    "is_verified": true
  }
}
```

## Các lỗi có thể gặp và logs tương ứng:

### Email đã tồn tại:
```
❌ Firebase Auth Error: email-already-in-use - The email address is already in use by another account
❌ Auth Provider: Firebase Auth error - email-already-in-use: The email address is already in use by another account
```

### Password quá yếu:
```
❌ Firebase Auth Error: weak-password - Password should be at least 6 characters
❌ Auth Provider: Firebase Auth error - weak-password: Password should be at least 6 characters
```

### Lỗi Firestore (nếu rules không đúng):
```
✅ Auth account created with UID: xyz123abc456
❌ Firestore Error: permission-denied - Missing or insufficient permissions
❌ Auth Provider: Firestore error - permission-denied: Missing or insufficient permissions
```

## Firestore Security Rules cần thiết:

Thêm vào Firebase Console > Firestore Database > Rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read/write their own document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow creating new user during sign up
    match /users/{userId} {
      allow create: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Cách test:

1. Chạy app: `flutter run`
2. Vào màn hình Register
3. Điền thông tin:
   - Email: test@example.com
   - Password: test123456
   - Full Name: Test User
   - Phone: 0123456789
4. Nhấn Sign Up
5. Xem logs trong terminal (hoặc Debug Console)
6. Kiểm tra Firestore Database trong Firebase Console
