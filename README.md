# Legal Advice Q&A Board
Legal Advice Q&A Board is a Rails application for legal queries. Users can register, submit questions, and review responses. Lawyers can register for verification purposes, view open questions, submit responses with a fee, and trigger a payment request. A user approves payment to unlock a response and mark the question as answered.

## Demo: Access
The live demo is deployed on Render here: [Legal Q&A Board - Production](https://legal-board-qpia.onrender.com/).

#### Access
To view existing questions and responses, use the following credentials for either the user or lawyer role.

**User:**
- Email: john.doe@example.com
- Password: t0ps3kr3t

**Lawyer:**
- Email: lawyer.jane.doe@example.com
- Password: utm05ts3kr3t

[READ the QA notes for step by step guidance for exploratory tests.](docs/QA_notes.MD)

_**Note**: These accounts are for demo purposes only. They are insecure and should not be used for recording sensitive questions or responses._ 

### Core Features

Users can:

- Submit a legal question with a `title`, `body`, and `category`.
- View a list of their submitted questions.
- Track each question's status: `open`, `answered`, or `closed`.
- See lawyer responses only after the simulated payment has been approved.

Lawyers can:

- View open legal questions.
- Submit a paid answer with response text and a proposed fee, for example `£20`.

Payment flow:

- When a lawyer answers, the system creates a simulated payment request for the user.
- The user approves the payment request to unlock the lawyer's answer.
- Once approved, the answer is marked as paid and the question is marked as answered.

## Tech Stack

- Ruby on Rails 8.0.5
- PostgreSQL
- Devise authentication
- Rails single-table inheritance for `User` and `Lawyer`
- Hotwire-ready Rails defaults with Turbo, Stimulus, Importmap, and Propshaft
- RSpec, FactoryBot, Shoulda Matchers, Capybara, and Cucumber for tests
- RuboCop Rails Omakase and Brakeman for code quality/security checks
- Render for production deployment

## Domain Model

- `User`: Devise account that owns submitted questions.
- `Lawyer`: STI subclass of `User`; owns responses and payment requests.
- `Question`: belongs to a user, has many lawyer responses, and tracks `open`, `answered`, or `closed` status.
- `Response`: belongs to a lawyer and a question, stores the response body, quoted fee, and paid state.
- `PaymentRequest`: belongs to a lawyer and a response; represents the simulated payment request created when a lawyer submits a response.

## Main Journeys

### User query flow

1. A user registers or signs in.
2. The dashboard resolver sends standard users to `/users/dashboard`.
3. The user raises a query with title, body, and category.
4. The question starts with `open` status.
5. The user dashboard lists the user's own questions and any responses.
6. Unpaid responses are hidden behind an approval action.
7. Approving payment marks the response as paid and the question as answered.

### Lawyer response flow

1. A lawyer signs in through Devise using a `users.type` value of `Lawyer`.
2. The dashboard resolver sends lawyers to `/lawyers/dashboard`.
3. The lawyer dashboard lists open questions.
4. The lawyer submits a response and fee.
5. The app creates the response and matching payment request in one database transaction.

## Future Improvements

### Functionality

- Replace the lightweight `format_currency` helper with a more robust currency formatting approach that can support multiple currencies and locale-specific formatting.
- Add row-level locking around payment approval and response creation to prevent races where a lawyer submits a response while payment approval is transitioning the question to `answered`.

### Architecture

- Extract response creation into a service object, matching the payment approval flow.
- Keep payment approval and response creation responsible for their own transactional boundaries, including question state checks.

### Hotwire

- Use Turbo Streams to refresh a user's dashboard when a lawyer responds to one of their open questions. This would provide a useful real-time update before introducing explicit notification features.

### UI/UX & Design

- Improve lawyer question discovery so older open questions do not get buried behind the latest submissions.
- Consider sorting or prioritisation options such as oldest unanswered, category, or time since submission.

### Testing

- Keep Cucumber scenarios readable as workflow documentation for non-technical stakeholders.
- Add browser-level coverage with Playwright or Cypress for critical user and lawyer journeys.
- Add concurrency-focused tests around payment approval and response creation once row-level locking is introduced.

### Deployment

- Add a staging environment before production deployment.

### Database

- Keep database migrations in focused commits where possible, so schema changes can be reviewed, deployed, and rolled back independently from unrelated application code.

## Stretch Goals
- Used Rails STI to model `Lawyer` as a subtype of `User`, rather than relying on a simple simulated role flag. Makes for clearner authentication and authorization
- Included role-aware registration for `Lawyers` and `Users`
- Enforced role-restricted access to prevent authenticated users gaining exposure to lawyers' dashboard
- Added owner-only payment approval
- Extracted payment approval into a service object to preserve domain logic and keep controllers thin
- Added Turbo Stream support for payment approval, allowing user dashboard to reveal hidden response in place after payment is approved
- Added TailwindCSS styling and clearer dashboard formatting for questions, responses, payment status and role-specific views
- Used Cucumber feature specs alongside RSpec to document essential user and lawyer journeys in a stakeholder-readable format

## Routes

Important routes include:

```text
/                         dashboards#show
/dashboard                dashboards#show
/users/dashboard          users/dashboards#show
/lawyers/dashboard        lawyers/dashboards#show
/users/:user_id/questions user-scoped question creation
/questions/:question_id/responses
/questions/:question_id/responses/:id/approve_payment
/up                       Rails health check
```

Devise provides the registration, session, password reset, and account routes.

## Setup

Install Ruby, Bundler, and PostgreSQL, then run:

```bash
bin/setup
```

`bin/setup` installs gems, prepares the database, clears logs/temp files, and starts the development server unless `--skip-server` is passed.

To prepare without starting the server:

```bash
bin/setup --skip-server
```

To start the app later:

```bash
bin/dev
```

OR

```bash
bundle exec rails server
```

## Database
The development database is `estatesearch_ja_development`; the test database is `estatesearch_ja_test`.

Create and prepare the database with:

```bash
bin/rails db:prepare
```

Run migrations with:

```bash
bin/rails db:migrate
```

Load the schema into a fresh database with:

```bash
bin/rails db:schema:load
```

Seed the database to get started quickly

```bash
bundle exec rails db:seed
```

## Testing

Run the RSpec suite:

```bash
bundle exec rspec
```

Run the Cucumber feature suite:

```bash
bundle exec cucumber
```

Current coverage includes:

- Devise registration and login
- User question creation and validation
- User and lawyer dashboard routing
- Lawyer response creation
- Payment request creation
- Payment approval and response unlock flow
- Model associations and validations

## Code Quality

Run RuboCop:

```bash
bundle exec rubocop
```

Run Brakeman:

```bash
bundle exec brakeman
```

## Deployment
This application is deployed using Render. Commits to the `main` [branch](https://github.com/jones-agyemang/estatesearch_ja) trigger deployment to [Legal Q&A Board - Production](https://legal-board-qpia.onrender.com/).
