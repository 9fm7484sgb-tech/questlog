-- Questlog Online cloud schema. Run once in your own Supabase project's SQL Editor.
-- Each user can read and edit only their own rows (enforced by Row Level Security).
-- The app uses a public/publishable key. NEVER put a service-role key in browser files.

create table if not exists public.questlog_profiles (
    user_id uuid primary key references auth.users(id) on delete cascade,
    display_name text not null default 'Adventurer',
    updated_at timestamptz not null default now(),
    constraint questlog_profiles_name_len check (char_length(display_name) between 1 and 40)
);
create table if not exists public.questlog_days (
    user_id uuid not null references auth.users(id) on delete cascade,
    log_date date not null,
    entry jsonb not null default '{}'::jsonb,
    updated_at timestamptz not null default now(),
    primary key (user_id, log_date),
    constraint questlog_days_object check (jsonb_typeof(entry)='object')
);

alter table public.questlog_profiles enable row level security;
alter table public.questlog_days enable row level security;

revoke all on public.questlog_profiles from public, anon;
revoke all on public.questlog_days from public, anon;
grant select, insert, update on public.questlog_profiles to authenticated;
grant select, insert, update on public.questlog_days to authenticated;

create policy "Read own Questlog profile" on public.questlog_profiles
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "Create own Questlog profile" on public.questlog_profiles
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Update own Questlog profile" on public.questlog_profiles
  for update to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "Read own Questlog days" on public.questlog_days
  for select to authenticated using ((select auth.uid()) = user_id);
create policy "Create own Questlog days" on public.questlog_days
  for insert to authenticated with check ((select auth.uid()) = user_id);
create policy "Update own Questlog days" on public.questlog_days
  for update to authenticated using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
