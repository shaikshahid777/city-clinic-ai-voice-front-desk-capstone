# Test Cases and Results

| ID | Test | Linked FR | Method | Result |
|---|---|---|---|---|
| TC-001 | Calendar availability check | FR-001 | n8n live run + Retell simulation | Pass |
| TC-002 | Appointment booking + CRM sync | FR-001, FR-005 | n8n live run (lead, appointment row, calendar event created, then cleaned up) | Pass |
| TC-002b | Double booking rejected | RSK-001 | n8n live run: second identical booking hit the unique constraint, no duplicate calendar event | Pass |
| TC-003 | Multi-agent context transfer | FR-003 | Retell web call + simulation: Billing agent greeted caller by name, did not re-ask identity | Pass |
| TC-004 | Verbal opt-out | FR-004 | Retell web call: DNC line spoken, `register_dnc_optout` called, call ended | Pass |
| TC-004b | DNC database write | FR-004 | n8n live run: `dnc_status = TRUE` row created, then cleaned up | Pass |
| TC-005 | Post-call webhook ingest | FR-005 | Real calls logged to `capstone_call_outcomes` (faq_resolved, transferred, opt_out_dnc) | Pass |
| TC-006 | FAQ from knowledge base | FR-002 | Retell simulation + web call (parking, hours, location) | Pass |

Evidence: see `assets/screenshots/`.
