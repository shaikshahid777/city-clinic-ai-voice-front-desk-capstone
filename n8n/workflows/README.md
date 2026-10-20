# n8n Workflows

Export the 4 published workflows from n8n and save them in this folder:

| Workflow | File name | Webhook path |
|---|---|---|
| Capstone - Check Availability | `check-availability.json` | `POST /webhook/check-availability` |
| Capstone - Book Appointment | `book-appointment.json` | `POST /webhook/book-appointment` |
| Capstone - Register DNC | `register-dnc.json` | `POST /webhook/register-dnc` |
| Capstone - Post Call Webhook | `post-call-webhook.json` | `POST /webhook/retell-postcall` |

How to export: open the workflow -> top-right `...` menu -> **Download**.
Credentials (Google Calendar, Postgres) are not included in exports, so no secrets are exposed.
