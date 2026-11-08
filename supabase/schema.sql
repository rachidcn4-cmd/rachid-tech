-- RACHID TECH SCHEMA - نفذو كامل في Supabase SQL Editor
create extension if not exists pgcrypto;
create table if not exists categories(id uuid primary key default gen_random_uuid(), name text not null, slug text unique not null, type text default 'app', created_at timestamptz default now());
create table if not exists admins(user_id uuid primary key, created_at timestamptz default now());
create table if not exists apps(id uuid primary key default gen_random_uuid(), name text not null, slug text unique not null, description text, logo_url text, screenshots text[] default '{}', category_id uuid references categories(id), size text, version text, os text[] default '{}', download_links jsonb default '[]', price numeric default 0, is_featured boolean default false, downloads int default 0, created_at timestamptz default now());
create table if not exists videos(id uuid primary key default gen_random_uuid(), title text not null, slug text unique not null, description text, thumbnail_url text, video_url text, youtube_id text, category_id uuid references categories(id), is_featured boolean default false, views int default 0, created_at timestamptz default now());
create table if not exists articles(id uuid primary key default gen_random_uuid(), title text not null, slug text unique not null, content text, cover_url text, category_id uuid references categories(id), tags text[] default '{}', seo_title text, seo_description text, status text default 'draft', published_at timestamptz, created_at timestamptz default now());
create table if not exists links(id uuid primary key default gen_random_uuid(), title text not null, description text, image_url text, url text not null, category text, created_at timestamptz default now());
create table if not exists newsletter_subscribers(id uuid primary key default gen_random_uuid(), email text unique not null, confirmed boolean default false, created_at timestamptz default now());
create table if not exists comments(id uuid primary key default gen_random_uuid(), user_id uuid, target_type text, target_id uuid, content text, approved boolean default true, created_at timestamptz default now());
create table if not exists downloads(id uuid primary key default gen_random_uuid(), app_id uuid references apps(id), user_id uuid, created_at timestamptz default now());
create table if not exists settings(id int primary key, site_name text default 'RACHID TECH', logo_url text, hero_title text default 'كل ما تحتاجه في عالم التكنولوجيا', primary_color text default '#7c3aed', footer_text text default 'RACHID TECH © 2026', seo_title text, seo_description text);
insert into settings(id) values(1) on conflict(id) do nothing;
insert into categories(name,slug,type) values('تطبيقات','apps','app'),('ألعاب','games','app'),('برامج','software','app'),('شروحات','tutorials','article'),('أدوات AI','ai-tools','link') on conflict(slug) do nothing;
alter table categories enable row level security; alter table apps enable row level security; alter table videos enable row level security; alter table articles enable row level security; alter table links enable row level security; alter table newsletter_subscribers enable row level security; alter table comments enable row level security; alter table settings enable row level security;
-- قراءة للجميع
create policy "read_all" on categories for select using(true);
create policy "read_all" on apps for select using(true);
create policy "read_all" on videos for select using(true);
create policy "read_all" on articles for select using(status='published' or true);
create policy "read_all" on links for select using(true);
create policy "read_all" on settings for select using(true);
-- الكتابة غير للـ Admin عبر Service Role من API (الـ API يستعمل Service Key) - لا تفتح insert للعامة الا newsletter
create policy "subscribe" on newsletter_subscribers for insert with check(true);
