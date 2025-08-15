-- ============================================
-- Schema for Legal Document Request Automation (PostgreSQL)
-- ============================================

-- Drop table if exists (optional, for testing)
DROP TABLE IF EXISTS legal_requests;

-- Table creation
CREATE TABLE legal_requests (
    id SERIAL PRIMARY KEY,
    client_name VARCHAR(255) NOT NULL,
    case_type VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    document_type VARCHAR(255) NOT NULL,
    state VARCHAR(20) CHECK (state IN ('initiated', 'completed', 'failed')) DEFAULT 'initiated',
    timestamp_initiated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    timestamp_completed TIMESTAMP
);

-- ============================================
-- Insert query (used right after new row in Sheets is detected)
-- ============================================
INSERT INTO legal_requests (
    client_name,
    case_type,
    email,
    document_type,
    state,
    timestamp_initiated
) VALUES (
    :client_name,
    :case_type,
    :email,
    :document_type,
    'initiated',
    NOW()
)
RETURNING id;

-- ============================================
-- Update query (used after sending email successfully)
-- ============================================
UPDATE legal_requests
SET state = 'completed',
    timestamp_completed = NOW()
WHERE id = :request_id;

-- ============================================
-- Optional: Mark as failed if an error occurs
-- ============================================
UPDATE legal_requests
SET state = 'failed'
WHERE id = :request_id;
