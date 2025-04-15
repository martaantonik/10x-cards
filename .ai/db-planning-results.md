<conversation_summary>
<decisions>
1. Tabela użytkowników pozostaje bez dodatkowych danych – korzystamy wyłącznie z mechanizmu uwierzytelniania Supabase.  
2. Tabela flashcards będzie zawierać następujące atrybuty:  
   - id: UUID (klucz główny)  
   - user_id: UUID (klucz obcy odnoszący się do tabeli użytkowników)  
   - front: VARCHAR(500) NOT NULL  
   - back: VARCHAR(500) NOT NULL  
   - status: VARCHAR(50) NOT NULL, z ograniczeniem CHECK dopuszczającym wartości 'pending', 'accepted' lub 'rejected'  
   - known: BOOLEAN NOT NULL DEFAULT false  
   - created_at: timestamptz NOT NULL DEFAULT now()  
   - updated_at: timestamptz NOT NULL DEFAULT now()  
3. Przechowywane będą jedynie finalne fiszki – oryginalny tekst źródłowy nie będzie przechowywany, a fiszki nie będą powiązane w grupy (batch).  
4. Nie przewidujemy osobnej tabeli sesji nauki ani szczegółowego rejestrowania dat powtórek – wystarczy informacja, czy użytkownik zna daną fiszkę.  
5. Integralność danych zapewnimy poprzez zastosowanie ograniczeń NOT NULL, CHECK constraints dla kolumny status oraz triggera do aktualizacji kolumny updated_at przy modyfikacji rekordu.  
6. Prosta strategia indeksowania: utworzenie indeksów na kolumnach user_id i status, ewentualnie indeks kompozytowy na (user_id, status) dla optymalizacji zapytań.  
7. Zasady RLS zostaną wdrożone na podstawie kolumny user_id, ograniczając dostęp do rekordów tylko do właściciela (przy użyciu current_setting('request.jwt.claim.sub')::uuid).  
</decisions>

<matched_recommendations>
1. Utworzenie tabeli flashcards z odpowiednimi kolumnami oraz ograniczeniami (NOT NULL i CHECK constraints) zgodnie z wymaganiami.  
2. Zastosowanie triggera do automatycznej aktualizacji kolumny updated_at.  
3. Implementacja prostych indeksów na user_id i status lub indeksu kompozytowego dla optymalizacji zapytań.  
4. Wdrożenie zasad RLS opartych wyłącznie na user_id, aby zapewnić bezpieczeństwo danych.  
</matched_recommendations>

<database_planning_summary>
Główne wymagania dotyczące schematu bazy danych obejmują minimalną strukturę opartą na mechanizmie Supabase bez dodatkowych pól użytkownika, przy czym kluczową encją jest tabela flashcards. Tabela flashcards zawiera atrybuty: id, user_id, front, back, status, known, created_at oraz updated_at. W relacjach każda fiszka jest powiązana z użytkownikiem poprzez user_id. Ważne kwestie dotyczące bezpieczeństwa i skalowalności obejmują zastosowanie RLS, które ogranicza dostęp do danych na podstawie user_id, oraz prostą strategię indeksowania (indeksy na user_id i status) dla optymalizacji zapytań. Dodatkowo, integralność danych zostanie zapewniona przez ograniczenia (NOT NULL, CHECK) oraz trigger do automatycznej aktualizacji updated_at.  
</database_planning_summary>

<unresolved_issues>
Nie zidentyfikowano żadnych nierozwiązanych kwestii – wszystkie aspekty modelu bazy danych zostały omówione i uzgodnione zgodnie z wymaganiami MVP.
</unresolved_issues>
</conversation_summary>
