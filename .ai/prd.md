# Dokument wymagań produktu (PRD) - 10x Cards

## 1. Przegląd produktu

10x Cards to aplikacja webowa umożliwiająca szybkie tworzenie fiszek edukacyjnych z wykorzystaniem sztucznej inteligencji. Głównym celem aplikacji jest przyspieszenie procesu tworzenia fiszek poprzez automatyczne generowanie ich z wprowadzonego tekstu. Aplikacja skierowana jest do indywidualnych użytkowników, głównie studentów, którzy chcą efektywnie uczyć się z wykorzystaniem metody powtórek (spaced repetition).

Aplikacja pozwala na:
- Generowanie fiszek przez AI na podstawie wprowadzonego tekstu
- Ręczne tworzenie fiszek
- Przeglądanie, edycję i usuwanie istniejących fiszek
- Naukę z wykorzystaniem algorytmu powtórek

Projekt jest planowany jako prototyp edukacyjny do zrealizowania w ciągu 2 tygodni.

## 2. Problem użytkownika

Manualne tworzenie wysokiej jakości fiszek edukacyjnych jest czasochłonne, co zniechęca użytkowników do korzystania z efektywnej metody nauki jaką jest spaced repetition. Studenci często rezygnują z tworzenia własnych fiszek z powodu:

- Dużego nakładu czasu potrzebnego na przetworzenie materiału źródłowego
- Trudności w wyodrębnieniu kluczowych informacji z dużych partii tekstu
- Problemów z formułowaniem zwięzłych i efektywnych treści fiszek

10x Cards rozwiązuje ten problem poprzez automatyzację procesu generowania fiszek, co znacząco przyspiesza tworzenie materiałów do nauki przy zachowaniu ich wysokiej jakości.

## 3. Wymagania funkcjonalne

### 3.1 Uwierzytelnianie i zarządzanie kontem
- Rejestracja nowych użytkowników
- Logowanie do systemu
- Wylogowywanie z systemu

### 3.2 Zarządzanie fiszkami
- Dodawanie tekstu źródłowego (kopiuj-wklej) do generowania fiszek
- Automatyczne generowanie 10 fiszek z tekstu o długości około 1000 znaków
- Akceptacja lub odrzucenie wygenerowanych fiszek
- Ręczne tworzenie fiszek
- Edycja istniejących fiszek
- Usuwanie fiszek

### 3.3 Nauka
- Przeglądanie fiszek w sesji nauki
- Oznaczanie fiszek jako opanowane/nieopanowane
- Śledzenie postępów nauki

### 3.4 Interfejs użytkownika
- Trzy przyciski: "Generuj", "Moje fiszki", "Nauka"
- Intuicyjny interfejs do akceptacji/odrzucania fiszek

## 4. Granice produktu

W zakres MVP nie wchodzą następujące funkcjonalności:
- Własny, zaawansowany algorytm powtórek (zostanie wykorzystane gotowe rozwiązanie)
- Import wielu formatów (PDF, DOCX, itp.) - wyłącznie metoda kopiuj-wklej
- Współdzielenie zestawów fiszek między użytkownikami
- Integracje z innymi platformami edukacyjnymi
- Organizowanie fiszek w kolekcje/tagi
- Eksport fiszek do innych formatów
- Aplikacje mobilne (wyłącznie wersja webowa)

## 5. Historyjki użytkowników

### US-001: Rejestracja użytkownika
- Tytuł: Rejestracja nowego konta użytkownika
- Opis: Jako nowy użytkownik, chcę móc zarejestrować się w aplikacji, aby korzystać z systemu fiszek.
- Kryteria akceptacji:
  - Użytkownik może wypełnić formularz rejestracji z polami: email, hasło, potwierdzenie hasła
  - System waliduje poprawność adresu email
  - Po udanej rejestracji użytkownik otrzymuje powiadomienie o utworzeniu konta
  - W przypadku błędów walidacji, użytkownik otrzymuje jasne komunikaty o problemach

### US-002: Logowanie użytkownika
- Tytuł: Logowanie do aplikacji
- Opis: Jako zarejestrowany użytkownik, chcę móc zalogować się do aplikacji, aby uzyskać dostęp do moich fiszek.
- Kryteria akceptacji:
  - Użytkownik może wprowadzić email i hasło
  - System weryfikuje poprawność danych logowania
  - Po udanym logowaniu użytkownik jest przekierowany do głównego interfejsu aplikacji
  - W przypadku niepoprawnego logowania, użytkownik otrzymuje komunikat o błędzie

### US-003: Wylogowanie użytkownika
- Tytuł: Wylogowanie z aplikacji
- Opis: Jako zalogowany użytkownik, chcę móc wylogować się z aplikacji, aby zabezpieczyć moje dane.
- Kryteria akceptacji:
  - Dostępna jest opcja wylogowania z aplikacji
  - Po wylogowaniu użytkownik jest przekierowany do strony logowania
  - Po wylogowaniu, dostęp do danych użytkownika jest blokowany

### US-004: Dodawanie tekstu źródłowego
- Tytuł: Wprowadzanie tekstu do generowania fiszek
- Opis: Jako zalogowany użytkownik, chcę móc wprowadzić tekst źródłowy, aby wygenerować z niego fiszki.
- Kryteria akceptacji:
  - Dostępne jest pole tekstowe do wprowadzenia tekstu (minimum 10000 znaków)
  - Istnieje przycisk "Generuj fiszki"
  - Wyświetlany jest licznik znaków
  - System informuje, jeśli tekst jest zbyt krótki

### US-005: Generowanie fiszek przez AI
- Tytuł: Automatyczne generowanie fiszek
- Opis: Jako zalogowany użytkownik, chcę aby system automatycznie generował fiszki z wprowadzonego przeze mnie tekstu, aby zaoszczędzić czas.
- Kryteria akceptacji:
  - System generuje 10 fiszek z tekstu o długości około 10000 znaków
  - Każda fiszka zawiera dwa pola: przód i tył
  - Po zakończeniu generowania, system wyświetla wygenerowane fiszki
  - W przypadku błędu, system wyświetla komunikat o niepowodzeniu

### US-006: Akceptacja lub odrzucenie wygenerowanych fiszek
- Tytuł: Weryfikacja wygenerowanych fiszek
- Opis: Jako zalogowany użytkownik, chcę móc przeglądać wygenerowane fiszki i akceptować lub odrzucać każdą z nich, aby zachować tylko te, które są dla mnie wartościowe.
- Kryteria akceptacji:
  - Dla każdej wygenerowanej fiszki dostępne są przyciski "Akceptuj" i "Odrzuć"
  - Zaakceptowane fiszki są zapisywane w bazie danych użytkownika
  - Odrzucone fiszki są usuwane
  - Wyświetlana jest informacja o liczbie zaakceptowanych/odrzuconych fiszek

### US-007: Ręczne tworzenie fiszek
- Tytuł: Manualne dodawanie fiszek
- Opis: Jako zalogowany użytkownik, chcę móc ręcznie tworzyć fiszki, aby dodać własne materiały edukacyjne.
- Kryteria akceptacji:
  - Dostępny jest formularz do tworzenia nowej fiszki z polami: przód i tył
  - Istnieje przycisk "Zapisz fiszkę"
  - Po zapisaniu, fiszka pojawia się w sekcji "Moje fiszki"
  - System informuje o pomyślnym dodaniu fiszki

### US-008: Przeglądanie własnych fiszek
- Tytuł: Przeglądanie zapisanych fiszek
- Opis: Jako zalogowany użytkownik, chcę móc przeglądać wszystkie moje zapisane fiszki, aby mieć do nich łatwy dostęp.
- Kryteria akceptacji:
  - W sekcji "Moje fiszki" wyświetlana jest lista wszystkich fiszek użytkownika
  - Fiszki prezentowane są w formie listy lub siatki
  - Dla każdej fiszki widoczny jest przód (tył dostępny po kliknięciu/najechaniu)
  - Istnieje możliwość filtrowania/sortowania fiszek

### US-009: Edycja istniejących fiszek
- Tytuł: Modyfikacja zawartości fiszek
- Opis: Jako zalogowany użytkownik, chcę móc edytować treść moich fiszek, aby poprawiać i aktualizować ich zawartość.
- Kryteria akceptacji:
  - Dla każdej fiszki dostępna jest opcja edycji
  - Po wybraniu opcji edycji, wyświetlany jest formularz z bieżącą treścią fiszki
  - Istnieje możliwość modyfikacji pól: przód i tył
  - Po zapisaniu zmian, fiszka jest aktualizowana w bazie
  - System informuje o pomyślnym zaktualizowaniu fiszki

### US-010: Usuwanie fiszek
- Tytuł: Usuwanie niepotrzebnych fiszek
- Opis: Jako zalogowany użytkownik, chcę móc usuwać fiszki, których już nie potrzebuję.
- Kryteria akceptacji:
  - Dla każdej fiszki dostępna jest opcja usunięcia
  - Przed usunięciem wyświetlane jest pytanie potwierdzające
  - Po potwierdzeniu, fiszka jest trwale usuwana z bazy
  - System informuje o pomyślnym usunięciu fiszki

### US-011: Rozpoczynanie sesji nauki
- Tytuł: Rozpoczęcie nauki z fiszkami
- Opis: Jako zalogowany użytkownik, chcę móc rozpocząć sesję nauki z moimi fiszkami, aby efektywnie się uczyć.
- Kryteria akceptacji:
  - W sekcji "Nauka" dostępny jest przycisk "Rozpocznij naukę"
  - Po rozpoczęciu nauki, system wybiera fiszki według algorytmu powtórek
  - Fiszki prezentowane są pojedynczo w formie kart
  - Istnieje możliwość przejścia do następnej fiszki

### US-012: Oznaczanie fiszek jako opanowane
- Tytuł: Ocenianie znajomości fiszek podczas nauki
- Opis: Jako zalogowany użytkownik, chcę móc oznaczać fiszki jako opanowane lub nieopanowane podczas nauki, aby śledzić moje postępy.
- Kryteria akceptacji:
  - Podczas sesji nauki dla każdej fiszki dostępne są opcje: "Znam" i "Nie znam"
  - Wybór opcji jest zapisywany w systemie
  - Na podstawie wyborów, algorytm powtórek dostosowuje kolejność pokazywania fiszek
  - Po zakończeniu sesji wyświetlane jest podsumowanie

## 6. Metryki sukcesu

### 6.1 Metryki jakości generowanych fiszek
- 75% fiszek wygenerowanych przez AI jest akceptowane przez użytkownika

### 6.2 Metryki użytkowania
- Użytkownicy tworzą 75% swoich fiszek z wykorzystaniem funkcji AI

Wszystkie te metryki będą mierzone poprzez analizę działań użytkowników w aplikacji, ze szczególnym uwzględnieniem wskaźnika akceptacji fiszek wygenerowanych przez AI. 