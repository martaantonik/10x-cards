-- -----------------------------------------------------
-- migracja: create_users
-- opis: tworzy tabelę użytkowników powiązaną z auth.users,
--        włącza rls i tworzy polityki bezpieczeństwa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- tabela: users
-- -----------------------------------------------------
create table if not exists users (
  id uuid primary key references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- komentarz: dane użytkownika są automatycznie tworzone po rejestracji
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.users (id)
  values (new.id);
  return new;
end;
$$ language plpgsql security definer;

-- komentarz: trigger na nowych użytkowników auth.users
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- -----------------------------------------------------
-- row level security (rls)
-- -----------------------------------------------------

-- włączamy rls dla tabeli users
alter table users enable row level security;

-- komentarz: anon nie ma dostępu do użytkowników
create policy "anon_select_users_deny" 
  on users for select to anon
  using (false);

-- komentarz: anon nie może modyfikować użytkowników
create policy "anon_insert_users_deny" 
  on users for insert to anon 
  with check (false);

create policy "anon_update_users_deny" 
  on users for update to anon 
  using (false);

create policy "anon_delete_users_deny" 
  on users for delete to anon 
  using (false);

-- komentarz: uwierzytelnieni użytkownicy mogą czytać tylko swoje dane
create policy "authenticated_select_own_user" 
  on users for select to authenticated 
  using (id = auth.uid());

-- komentarz: uwierzytelnieni użytkownicy mogą aktualizować tylko swoje dane
create policy "authenticated_update_own_user" 
  on users for update to authenticated 
  using (id = auth.uid());

-- komentarz: insert i delete są obsługiwane przez trigger, więc nie potrzebujemy polityk dla użytkowników

-- -----------------------------------------------------
-- funkcja i trigger do automatycznej aktualizacji updated_at
-- -----------------------------------------------------

-- funkcja aktualizująca kolumnę updated_at
create or replace function update_users_updated_at_column()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- trigger uruchamiający funkcję przed każdą aktualizacją rekordu
create trigger update_users_updated_at
before update on users
for each row
execute function update_users_updated_at_column(); 