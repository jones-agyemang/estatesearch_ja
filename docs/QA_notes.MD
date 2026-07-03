**QA Notes**

**Build/Test Status**
- `bundle exec rspec`: passed, **41 examples, 0 failures**
- `bundle exec cucumber`: passed, **13 scenarios, 43 steps, 0 failures**
- Working tree status check returned no output before test execution, so no uncommitted changes were visible at that point.

**Primary Manual QA Paths**
- User registration/sign-in:
  - Register or sign in as a standard user.
  - Confirm user lands on `/users/dashboard`.
  - Confirm user can submit a question with title, body, and category.
  - Confirm invalid question submissions show validation feedback.

- Lawyer registration/sign-in:
  - Register or sign in as a lawyer.
  - Confirm lawyer lands on `/lawyers/dashboard`.
  - Confirm lawyer can see open questions.
  - Confirm answered/closed questions are not shown as open work.

- Lawyer response flow:
  - As a lawyer, open an available question.
  - Submit a response with a fee.
  - Confirm a payment request is created.
  - Confirm the lawyer returns to the lawyer dashboard with a success message.

- Payment approval flow:
  - As the question owner, view the user dashboard.
  - Confirm unpaid responses are hidden.
  - Approve payment.
  - Confirm the response body is revealed.
  - Confirm the response is marked paid.
  - Confirm the question status changes to answered.
  - Confirm the Turbo Stream path updates the dashboard in place.

- Access control:
  - Confirm unauthenticated users are redirected to sign-in.
  - Confirm standard users cannot access the lawyer dashboard.
  - Confirm payment approval is only allowed for the question owner.

**Automated Coverage Present**
- Model associations and validations.
- Devise registration/login flows.
- User question creation and validation.
- User/lawyer dashboard routing.
- Lawyer response creation.
- Payment request creation.
- Payment approval and answer unlock.
- Query object behavior for user vs lawyer question retrieval.
- Payment approval service behavior, including non-owner rejection.

**Known Residual Risks**
- Row-level locking is not yet implemented, so there is a known concurrency risk between payment approval and delayed lawyer response creation.
- Currency formatting is lightweight and assumes a simple display format.
- No browser-level Playwright/Cypress suite yet.
- Turbo Stream payment behavior exists, but should stay covered by request specs if not already present in the current branch.
- Real-time user dashboard refresh when a lawyer submits a response is listed as a future improvement, not current behavior.

**Recommended Final Smoke Test**
- Open the deployed Render app.
- Sign in with demo user and lawyer accounts from the README.
- Submit a new user question.
- Answer it as a lawyer.
- Approve payment as the user.
- Confirm the answer unlocks and the question is answered.