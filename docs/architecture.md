# Architecture

```mermaid
flowchart TD
    A[Caller - Web Call / Phone] --> B[Retell AI: City Clinic Front Desk]
    B -->|FAQ| KB[(Knowledge Base: City Clinic FAQ)]
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
    DB --> AN[Analytics: capstone_call_outcomes]
```

## Booking flow (double-booking safe)

```mermaid
sequenceDiagram
    participant R as Retell Agent
    participant N as n8n Book Appointment
    participant P as Postgres
    participant G as Google Calendar
    R->>N: book_appointment(args)
    N->>P: Upsert lead
    N->>P: Insert appointment (UNIQUE date+time)
    alt slot already taken
        P-->>N: unique violation
        N-->>R: status failed
    else slot free
        N->>G: Create event
        N-->>R: status success
    end
```

## Key design decisions

- **DB before calendar:** the appointment row is inserted first, so a duplicate slot fails before any calendar event exists.
- **Agent speaks only after tool result:** the agent never says "confirmed" until the tool returns `success`.
- **One post-call event per call:** only the Front Desk agent has the webhook; Billing and Nurse do not.
- **Context handoff:** `extract_handoff_variables` stores caller context before the agent swap.
