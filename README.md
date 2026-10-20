<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=240&section=header&text=AI%20Voice%20Front%20Desk&fontSize=56&fontAlignY=36&animation=fadeIn&desc=City%20Clinic%20%7C%20Booking%20%7C%20CRM%20%7C%20Transfers%20%7C%20Analytics&descAlignY=58&descSize=18" alt="AI Voice Front Desk banner" width="100%"/>

<a href="https://github.com/shaikshahid777/city-clinic-ai-voice-front-desk-capstone">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&pause=1200&color=36BCF7&center=true&vCenter=true&width=760&lines=Production-grade+inbound+voice+agent;Triage+%E2%86%92+FAQ+%E2%86%92+Booking+%E2%86%92+Handoff;Retell+AI+%2B+n8n+%2B+Supabase+%2B+Google+Calendar;Compliance+gates%3A+Crisis+routing+%26+Do-Not-Call" alt="Typing animation"/>
</a>

<br/>

[![Retell AI](https://img.shields.io/badge/Retell_AI-Voice_Agent-7C3AED?style=for-the-badge&logoColor=white)](https://www.retellai.com/)
[![n8n](https://img.shields.io/badge/n8n-Automation-EA4B71?style=for-the-badge&logo=n8n&logoColor=white)](https://n8n.io/)
[![Supabase](https://img.shields.io/badge/Supabase-PostgreSQL-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)
[![Google Calendar](https://img.shields.io/badge/Google-Calendar-4285F4?style=for-the-badge&logo=googlecalendar&logoColor=white)](https://calendar.google.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-CRM-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)

![Status](https://img.shields.io/badge/status-capstone_complete-success?style=flat-square)
![License](https://img.shields.io/badge/license-MIT-blue?style=flat-square)
![Agents](https://img.shields.io/badge/agents-3-orange?style=flat-square)
![Workflows](https://img.shields.io/badge/n8n_workflows-4-ff6d5a?style=flat-square)
![Tables](https://img.shields.io/badge/db_tables-3-336791?style=flat-square)

<br/>

<a href="https://www.loom.com/share/63fca9a9bcb541cfac3035be2508d572"><img src="https://img.shields.io/badge/%E2%96%B6%20Watch%20Demo%20Video-Loom-625DF5?style=for-the-badge&logo=loom&logoColor=white" alt="Watch demo"/></a>
<a href="#-architecture"><img src="https://img.shields.io/badge/%F0%9F%8F%97%20Architecture-View-0EA5E9?style=for-the-badge" alt="Architecture"/></a>
<a href="#-test-results"><img src="https://img.shields.io/badge/%E2%9C%85%20Test%20Results-See-22C55E?style=for-the-badge" alt="Tests"/></a>
<a href="#-quick-start"><img src="https://img.shields.io/badge/%F0%9F%9A%80%20Quick%20Start-Setup-F59E0B?style=for-the-badge" alt="Quick start"/></a>

</div>

---

## 📌 Overview

**AI Voice Front Desk** is a portfolio capstone: a unified, production-style **inbound voice agent** for a fictional *City Clinic*. It replaces "press 1, press 2" phone trees with a conversational agent that can **triage the call, answer FAQs, book appointments, sync a CRM, hand off to specialists with context, honour compliance rules, and log analytics**.

> 🎯 Goal: show job-ready voice-automation skills: API latency handling, state management, compliance boundaries and real integrations.

## ✨ Features

| | Feature | How it works |
|---|---|---|
| 🧭 | **Triage and intent parsing** | Front Desk agent routes to FAQ, booking, billing or emergency paths |
| 📚 | **FAQ from knowledge base** | Answers only from the `City Clinic FAQ` KB, never invents facts |
| 📅 | **Real-time booking** | `check_calendar_availability` and `book_appointment` call n8n, Google Calendar and Postgres |
| 🔒 | **Double-booking protection** | `UNIQUE (booking_date, booking_time)` plus insert-before-calendar ordering |
| 🔁 | **Context-aware handoff** | `extract_handoff_variables` then agent swap, Billing agent greets by name without re-verifying |
| 🚨 | **Crisis gate** | Emergency words trigger the 911 message and transfer to the nurse without consent |
| 🚫 | **Do-Not-Call gate** | "Stop calling" sets `dnc_status = TRUE` and ends the call |
| 📊 | **Post-call analytics** | Summary, sentiment and `outcome` selector logged to `capstone_call_outcomes` |

## 🏗 Architecture

```mermaid
flowchart TD
    A[Caller - Web Call / Phone] --> B[Retell AI: City Clinic Front Desk]
    B -->|FAQ| KB[(Knowledge Base)]
    B -->|check_calendar_availability| N1[n8n: Check Availability]
    B -->|book_appointment| N2[n8n: Book Appointment]
    B -->|register_dnc_optout| N3[n8n: Register DNC]
    B -->|agent swap + context| C[Billing Specialist]
    B -->|crisis, no consent| D[Triage Nurse]
    N1 --> GC[(Google Calendar)]
    N2 --> DB[(Supabase PostgreSQL)]
    N2 --> GC
    N3 --> DB
    B -->|call_analyzed| N4[n8n: Post Call Webhook]
    N4 --> DB
```

More diagrams: [`docs/architecture.md`](docs/architecture.md)

## 🧰 Tech Stack

| Layer | Tool |
|---|---|
| Voice agents | Retell AI (3 agents, custom functions, KB, post-call analysis) |
| Automation / API | n8n Cloud (4 published webhook workflows) |
| Database / CRM | Supabase PostgreSQL |
| Scheduling | Google Calendar API (OAuth2) |
| Telephony | Retell Web Call (Twilio-ready) |

## 🗂 Repository Structure

```text
city-clinic-ai-voice-front-desk-capstone/
├── README.md
├── LICENSE
├── .env.example
├── database/
│   ├── schema.sql              # 3 tables + indexes + unique slot constraint
│   └── queries.sql             # SQL used by the n8n workflows
├── retell/
│   ├── prompts/                # Front Desk, Billing, Triage Nurse prompts
│   ├── tools/                  # custom function + transfer definitions (JSON)
│   ├── knowledge_base/         # City Clinic FAQ text
│   └── post_call_analysis.json # outcome selector + webhook config
├── n8n/
│   ├── workflows/              # exported workflow JSON files
│   └── sample_payloads/        # example Retell request bodies
├── docs/
│   ├── architecture.md
│   ├── setup-guide.md
│   ├── test-cases.md
│   └── challenges-and-limitations.md
└── assets/screenshots/         # evidence screenshots
```

## 🗄 Database Schema

| Table | Purpose |
|---|---|
| `capstone_crm_leads` | Caller identity, contact info, `dnc_status` |
| `capstone_appointments` | Booked slots, unique per date and time |
| `capstone_call_outcomes` | Call id, duration, outcome, sentiment, summary |

## 🔄 n8n Workflows

| Workflow | Endpoint | What it does |
|---|---|---|
| Check Availability | `POST /webhook/check-availability` | Reads Google Calendar and returns free 30-min slots (09:00-17:00) |
| Book Appointment | `POST /webhook/book-appointment` | Upserts lead, inserts appointment, creates calendar event |
| Register DNC | `POST /webhook/register-dnc` | Upserts lead with `dnc_status = TRUE` |
| Post Call Webhook | `POST /webhook/retell-postcall` | Logs `call_analyzed` data into `capstone_call_outcomes` |

## ✅ Test Results

| ID | Scenario | Result |
|---|---|---|
| TC-001 | Calendar availability check | ✅ Pass |
| TC-002 | Booking + CRM sync (live n8n run) | ✅ Pass |
| TC-002b | Duplicate slot rejected by DB | ✅ Pass |
| TC-003 | Billing transfer with context | ✅ Pass |
| TC-004 | Voice opt-out and DNC | ✅ Pass |
| TC-005 | Post-call webhook logging | ✅ Pass |
| TC-006 | FAQ from knowledge base | ✅ Pass |

Details: [`docs/test-cases.md`](docs/test-cases.md)

## 📸 Screenshots

| Retell agents | Supabase call outcomes |
|---|---|
| ![agents](assets/screenshots/01-retell-agents.png) | ![outcomes](assets/screenshots/04-supabase-call-outcomes.png) |

| Billing transfer call | Opt-out (DNC) call |
|---|---|
| ![billing](assets/screenshots/02-call-billing-transfer.png) | ![dnc](assets/screenshots/03-call-optout-dnc.png) |

<details>
<summary><b>🔧 n8n workflow screenshots</b></summary>

| Check Availability | Book Appointment |
|---|---|
| ![availability](assets/screenshots/08-n8n-check-availability.png) | ![booking](assets/screenshots/07-n8n-book-appointment.png) |

| Register DNC | Post Call Webhook |
|---|---|
| ![dnc workflow](assets/screenshots/05-n8n-register-dnc.png) | ![postcall](assets/screenshots/06-n8n-post-call-webhook.png) |

</details>

## 🚀 Quick Start

1. Run [`database/schema.sql`](database/schema.sql) in the Supabase SQL Editor.
2. Create Postgres and Google Calendar credentials in n8n, import the workflows and **Publish** all four.
3. Create the 3 Retell agents with the prompts in [`retell/prompts`](retell/prompts), add the functions from [`retell/tools`](retell/tools) using your n8n production URLs.
4. Create and attach the knowledge base, add the `outcome` selector, set the webhook on the Front Desk agent.
5. Run a Web Call and verify Supabase, Google Calendar and n8n Executions.

Full guide: [`docs/setup-guide.md`](docs/setup-guide.md)

## ⚠️ Challenges and Limitations

- Supabase SSL certificate rejected by n8n, fixed with *Ignore SSL Issues* on the credential.
- Retell agent swap cannot pass variables directly, solved with `extract_handoff_variables`.
- Transfer latency cannot be measured in Retell, webhook signature verification is not yet implemented.

Full list and future enhancements: [`docs/challenges-and-limitations.md`](docs/challenges-and-limitations.md)

## 👤 Author

**Shaik Shahid**
[![GitHub](https://img.shields.io/badge/GitHub-shaikshahid777-181717?style=flat-square&logo=github)](https://github.com/shaikshahid777)

<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=6,11,20&height=120&section=footer" width="100%" alt="footer"/>

</div>
