-- Queries used by the n8n workflows

-- Book Appointment: upsert lead
INSERT INTO capstone_crm_leads (first_name, last_name, email, phone_number)
VALUES ($1, $2, $3, $4)
ON CONFLICT (phone_number) DO UPDATE
  SET first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name
RETURNING lead_id;

-- Book Appointment: insert appointment (fails on duplicate slot)
INSERT INTO capstone_appointments (lead_id, booking_date, booking_time)
VALUES ($1, $2, $3);

-- Register DNC: mark number as Do-Not-Call
INSERT INTO capstone_crm_leads (first_name, last_name, email, phone_number, dnc_status)
VALUES ('Unknown', 'Caller', 'dnc_' || $1 || '@placeholder.local', $1, TRUE)
ON CONFLICT (phone_number) DO UPDATE SET dnc_status = TRUE
RETURNING lead_id, dnc_status;

-- Post-call webhook: log outcome
INSERT INTO capstone_call_outcomes
  (call_sid, lead_id, duration_seconds, outcome_label, sentiment_label, summary)
VALUES
  ($1, (SELECT lead_id FROM capstone_crm_leads WHERE phone_number = $2 LIMIT 1), $3, $4, $5, $6)
ON CONFLICT (call_sid) DO NOTHING;

-- Verification queries
SELECT * FROM capstone_crm_leads ORDER BY created_at DESC;
SELECT * FROM capstone_appointments ORDER BY created_at DESC;
SELECT call_sid, outcome_label, sentiment_label, duration_seconds FROM capstone_call_outcomes ORDER BY occurred_at DESC;
