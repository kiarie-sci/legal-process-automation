# Legal Process Automation – Make.com Integration

## Project Description
This project automates a **legal document request workflow** using **Make.com (Integromat)**, integrating Google Sheets, Google Drive, Google Docs, Gmail, and MySQL.

The automation begins **by creating a database record as soon as a new request is detected in Google Sheets**.  
The reason for creating the record **before** the rest of the automation runs is intentional:  
we want to maintain a complete history of all requests — not just those that successfully complete every step.  
By logging each request at the very start (with a state of `"initiated"`), we ensure visibility into all events,  
including those that fail or are partially processed.

This approach supports **full auditability**, **debugging**, and **reporting** on workflow health,  
instead of losing track of incomplete or errored requests.

---

## How the Automation Works
1. **Trigger – Google Sheets**  
   When a new row is added containing:
   - Client Name
   - Case Type
   - Email
   - Document Type Requested (selected from a dropdown list)

2. **Database Insert – MySQL**  
   Immediately insert a new record with:
   - All provided request details
   - Timestamp
   - Status = `"initiated"`

3. **Document Fetch – Google Drive**  
   Locate the legal document template that matches the requested document type.

4. **Template Population – Google Docs**  
   Replace placeholders in the template with:
   - Client Name
   - Case Type

5. **Document Storage – Google Drive**  
   Save the completed document into a designated “Completed Legal Docs” folder.

6. **Email Delivery – Gmail**  
   Send the filled document as an attachment to the client’s email.

7. **Database Update – MySQL**  
   Update the status of the corresponding record to `"completed"` once the email is successfully sent.

---

## Key Features
- **Early database logging** to track all requests, successful or not.
- **Document type dropdowns** in Google Sheets to standardize input.
- **End-to-end automation** from request capture to client delivery.
- **MySQL logging** for reporting, auditing, and troubleshooting.

---

## Tech Stack
- **Automation Platform:** Make.com (Integromat)
- **Database:** MySQL
- **Storage & Docs:** Google Drive, Google Docs
- **Email Service:** Gmail
- **Data Input:** Google Sheets

---

## Repository Contents
- `scenario.json` – Export of the Make.com scenario
- `schema.sql` – SQL table structure for logging requests
- `insert_example.sql` – Example insert script
- `update_example.sql` – Example update script
- `README.md` – Project overview and setup instructions

---

## Author
Peter Kiarie
