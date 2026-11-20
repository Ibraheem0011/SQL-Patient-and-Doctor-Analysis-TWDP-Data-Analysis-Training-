# SQL Patient and Doctor Analysis (TWDP Data Analysis Training)

A collection of SQL Server (T-SQL) queries written for the SQL module of the TWDP Data Analysis Training. The queries analyse a dummy hospital database with `Patients` and `Doctors` tables, moving from basic filtering to aggregation, conditional classification and joins.

## Dataset

Two dummy tables provided for the training:

| Table | Columns |
| --- | --- |
| `Patients` | Patient_ID, Patient_Name, Age, Gender, City, Condition, Admission_Type, Admission_Date, Length_of_Stay, Doctor_ID |
| `Doctors` | Doctor_ID, Doctor_Name, Specialization |

`Doctor_ID` links the two tables. All data is dummy data, so no real patient information is involved.

## What the Queries Cover

| Task | Focus | SQL skills demonstrated |
| --- | --- | --- |
| **Task 1: Patients table analysis** (15 questions) | Filtering, sorting and summarising patient records | `SELECT`, `WHERE`, `BETWEEN`, `AND` / `OR`, `IN`, `TOP`, `ORDER BY`, `DISTINCT`, `COUNT`, `AVG`, `GROUP BY`, `UPPER`, `LOWER`, `CONCAT`, `YEAR`, `MONTH` |
| **Task 2: Aggregation and classification** (6 questions) | Averages by group, grouped filters and categories | `GROUP BY`, `HAVING`, `CASE WHEN` (age groups, short vs long stay) |
| **Task 4: Doctors table verification** | Checking and inspecting an imported table | `INFORMATION_SCHEMA.TABLES`, `COUNT`, `sp_help` |
| **Task 5: Joining patients and doctors** (4 questions) | Combining tables to answer questions | `INNER JOIN`, table aliases, `AVG` by doctor, `TOP 1 WITH TIES` |
| **Task 6: Verify table structures** | Inspecting column names and data types | `sp_help` |

## Example Queries

**Average length of stay by admission type, keeping only those above 4 days**

```sql
SELECT Admission_Type,
       AVG(Length_of_Stay) AS Average_Length_Of_Stay
FROM Patients
GROUP BY Admission_Type
HAVING AVG(Length_of_Stay) > 4;
```

**Classify patients into age groups**

```sql
SELECT Patient_ID, Patient_Name, Age,
       CASE
           WHEN Age < 40 THEN 'Young'
           WHEN Age BETWEEN 40 AND 59 THEN 'Middle-aged'
           WHEN Age >= 60 THEN 'Elders'
           ELSE 'Unknown'
       END AS Age_Group
FROM Patients;
```

**Doctor(s) who treated the most patients (handles ties)**

```sql
SELECT TOP 1 WITH TIES
       d.Doctor_ID, d.Doctor_Name, d.Specialization,
       COUNT(*) AS Total_Patients
FROM dbo.Patients AS p
INNER JOIN dbo.Doctors AS d
    ON p.Doctor_ID = d.Doctor_ID
GROUP BY d.Doctor_ID, d.Doctor_Name, d.Specialization
ORDER BY COUNT(*) DESC;
```

## Repository Structure

```
├── sql/        # SQLQuery_LMS_ASSIGNMENT_BY_IBRAHEEM_TUNDE.sql
├── data/       # Patients and Doctors dummy data (CSV)
├── images/     # Query and result screenshots
└── README.md
```

## Notes

- Several questions include an alternative way to write the same query (marked with "OR"), showing different approaches such as `IN` versus multiple `OR` conditions, and aliased versus unaliased joins.

*Completed as part of the TWDP Data Analysis Training. Thanks to the SageIQ tutors.*

## Author

**Ibraheem Tunde Lawal**
Microbiology graduate and aspiring data analyst, Kwara State University
