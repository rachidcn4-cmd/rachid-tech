# RACHID TECH - النسخة الحقيقية
## التشغيل
1. npm install
2. انسخ .env.example الى .env.local وعمر القيم من Supabase
3. نفذ supabase/schema.sql في Supabase > SQL Editor
4. npm run dev -> http://localhost:3000
## Admin
سجل حساب من الموقع، ثم في SQL:
insert into admins (user_id) values ('USER_ID');
ثم ادخل /admin
## النشر
Vercel > New Project > ارفع GitHub > زيد env vars > Deploy
الدومين: Vercel > Domains > rachidtech.com
