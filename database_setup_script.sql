

-- =============================================================================
-- 1. EMPLOYEE DATA TABLE - Modified to match CSV column names
-- =============================================================================
CREATE TABLE employee_data (
    empid INTEGER PRIMARY KEY,
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    startdate VARCHAR(20),  -- Using VARCHAR initially for flexible date formats
    exitdate VARCHAR(20),
    title VARCHAR(200),
    supervisor VARCHAR(200),
    ademail VARCHAR(200),
    businessunit VARCHAR(50),
    employeestatus VARCHAR(50),
    employeetype VARCHAR(50),
    payzone VARCHAR(50),
    employeeclassificationtype VARCHAR(50),
    terminationtype VARCHAR(50),
    terminationdescription TEXT,
    departmenttype VARCHAR(100),
    division VARCHAR(100),
    dob VARCHAR(20),  -- Using VARCHAR initially for flexible date formats
    state VARCHAR(10),
    jobfunctiondescription VARCHAR(200),
    gendercode VARCHAR(20),
    locationcode VARCHAR(20),
    racedesc VARCHAR(50),
    maritaldesc VARCHAR(50),
    "Performance Score" VARCHAR(50),  -- Quoted because of space in name
    "Current Employee Rating" INTEGER
);

--test comment

-- =============================================================================
-- 2. EMPLOYEE ENGAGEMENT SURVEY TABLE - Modified column names
-- =============================================================================
CREATE TABLE employee_engagement_survey_data (
    employeeid INTEGER,
    surveydate VARCHAR(20),  -- Using VARCHAR initially
    engagementscore INTEGER,
    satisfactionscore INTEGER,
    worklifebalancescore INTEGER,
    FOREIGN KEY (employeeid) REFERENCES employee_data(empid)
);

-- =============================================================================
-- 3. TRAINING AND DEVELOPMENT TABLE - Modified column names
-- =============================================================================
CREATE TABLE training_and_development_data (
    employeeid INTEGER,
    trainingdate VARCHAR(20),  -- Using VARCHAR initially
    trainingprogramname VARCHAR(200),
    trainingtype VARCHAR(100),
    trainingoutcome VARCHAR(100),
    location VARCHAR(200),
    trainer VARCHAR(200),
    trainingdurationdays INTEGER,
    trainingcost DECIMAL(10,2),
    FOREIGN KEY (employeeid) REFERENCES employee_data(empid)
);

-- =============================================================================
-- 4. RECRUITMENT DATA TABLE - Modified to match CSV with spaces
-- =============================================================================
CREATE TABLE recruitment_data (
    "Applicant ID" INTEGER PRIMARY KEY,
    "Application Date" VARCHAR(20),  -- Using VARCHAR initially
    "First Name" VARCHAR(100),
    "Last Name" VARCHAR(100),
    gender VARCHAR(20),
    "Date of Birth" VARCHAR(20),  -- Using VARCHAR initially
    "Phone Number" VARCHAR(50),
    email VARCHAR(200),
    address VARCHAR(500),
    city VARCHAR(100),
    state VARCHAR(10),
    "Zip Code" VARCHAR(20),
    country VARCHAR(100),
    "Education Level" VARCHAR(100),
    "Years of Experience" INTEGER,
    "Desired Salary" DECIMAL(12,2),
    "Job Title" VARCHAR(200),
    status VARCHAR(50)
);

-- =============================================================================
-- INDEXES for better query performance
-- =============================================================================

-- Employee data indexes
CREATE INDEX idx_employee_department ON employee_data(departmenttype);
CREATE INDEX idx_employee_status ON employee_data(employeestatus);
CREATE INDEX idx_employee_rating ON employee_data("Current Employee Rating");
CREATE INDEX idx_employee_gender ON employee_data(gendercode);

-- Survey data indexes
CREATE INDEX idx_survey_employee ON employee_engagement_survey_data(employeeid);

-- Training data indexes
CREATE INDEX idx_training_employee ON training_and_development_data(employeeid);
CREATE INDEX idx_training_outcome ON training_and_development_data(trainingoutcome);

-- Recruitment data indexes
CREATE INDEX idx_recruitment_status ON recruitment_data(status);

-- =============================================================================
-- VERIFICATION QUERIES
-- =============================================================================

-- Check record counts
SELECT 'employee_data' as table_name, COUNT(*) as record_count FROM employee_data
UNION ALL
SELECT 'employee_engagement_survey_data', COUNT(*) FROM employee_engagement_survey_data
UNION ALL
SELECT 'training_and_development_data', COUNT(*) FROM training_and_development_data
UNION ALL
SELECT 'recruitment_data', COUNT(*) FROM recruitment_data;

-- Sample data preview
SELECT 'Employee Data Sample:' as info;
SELECT empid, firstname, lastname, title, departmenttype, "Current Employee Rating" 
FROM employee_data LIMIT 5;

-- =============================================================================
-- OPTIONAL: Convert date columns after import (run these after CSV import)
-- =============================================================================

-- Uncomment and run these queries AFTER importing your CSV data to convert date formats:

-- ALTER TABLE employee_data ADD COLUMN start_date_converted DATE;
-- UPDATE employee_data SET start_date_converted = TO_DATE(startdate, 'DD-Mon-YY') WHERE startdate != '';

-- ALTER TABLE employee_data ADD COLUMN dob_converted DATE;
-- UPDATE employee_data SET dob_converted = TO_DATE(dob, 'DD-MM-YYYY') WHERE dob != '';

-- Then you can drop the original VARCHAR date columns and rename the converted ones if needed