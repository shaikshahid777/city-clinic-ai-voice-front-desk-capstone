-- City Clinic AI Voice Front Desk - Supabase / PostgreSQL schema

CREATE TABLE IF NOT EXISTS capstone_crm_leads (
  lead_id      SERIAL PRIMARY KEY,
  first_name   VARCHAR(50)  NOT NULL,
  last_name    VARCHAR(50)  NOT NULL,
  email        VARCHAR(100) UNIQUE NOT NULL,
  phone_number VARCHAR(20)  UNIQUE NOT NULL,
  dnc_status   BOOLEAN DEFAULT FALSE,
  created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS capstone_appointments (
  appointment_id SERIAL PRIMARY KEY,
  lead_id        INT REFERENCES capstone_crm_leads(lead_id),
  booking_date   DATE NOT NULL,
  booking_time   TIME NOT NULL,
  status         VARCHAR(20) DEFAULT 'confirmed',
  created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  -- RSK-001: prevents double booking of the same slot
  CONSTRAINT unique_slot UNIQUE (booking_date, booking_time)
);

CREATE TABLE IF NOT EXISTS capstone_call_outcomes (
  call_log_id      SERIAL PRIMARY KEY,
  call_sid         VARCHAR(100) UNIQUE NOT NULL,
  lead_id          INT REFERENCES capstone_crm_leads(lead_id),
  duration_seconds INT,
  outcome_label    VARCHAR(30) NOT NULL, -- booked | faq_resolved | transferred | opt_out_dnc
  sentiment_label  VARCHAR(20) DEFAULT 'NEUTRAL',
  summary          TEXT,
  occurred_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_leads_phone  ON capstone_crm_leads(phone_number);
CREATE INDEX IF NOT EXISTS idx_outcomes_sid ON capstone_call_outcomes(call_sid);
