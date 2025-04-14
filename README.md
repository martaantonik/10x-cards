# 10x Cards

## Project Description

10x Cards is a web application that allows users (primarily students) to quickly generate educational flashcards using artificial intelligence. The application streamlines the process of creating high-quality flashcards from input text. Users can also manually create, edit, and delete flashcards, and engage in study sessions that utilize a spaced repetition algorithm.

## Tech Stack

- **Frontend:** Astro 5, React 19, TypeScript 5, Tailwind CSS 4, Shadcn/ui
- **Backend:** Supabase for a PostgreSQL database and backend-as-a-service functionalities
- **AI Integration:** Openrouter.ai for communication with various models (OpenAI, Anthropic, etc.)
- **CI/CD & Hosting:** GitHub Actions for CI/CD pipelines and DigitalOcean for hosting

## Getting Started Locally

1. Ensure you have the correct Node.js version as specified in the `.nvmrc` file (22.14.0):
   ```bash
   nvm use
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the development server:
   ```bash
   npm run dev
   ```

## Available Scripts

- `npm run dev` – Starts the Astro development server.
- `npm run build` – Builds the project for production.
- `npm run preview` – Serves the built project for preview.
- `npm run astro` – Runs Astro-related commands.
- `npm run lint` – Runs ESLint to check for code issues.
- `npm run lint:fix` – Automatically fixes ESLint issues.
- `npm run format` – Formats the code using Prettier.

## Project Scope

The project focuses on providing a streamlined experience for creating and studying flashcards. Key features include:

- **Authentication:** User registration, login, and logout.
- **Flashcard Management:** Create flashcards both manually and through AI-powered generation from user-provided text.
- **Review System:** Study sessions with flashcards using a spaced repetition algorithm, including marking flashcards as mastered or not.
- **Editing & Deletion:** Users can edit or delete flashcards as needed.

## Project Status

This project is currently in the prototype phase, aimed at demonstrating the concept and gathering feedback for future improvements.

## License

This project is licensed under the MIT License.
