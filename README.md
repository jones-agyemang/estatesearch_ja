# Legal Advice Q&A Board
Legal Advice Q&A Board is a Rails application for legal queries. Users can register, raise questions, and review responses. Lawyers can register(for verification purposes), view open questions, submit responses with a fee, and trigger a payment request. A user approves payment to unlock a response and mark the question as answered.

## Demo: Access
The live demo is deployed on Render here: [Legal Q&A Board - Production](https://legal-board-qpia.onrender.com/).

#### Access
To view existing questions and responses use the following credentials to assume a the role of a "user" or a "lawyer"

**User:**
- Email: john.doe@example.com
- Password: t0ps3kr3t

**Lawyer:**
- Email: lawyer.jane.doe@example.com
- Password: utm05ts3kr3t

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
- Kamal, Docker, Puma, and Thruster for production deployment support

## Domain Model

- `User`: Devise account that owns submitted questions.
- `Lawyer`: STI subclass of `User`; owns responses and payment requests.
- `Question`: belongs to a user, has many lawyer responses, and tracks `open`, `answered`, or `closed` status.
- `Response`: belongs to a lawyer and a question, stores the response body, quoted fee, and paid state.
- `PaymentRequest`: belongs to a lawyer and a response; represents the simulated payment request created when a lawyer submits a response.

## Main Workflows

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
- Implementation
    - Extract approve payment action into a separate controller, i.e., payment controller
    - 
- Design
    - 
- Database
    - database migration files should have been committed separately from other changes to ensure fast, enforceable recovery action in case co-shipped changes break and code-specific rollback has a bearing on perfectly fine DB migration changes that could/should have been shipped independently 
    
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

The development database is `estatesearch_ja_development`; the test database is `estatesearch_ja_test`.

## Database

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
bin/rails db:seed
```

## Testing

Run the RSpec suite:

```bash
bundle exec rspec
```

Run the Cucumber feature suite:

```bash
bin/cucumber
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
bin/rubocop
```

Run Brakeman:

```bash
bin/brakeman
```

## Deployment
This application is deployed using Render. Commits to the `main` [branch](https://github.com/jones-agyemang/estatesearch_ja) triggers deployment to [Legal Q&A Board - Production](https://legal-board-qpia.onrender.com/).