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
Microbiology graduate and data analyst, Kwara State University
