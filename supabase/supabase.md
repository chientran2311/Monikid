✅ Tạo xong! Workflow hoàn chỉnh:

🔄 Run theo thứ tự:
1. Drop database:
-- File: 000_drop_all_tables.sql
⚠️ XÓA TẤT CẢ DỮ LIỆU
2. Tạo lại tables + triggers:
-- File: schema.sql
✓ Tables
✓ Functions
✓ Triggers (on_auth_user_created, on_profile_created)
✓ RLS policies
3. Sync existing users:
-- File: 003_sync_existing_users.sql
✓ Sync auth.users → profiles
✓ Create wallets (1M VND)
✓ Create bank accounts (parent only, 1M VND)
✓ Verification + Summary report
📊 Sau khi chạy sẽ thấy:
Trigger sẽ tự động hoạt động cho user mới signup sau này! 🎉