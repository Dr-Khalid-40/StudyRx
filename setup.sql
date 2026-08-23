-- StudyRx — run this once in your NEW Supabase project's SQL Editor
-- (Project Settings > SQL Editor > New query > paste this > Run)

create table if not exists studyrx_data (
  id text primary key,
  user_id uuid references auth.users(id) on delete cascade not null,
  type text not null,
  payload jsonb not null,
  updated_at timestamptz default now()
);

alter table studyrx_data enable row level security;

create policy "Users manage only their own rows"
on studyrx_data
for all
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

-- Optional but recommended: turn OFF "Confirm email" under
-- Authentication > Providers > Email, so you and friends can sign up
-- and start using the app immediately without a verification email step.
-- You can always turn it back on later once things are stable.
