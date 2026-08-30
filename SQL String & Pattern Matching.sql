/* ==========================================================================================
   SQL Project: SQL String & Pattern Matching
   Author: Kamlesh Kumar Jha
   Description: This project demonstrates SQL concepts PracticeUse SQL string
   functions and pattern matching to filter and search text fields across an Employees table.
   using a sample Employees table.
   ============================================================================================ */

/* ------------------------------------------------------------
   Task 1. Create and Populate Table
   ------------------------------------------------------------ */
  -- Step 1: Drop the table if it already exists
DROP TABLE IF EXISTS Employees;

-- Step 2: Create the new Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Email VARCHAR(50)
);

-- Insert sample data

INSERT INTO Employees (EmpID, Name, Department, Email) VALUES
   (1, 'Alice Johnson',  'HR',      'alice.johnson@example.com'),
   (2, 'Bob Smith',  	'IT',      'bob.smith@example.com'),
   (3, 'Charlie Brown',  'Finance','charlie.brown@example.com'),
   (4, 'Diana Prince',   'HR',      'diana.prince@example.com'),
   (5, 'Eve Adams',  	'IT',      'eve.adams@example.org');

/* ------------------------------------------------------------
  Task 2. a) @example.com Emails:
   Goal: List employees with emails in the example.com domain.
   ------------------------------------------------------------ */
-- Method 1: LIKE → Simple and readable, but can match partial domains accidentally.
SELECT Name, Email 
FROM Employees 
WHERE Email LIKE '%@example.com';

-- Method 2: RIGHT + LEN → More precise, ensures exact domain match. 
-- ✅ Recommended for efficiency and accuracy in production.
SELECT Name, Email 
FROM Employees 
WHERE RIGHT(Email, LEN('@example.com')) = '@example.com';


/* ------------------------------------------------------------
    b) Names Starting with 'A':
   Goal: Select employees whose names start with 'A'.
   ------------------------------------------------------------ */

-- Method 1: LIKE → Easy to understand, widely used.
SELECT Name 
FROM Employees 
WHERE Name LIKE 'A%';

-- Method 2: LEFT → Slightly faster when only first character check is needed.
-- ✅ Recommended when checking fixed positions.
SELECT Name 
FROM Employees 
WHERE LEFT(Name,1) = 'A';

/* ------------------------------------------------------------
   c) Names Ending with 'son':
   Goal: Find employees whose names end with 'son'.
   ------------------------------------------------------------ */

   -- Method 1: LIKE → Flexible, works for variable suffixes.
SELECT Name 
FROM Employees 
WHERE Name LIKE '%son';

-- Method 2: RIGHT → More efficient for fixed suffix length.
-- ✅ Recommended when suffix length is known.
SELECT Name 
FROM Employees 
WHERE RIGHT(Name,3) = 'son';

/* ------------------------------------------------------------
   d) Second Letter 'v':
   Goal: Retrieve employees whose second character in the name is 'v'.
   ------------------------------------------------------------ */
-- Method 1: SUBSTRING → Clear and explicit, works for any position.
SELECT * 
FROM Employees 
WHERE SUBSTRING(Name,2,1) = 'v';

-- Method 2: LIKE with '_' wildcard → Shorter syntax, but less flexible.
-- ✅ SUBSTRING is better for clarity and maintainability.
SELECT * 
FROM Employees 
WHERE Name LIKE '_v%';
/* ------------------------------------------------------------
    e) Departments Containing 'IT':
   Goal: Select employees in departments containing 'IT'.
   ------------------------------------------------------------ */
-- Method 1: LIKE → Simple, widely used.
SELECT Name, Department 
FROM Employees 
WHERE Department LIKE '%IT%';

-- Method 2: CHARINDEX → More efficient for substring search, returns position.
-- ✅ Recommended when searching substrings in large text fields.
SELECT Name, Department 
FROM Employees 
WHERE CHARINDEX('IT', Department) > 0;


/* ----------------------------------------------------------------------------
    f) Case-Insensitive 'hr':
   Goal: Find employees in departments with 'hr' regardless of case.
   ----------------------------------------------------------------------------- */
 -- Method 1: LOWER → Portable, works across databases, but adds function overhead.
SELECT * 
FROM Employees 
WHERE LOWER(Department) LIKE '%hr%';

-- Method 2: COLLATE (Case Insensitive) → SQL Server specific, faster since no function call.
-- ✅ Recommended for SQL Server projects.
SELECT * 
FROM Employees 
WHERE Department COLLATE SQL_Latin1_General_CP1_CI_AS LIKE '%hr%';

