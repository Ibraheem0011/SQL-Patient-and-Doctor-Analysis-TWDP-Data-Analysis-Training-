/* ====================================================================
This queries answer the Assignment questions starting from
the first TWDP lms lesson on SQL to the last task given
Solved by Ibraheem Tunde Lawal using the Pateints and Doctors dommy_data
Thank you SageIQ programmers and tutors
======================================================================== */

/* ===============================
	TASK 1: PATIENTS TABLE ANALYSIS
=================================== */

--- Task 1, Q1: Display all patients from Lagos ---
SELECT *
FROM Patients
WHERE City= 'Lagos';

--- Task 1, Q2: Find patients whose length of stay is greater than 5 days ---
SELECT *
FROM Patients
WHERE Length_of_Stay> 5;

--- Task 1, Q3: Find patients aged between 30 and 50 ---
SELECT *
FROM Patients
WHERE Age BETWEEN 30 AND 50;

--- Task 1, Q4: Find female patients in Lagos admitted through Emergency ---
SELECT *
FROM Patients
WHERE Gender = 'Female' 
	AND City = 'Lagos'
	AND Admission_Type = 'Emergency';

--- Task 1, Q5: Find patients diagnosed with Diabetes or Hypertension ---
SELECT *
FROM Patients
WHERE Condition = 'Diabetes'
OR Condition = 'Hypertension';
--- Another way to write it --- 
SELECT *
FROM Patients
WHERE [Condition] IN ('Diabetes', 'Hypertension');

--- Task 1, Q6: Find the three patients with the longest stays ---
SELECT TOP 3 *
FROM Patients
ORDER BY Length_of_Stay DESC;

--- Task 1, Q7: Display all unique cities ---
SELECT DISTINCT City
FROM Patients;

--- Task 1, Q8: Count the total number of patients ---
SELECT COUNT (*) 
FROM Patients;

SELECT COUNT (*) AS Total_Number_of_Patients
FROM Patients;

--- Task 1, Q9: Calculate the average age of patients ---
SELECT AVG (Age) AS Average_Age_of_Patients
FROM Patients;

-- Task 1, Q10: Count patients by medical condition ---
SELECT 
		[Condition],
		COUNT (*)  AS patients_Count
FROM Patients
GROUP BY [Condition]
ORDER BY Condition ASC;

--- Task 1, Q11: Display patient names in uppercase ---
SELECT 
UPPER (Patient_Name) AS Uppercase_Name
FROM Patients;

-- Task 1, Q12: Display patient names in lowercase ---
SELECT 
LOWER (Patient_Name) AS Lowerercase_Name
FROM Patients;

--- Task 1, Q13: Combine patient ID and patient name ---
SELECT CONCAT (Patient_ID, '-', patient_Name) AS Patient_Info
FROM Patients;

-- Task 1, Q14: Find admissions after January 15, 2026
SELECT *
FROM Patients
WHERE Admission_Date > 'January 15, 2026';

-- Task 1, Q15: Extract the admission year and month
SELECT
	Patient_ID,
	YEAR (Admission_Date) AS Admission_Yrear,
	MONTH (Admission_Date) AS Admission_Month
FROM Patients


/* ============================================================
   TASK 2: PATIENT AGGREGATION AND CLASSIFICATION
   ============================================================ */

--- Task 2, Q1: Calculate average length of stay by admission type ---
SELECT Admission_Type,
AVG (Length_of_Stay) AS AVG_Lenght_of_Stay
FROM Patients
GROUP BY Admission_Type;

--- Task 2, Q2: Find admission types with average stay above 4 days ---
SELECT
    Admission_Type,
    AVG (Length_of_Stay)
        AS Average_Length_Of_Stay
FROM Patients
GROUP BY Admission_Type
HAVING AVG(Length_of_Stay) > 4;

--- Task 2, Q3: Classify patients by age group ---
SELECT
    Patient_ID,
    Patient_Name,
    Age,
    CASE
        WHEN Age < 40 THEN 'Young'
        WHEN Age BETWEEN 40 AND 59 THEN 'Middle-aged'
        WHEN Age >= 60 THEN 'Elders'
        ELSE 'Unknown'
    END AS Age_Group
FROM Patients;

--- Task 2, Q4: Count patients in each age group ---
SELECT
    CASE
        WHEN Age < 40 THEN 'Young'
        WHEN Age BETWEEN 40 AND 59 THEN 'Middle-aged'
        WHEN Age >= 60 THEN 'Elders'
        ELSE 'Unknown'
    END AS Age_Group,
    COUNT(*) AS Patient_Count
FROM Patients
GROUP BY
    CASE
        WHEN Age < 40 THEN 'Young'
        WHEN Age BETWEEN 40 AND 59 THEN 'Middle-aged'
        WHEN Age >= 60 THEN 'Elders'
        ELSE 'Unknown'
    END;

--- Task 2, Q5: Classify patients as Short Stay or Long Stay ---
SELECT
    Patient_ID,
    Patient_Name,
    Length_of_Stay,
    CASE
        WHEN Length_of_Stay <= 3 THEN 'Short Stay'
        WHEN Length_of_Stay > 3 THEN 'Long Stay'
        ELSE 'Unknown'
    END AS Stay_Category
FROM Patients;

--- Task 2, Q6: Find medical conditions with more than one patient ---
SELECT
    [Condition],
    COUNT(*) AS Patient_Count
FROM Patients
GROUP BY [Condition]
HAVING COUNT(*) > 1
ORDER BY Patient_Count;


/* ================================================
   TASK 4: DOCTORS TABLE IMPORT AND VERIFICATION
   ================================================ */

-- Task 4, Q1: Check whether the Doctors table exists
SELECT * 
FROM Doctors;

--- OR ---

SELECT
    TABLE_SCHEMA,
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'Doctors';

-- Task 4, Q2: Display all records in the Doctors table
SELECT *
FROM Doctors;

-- Task 4, Q3: Count the number of doctors
SELECT COUNT(*) AS Total_Doctors
FROM Doctors;

-- Task 4, Q4: Inspect the Doctors table structure

EXEC sp_help 'Doctors';


/* ======================================
   TASK 5: JOIN PATIENTS AND DOCTORS
   ====================================== */

--- Task 5, Q1: Display each patient's name and doctor's specialization ---
SELECT
    p.Patient_ID,
    p.Patient_Name,
    d.Doctor_Name,
    d.Specialization
FROM dbo.Patients AS p
INNER JOIN dbo.Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID;

    ---- OR -----

SELECT
    Patient_ID,
    Patient_Name,
    Doctor_Name,
    Specialization
FROM Patients AS PA
INNER JOIN Doctors AS DC
    ON PA.Doctor_ID = DC.Doctor_ID;

    ---- OR ----

SELECT *
FROM Patients
INNER JOIN Doctors
ON Patients.Doctor_ID =Doctors.Doctor_ID;

---- OR ----

SELECT *
FROM Patients AS PA
INNER JOIN Doctors AS DC
ON PA.Doctor_ID =DC.Doctor_ID;

--- Task 5, Q2: Find patients treated by Internal Medicine doctors ---
SELECT
    Patient_ID,
    Patient_Name,
    [Condition],
    Doctor_Name,
    Specialization
FROM Patients AS p
INNER JOIN Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID
WHERE Specialization = 'Internal Medicine';

---- OR ----

SELECT
    p.Patient_ID,
    p.Patient_Name,
    p.[Condition],
    d.Doctor_Name,
    d.Specialization
FROM dbo.Patients AS p
INNER JOIN dbo.Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID
WHERE d.Specialization = 'Internal Medicine';

--- Task 5, Q3: Calculate average length of stay for each doctor ---
SELECT
    d.Doctor_ID,
    d.Doctor_Name,
    AVG (p.Length_of_Stay)
        AS Average_Length_Of_Stay
FROM Patients AS p
INNER JOIN dbo.Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID
GROUP BY
    d.Doctor_ID,
    d.Doctor_Name
ORDER BY Average_Length_Of_Stay DESC;

---- OR ----
 
 SELECT
    d.Doctor_Name,
    AVG (p.Length_of_Stay)
        AS Average_Length_Of_Stay
FROM Patients AS p
JOIN Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID
GROUP BY
    d.Doctor_Name
ORDER BY Average_Length_Of_Stay ASC;

--- Task 5, Q4: Identify the doctor(s) who treated the most patients ---
SELECT TOP 1 WITH TIES
    d.Doctor_ID,
    d.Doctor_Name,
    d.Specialization,
    COUNT(*) AS Total_Patients
FROM dbo.Patients AS p
INNER JOIN Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID
GROUP BY
    d.Doctor_ID,
    d.Doctor_Name,
    d.Specialization
ORDER BY COUNT(*) DESC;

SELECT TOP 1 WITH TIES
d.Doctor_ID,
    d.Specialization,
    COUNT(*) AS Total_Patients
FROM Patients AS p
INNER JOIN Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID
    GROUP BY
    d.Doctor_ID,
    d.Specialization
ORDER BY COUNT(*) DESC;

/* ===================================
   TASK 6: VERIFY TABLE STRUCTURES
   =================================== */

--- Task 6, Q1: Inspect the Patients table ---
EXEC sp_help 'Patients';
---- OR ----
EXEC sp_help 'dbo.Patients';

--- Task 6, Q2: Inspect the Doctors table ---
EXEC sp_help 'dbo.Doctors';
---- OR ----
EXEC sp_help 'Doctors';