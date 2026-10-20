<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=240&section=header&text=AI%20Voice%20Front%20Desk&fontSize=56&fontAlignY=36&animation=fadeIn&desc=City%20Clinic%20%7C%20Booking%20%7C%20CRM%20%7C%20Transfers%20%7C%20Analytics&descAlignY=58&descSize=18" alt="AI Voice Front Desk banner" width="100%"/>

[![Retell AI](https://img.shields.io/badge/Retell_AI-Voice_Agent-7C3AED?style=for-the-badge)](https://www.retellai.com/)
[![n8n](https://img.shields.io/badge/n8n-Automation-EA4B71?style=for-the-badge&logo=n8n&logoColor=white)](https://n8n.io/)
[![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)
[![Google Calendar](https://img.shields.io/badge/Google_Calendar-Integration-4285F4?style=for-the-badge)](https://calendar.google.com/)

[![Watch Loom Demo](https://img.shields.io/badge/▶%20Watch%20Demo-Loom-625DF5?style=for-the-badge)](https://www.loom.com/share/63fca9a9bcb541cfac3035be2508d572)

</div>

# AI Voice Front Desk — City Clinic Capstone

An AI-powered inbound voice front desk for a fictional clinic. The project demonstrates how voice agents, workflow automation, a PostgreSQL CRM, and a calendar integration can work together to support common front-desk tasks.

## LMS Submission Description

**Project:** AI Voice Front Desk — City Clinic  
**Demo video:** [Watch the Loom recording](https://www.loom.com/share/63fca9a9bcb541cfac3035be2508d572)  
**Source code:** [GitHub repository](https://github.com/shaikshahid777/city-clinic-ai-voice-front-desk-capstone)

This capstone uses Retell AI for conversational voice agents, n8n for webhook-based automation, Supabase Postgres for CRM and appointment records, and Google Calendar for appointment scheduling. The Front Desk agent answers common questions using the City Clinic FAQ knowledge base, checks availability, books appointments, transfers billing calls with handoff context, registers Do-Not-Call requests, and applies configured emergency escalation rules. Retell post-call analysis sends call outcomes through an n8n webhook for storage in Supabase.

The repository contains the agent prompts and tool definitions, database schema and queries, n8n workflow exports, setup documentation, test scenarios, and architecture notes. The demo video presents the project architecture and example call flows. Results should be evaluated against the actual executions and records shown in the demo.

## Project Goals

- Build a conversational front desk for common clinic phone requests.
- Connect voice-agent functions to n8n workflows and external services.
- Store leads, appointment records, and call outcomes in Supabase Postgres.
- Sync appointment bookings with Google Calendar.
- Preserve caller context when transferring to a specialist.
- Respect opt-out requests and apply the configured crisis escalation rule.
- Capture post-call summaries, sentiment, and outcomes for review.

## Main Features

| Feature | Description |
|---|---|
| FAQ assistance | Answers common clinic questions from the City Clinic FAQ knowledge base. |
| Availability check | Uses the `check_calendar_availability` function and the availability workflow. |
| Appointment booking | Uses `book_appointment` to record appointments and create calendar events. |
| Specialist transfer | Routes billing calls to the Billing Specialist with handoff context. |
| Do-Not-Call | Handles opt-out requests through `register_dnc_optout`. |
| Emergency escalation | Applies the configured 911 guidance and nurse-transfer rule for crisis scenarios. |
| Post-call analytics | Sends `call_analyzed` results to n8n and stores call outcomes in Supabase. |
| Double-booking protection | Uses a database unique constraint on booking date and time. |

## Technology Stack

- **Retell AI:** Voice agents, prompts, custom functions, knowledge base, transfers, and post-call analysis.
- **n8n:** Four workflows for availability, booking, DNC registration, and post-call webhook processing.
- **Supabase Postgres:** CRM leads, appointments, and call outcomes.
- **Google Calendar:** Appointment scheduling and calendar event visibility.

## Agents

1. **City Clinic Front Desk** — handles general questions, availability, booking, opt-out, and routing.
2. **City Clinic Billing Specialist** — handles billing-related requests after transfer.
3. **City Clinic Triage Nurse** — receives triage and configured emergency escalations.

## Database Tables

| Table | Purpose |
|---|---|
| `capstone_crm_leads` | Caller contact details and DNC status. |
| `capstone_appointments` | Appointment records and unique slot constraint. |
| `capstone_call_outcomes` | Call identifiers, summary, sentiment, outcome, and related analysis data. |

## n8n Workflows

1. **Capstone - Check Availability**
2. **Capstone - Book Appointment**
3. **Capstone - Register DNC**
4. **Capstone - Post Call Webhook**

The workflow exports and setup guidance are available in the repository. Connections require your own service credentials, which must be stored securely and never committed to GitHub.

## Demo Walkthrough

The Loom demo is intended to show:
1. The project components and overall architecture.
2. The Retell Front Desk prompt, functions, and knowledge base.
3. A sample FAQ request and appointment-booking flow.
4. A billing transfer with caller context.
5. A Do-Not-Call request and its database status.
6. Post-call analytics and the database records.
7. The emergency escalation rule and double-booking constraint.

## Repository Contents

- `database/` — SQL schema and queries.
- `retell/prompts/` — prompts for the three agents.
- `retell/tools/` — custom-function and transfer definitions.
- `retell/knowledge_base/` — FAQ content.
- `n8n/workflows/` — workflow exports.
- `n8n/sample_payloads/` — example webhook payloads.
- `docs/` — architecture, setup guide, test cases, and limitations.
- `assets/screenshots/` — project evidence screenshots.

## Setup Overview

1. Run `database/schema.sql` in the Supabase SQL Editor.
2. Configure Supabase/Postgres and Google Calendar credentials in n8n.
3. Import the workflow JSON files and set the required environment-specific URLs.
4. Configure the three Retell agents with the prompts and tool definitions.
5. Attach the FAQ knowledge base and configure post-call analysis and the webhook.
6. Run test calls, then verify the matching n8n execution, Supabase rows, and Google Calendar event.

See [docs/setup-guide.md](docs/setup-guide.md) for the fuller setup procedure.

## Challenges and Limitations

- An SSL certificate issue occurred during the Supabase-to-n8n connection setup.
- Agent-swap variables required a separate handoff-variable extraction approach.
- Transfer latency measurement and webhook signature verification need further improvement.
- External service availability, credentials, and configuration affect end-to-end behavior.
- The emergency rule is a demonstration configuration and is not a substitute for a real clinic's reviewed clinical and emergency procedures.

See [docs/challenges-and-limitations.md](docs/challenges-and-limitations.md) for additional details.

## LMS Submission Checklist

- [x] Public GitHub repository
- [x] Project README and setup overview
- [x] Loom demo link
- [ ] Confirm all demo claims against current live execution records before final assessment submission
- [ ] Attach an exported PDF of the project documentation if the LMS specifically requires a PDF upload

## Author

**Shaik Shahid**  
GitHub: [shaikshahid777](https://github.com/shaikshahid777)

---

*Educational portfolio project. Use synthetic test data only. Do not store real patient information or credentials in this repository.*
