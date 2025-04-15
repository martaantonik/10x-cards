# Schemat Bazy Danych dla 10x Cards

## 1. Lista tabel

### 1.1 Tabela Użytkowników (`users`)

- `id`: UUID (klucz główny). Użytkownicy są zarządzani przez mechanizm uwierzytelniania Supabase, dlatego tabela nie zawiera dodatkowych danych.
- (Opcjonalnie) `created_at`: timestamptz NOT NULL DEFAULT now()
- (Opcjonalnie) `updated_at`: timestamptz NOT NULL DEFAULT now()

### 1.2 Tabela Fiszek (`flashcards`)

- `id`: UUID PRIMARY KEY
- `user_id`: UUID NOT NULL
  - Klucz obcy odnoszący się do `users(id)`
- `front`: VARCHAR(500) NOT NULL
- `back`: VARCHAR(500) NOT NULL
- `status`: VARCHAR(50) NOT NULL
  - Ograniczenie: wartość musi być jedną z ('pending', 'accepted', 'rejected')
- `known`: BOOLEAN NOT NULL DEFAULT false
- `created_at`: timestamptz NOT NULL DEFAULT now()
- `updated_at`: timestamptz NOT NULL DEFAULT now()

#### Ograniczenia

- Klucz obcy: `FOREIGN KEY (user_id)` REFERENCES `users(id)`
- CHECK constraint dla `status`: `CHECK (status IN ('pending', 'accepted', 'rejected'))`

## 2. Relacje między tabelami

- Relacja jeden-do-wielu: jeden użytkownik może posiadać wiele fiszek (pole `user_id` w tabeli `flashcards` odnosi się do `users.id`).

## 3. Indeksy

- Indywidualny indeks na kolumnie `flashcards.user_id` (optymalizacja zapytań wyszukujących fiszki danego użytkownika).
- Indeks na kolumnie `flashcards.status`.
- Opcjonalnie, indeks kompozytowy na `(user_id, status)` dla dalszej optymalizacji zapytań.

## 4. Zasady PostgreSQL i mechanizmy bezpieczeństwa

### 4.1 Row Level Security (RLS)

Dla tabeli `flashcards` należy włączyć RLS i ustawić następujące polityki:

```sql
ALTER TABLE flashcards ENABLE ROW LEVEL SECURITY;

CREATE POLICY select_flashcards ON flashcards
FOR SELECT USING (user_id = current_setting('request.jwt.claim.sub')::uuid);

CREATE POLICY modify_flashcards ON flashcards
FOR ALL USING (user_id = current_setting('request.jwt.claim.sub')::uuid);
```

### 4.2 Trigger do aktualizacji kolumny `updated_at`

Funkcja i trigger zapewniają automatyczną aktualizację kolumny `updated_at` przy każdej modyfikacji rekordu:

```sql
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_flashcards_updated_at
BEFORE UPDATE ON flashcards
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();
```

## 5. Dodatkowe uwagi

- Schemat jest zgodny z wymaganiami MVP: przechowywane są wyłącznie finalne fiszki, bez przechowywania oryginalnych tekstów źródłowych.
- Mechanizm autoryzacji oraz RLS gwarantują, że użytkownik ma dostęp jedynie do swoich danych.
- Indeksy zostały zaprojektowane w celu optymalizacji zapytań opartych o `user_id` i `status`.
- Struktura bazy danych została zaprojektowana zgodnie z zasadami normalizacji (3NF) i najlepszymi praktykami projektowania baz danych.
