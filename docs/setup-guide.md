# Setup Guide

1. **Supabase:** create a project, run `database/schema.sql` in the SQL Editor.
2. **n8n:** create a Postgres credential (Supabase Session pooler, enable Ignore SSL Issues) and a Google Calendar OAuth2 credential.
3. **Import workflows** from `n8n/workflows/` and select your credentials in each node. Click **Publish** on all four.
4. **Retell:**
   - Create three agents using `retell/prompts/`.
   - Add the custom functions from `retell/tools/` with your n8n production URLs.
   - Create the knowledge base from `retell/knowledge_base/city_clinic_faq.txt` and attach it to the Front Desk agent.
   - Add the `outcome` selector from `retell/post_call_analysis.json` and set the webhook on the Front Desk agent.
5. **Test:** run a Web Call and check Supabase, Google Calendar and n8n Executions.
