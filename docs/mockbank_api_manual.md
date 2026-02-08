# Hướng dẫn sử dụng MockBank API (Backend)

## 🌐 Tổng quan
MoniKid Backend API (`mockbank-api`) là service xử lý các nghiệp vụ liên quan đến Wallet và Transactions.
Service này được viết bằng **Node.js + Express** và kết nối trực tiếp với **Supabase Postgres**.

## 🔗 Base URL
- **Live (Render)**: `https://monikid-api.onrender.com`
- **Local**: `http://localhost:3001`

---

## 🚀 Các Endpoints (Paths)

### 1. Kiểm tra hệ thống (Health Check)
Dùng để kiểm tra server có đang chạy không.

- **Method**: `GET`
- **Path**: `/` hoặc `/health`
- **Response**:
  ```json
  {
    "status": "online",
    "message": "Welcome to MoniKid API 🚀",
    "endpoints": { ... }
  }
  ```

---

### 2. Giao dịch (Transactions)

#### ➤ 2.1 Tạo giao dịch mới (Create Transaction)
Dùng khi thực hiện chuyển tiền, nạp tiền, hoặc trả tiền tiêu vặt.

- **Method**: `POST`
- **Path**: `/api/transactions`
- **Body (JSON)**:
  ```json
  {
    "family_id": "uuid-cua-family",
    "from_wallet_id": "uuid-vi-nguon (optional)",
    "to_wallet_id": "uuid-vi-dich (optional)",
    "type": "transfer", // transfer, allowance, payment, deposit, withdraw
    "amount": 50000,
    "description": "Chuyen tien tieu vat",
    "created_by": "uuid-user-thuc-hien"
  }
  ```
- **Response (201 Created)**: Trả về object transaction vừa tạo.

#### ➤ 2.2 Lấy danh sách giao dịch (List Transactions)
Lấy lịch sử giao dịch, có thể lọc theo ví hoặc gia đình.

- **Method**: `GET`
- **Path**: `/api/transactions`
- **Query Params**:
  - `wallet_id`: (Optional) Lọc giao dịch của ví này (cả gửi và nhận).
  - `family_id`: (Optional) Lọc theo family.
  - `limit`: (Optional) Số lượng (Default: 20).
  - `offset`: (Optional) Bắt đầu từ đâu (Default: 0).
- **Example**:
  `GET /api/transactions?wallet_id=123&limit=5`

#### ➤ 2.3 Chi tiết giao dịch (Get Detail)
- **Method**: `GET`
- **Path**: `/api/transactions/:id`
- **Example**: `/api/transactions/abc-123-uuid`

---

## 🛠️ Cài đặt & Chạy Local

Để phát triển hoặc debug trên máy cá nhân:

1.  **Truy cập thư mục**:
    ```bash
    cd mockbank-api
    ```
2.  **Cài đặt thư viện**:
    ```bash
    npm install
    ```
3.  **Cấu hình**:
    - Mở file `.env`.
    - Điền `SUPABASE_URL` và `SUPABASE_ANON_KEY` (lấy từ dự án Flutter hoặc Supabase Dashboard).
4.  **Chạy Server**:
    ```bash
    npm run dev
    ```
    Server sẽ chạy tại `http://localhost:3001`.

---

## ⚠️ Database Schema
Để API hoạt động, Database trên Supabase cần có bảng `transactions`.
Script tạo bảng (Chạy trong SQL Editor của Supabase):

```sql
create table public.transactions (
  id uuid default gen_random_uuid() primary key,
  family_id uuid not null,
  from_wallet_id uuid references public.wallets(id),
  to_wallet_id uuid references public.wallets(id),
  type text not null,
  amount numeric not null,
  description text,
  created_by uuid references auth.users(id),
  status text default 'pending',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);
```
