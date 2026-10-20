# Challenges, Assumptions, Limitations, Enhancements

## Challenges
- **Supabase SSL certificate:** n8n rejected the Supabase pooler certificate (`self-signed certificate in certificate chain`). Fixed by enabling "Ignore SSL Issues" in the Postgres credential.
- **Agent swap and variables:** Retell agent swap has no "pass variables" option. Solved with an `extract_handoff_variables` function that stores caller context before the swap.
- **Goodbye loop after transfer:** Billing and Nurse agents had no `end_call` function. Added `end_call` plus a closing line in each prompt.
- **Knowledge base not answering:** the KB was created but not attached to the Front Desk agent. Attaching it fixed FAQ answers.
- **Publish state in n8n:** changes only take effect on the production webhook URL after clicking Publish again.
- **Double booking:** Google Calendar allows overlapping events, so a UNIQUE constraint on `(booking_date, booking_time)` plus insert-before-event ordering was used.

## Assumptions
- Clinic hours 09:00-17:00, 30-minute slots, timezone Asia/Kolkata.
- Web calls have no phone number, so DNC and lead lookups use the number the caller provides or a placeholder.

## Limitations
- Transfer latency (NFR-001, under 2500 ms) cannot be measured or set in Retell; agent swaps are near-instant.
- Webhook signature verification (NFR-002) is not implemented yet.
- If the calendar step fails after the DB insert, the appointment row remains.
- Demo uses Retell web calls instead of a Twilio phone number.

## Possible enhancements
- Verify the Retell webhook signature in n8n.
- Roll back the appointment row if calendar creation fails.
- Add a Twilio number for real phone calls.
- Add reschedule and cancel flows.
- Build a dashboard on `capstone_call_outcomes`.
