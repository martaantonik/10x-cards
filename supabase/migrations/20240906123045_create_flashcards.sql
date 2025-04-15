-- -----------------------------------------------------
-- migracja: create_flashcards
-- opis: tworzy tabelę fiszek z relacją do użytkowników, 
--        włącza rls i tworzy polityki bezpieczeństwa,
--        oraz dodaje trigger dla updated_at
-- -----------------------------------------------------

-- -----------------------------------------------------
-- tabela: flashcards
-- -----------------------------------------------------
create table if not exists flashcards (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  front varchar(500) not null,
  back varchar(500) not null,
  status varchar(50) not null check (status in ('pending', 'accepted', 'rejected')),
  known boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- komentarz: dodajemy indeksy dla szybkiego wyszukiwania fiszek należących do użytkownika
create index if not exists flashcards_user_id_idx on flashcards(user_id);
create index if not exists flashcards_status_idx on flashcards(status);
create index if not exists flashcards_user_id_status_idx on flashcards(user_id, status);

-- -----------------------------------------------------
-- row level security (rls)
-- -----------------------------------------------------

-- włączamy rls dla tabeli flashcards
alter table flashcards enable row level security;

-- komentarz: anon nie ma dostępu do fiszek
create policy "anon_select_flashcards_deny" 
  on flashcards for select to anon
  using (false);

-- komentarz: anon nie może modyfikować fiszek
create policy "anon_insert_flashcards_deny" 
  on flashcards for insert to anon 
  with check (false);

create policy "anon_update_flashcards_deny" 
  on flashcards for update to anon 
  using (false);

create policy "anon_delete_flashcards_deny" 
  on flashcards for delete to anon 
  using (false);

-- komentarz: uwierzytelnieni użytkownicy mogą czytać tylko swoje fiszki
create policy "authenticated_select_own_flashcards" 
  on flashcards for select to authenticated 
  using (user_id = auth.uid());

-- komentarz: uwierzytelnieni użytkownicy mogą dodawać tylko swoje fiszki
create policy "authenticated_insert_own_flashcards" 
  on flashcards for insert to authenticated 
  with check (user_id = auth.uid());

-- komentarz: uwierzytelnieni użytkownicy mogą aktualizować tylko swoje fiszki
create policy "authenticated_update_own_flashcards" 
  on flashcards for update to authenticated 
  using (user_id = auth.uid());

-- komentarz: uwierzytelnieni użytkownicy mogą usuwać tylko swoje fiszki
create policy "authenticated_delete_own_flashcards" 
  on flashcards for delete to authenticated 
  using (user_id = auth.uid());

-- -----------------------------------------------------
-- funkcja i trigger do automatycznej aktualizacji updated_at
-- -----------------------------------------------------

-- funkcja aktualizująca kolumnę updated_at
create or replace function update_updated_at_column()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

-- trigger uruchamiający funkcję przed każdą aktualizacją rekordu
create trigger update_flashcards_updated_at
before update on flashcards
for each row
execute function update_updated_at_column(); 