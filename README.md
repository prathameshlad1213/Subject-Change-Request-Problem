==============================================
           SUBJECT CHANGE REQUEST SYSTEM
                 MySQL Assignment
==============================================

Author: Prathamesh Lad
Date: July 2025
Database: MySQL
Project Type: Stored Procedure Based Automation
==============================================

📌 PROBLEM STATEMENT
----------------------------------------------
A college requires a system to manage and track students' Open Elective subject changes while maintaining the complete history of their subject selections.

Whenever a student changes their elective, the system should:
- Keep a record of the newly chosen subject (as active)
- Keep previous subjects in the database but mark them as inactive

Two main tables are used:
1. SubjectAllotments – records all subject allocations with status
2. SubjectRequest – stores the student's latest request for a subject

----------------------------------------------
🎯 OBJECTIVES
----------------------------------------------
- Track changes in elective subjects
- Maintain historical data of all subjects allotted
- Ensure only one subject is marked as active per student
- Automatically process subject requests

----------------------------------------------
📂 DATABASE STRUCTURE
----------------------------------------------
Table: SubjectAllotments
Columns:
- StudentId (VARCHAR) : unique student identifier
- SubjectId (VARCHAR) : elective subject code
- Is_valid (BIT)      : 1 if currently active, 0 if inactive

Table: SubjectRequest
Columns:
- StudentId (VARCHAR)
- SubjectId (VARCHAR)

----------------------------------------------
🗃️ SAMPLE DATA BEFORE PROCESSING
----------------------------------------------
SubjectAllotments:
+------------+-----------+----------+
| StudentId  | SubjectId | Is_valid |
+------------+-----------+----------+
| 159103036  | PO1491    |    1     |
| 159103036  | PO1492    |    0     |
| 159103036  | PO1493    |    0     |
| 159103036  | PO1494    |    0     |
| 159103036  | PO1495    |    0     |
+------------+-----------+----------+

SubjectRequest:
+------------+-----------+
| StudentId  | SubjectId |
+------------+-----------+
| 159103036  | PO1496    |
| 159103037  | PO1497    |
+------------+-----------+

----------------------------------------------
⚙️ STORED PROCEDURE WORKFLOW
----------------------------------------------
The stored procedure "ProcessSubjectRequests" does the following:
1. Iterates through all entries in the SubjectRequest table
2. For each student:
   a) If the student exists in SubjectAllotments:
       - Check if requested subject is different from current active subject
       - If yes, mark current subject as inactive and insert new subject as active
   b) If the student doesn't exist in SubjectAllotments:
       - Insert the new subject as active
3. Preserves history of all subject changes

----------------------------------------------
🧾 FINAL OUTPUT AFTER PROCESSING
----------------------------------------------
SubjectAllotments:
+------------+-----------+----------+
| StudentId  | SubjectId | Is_valid |
+------------+-----------+----------+
| 159103036  | PO1491    |    0     |
| 159103036  | PO1492    |    0     |
| 159103036  | PO1493    |    0     |
| 159103036  | PO1494    |    0     |
| 159103036  | PO1495    |    0     |
| 159103036  | PO1496    |    1     |
| 159103037  | PO1497    |    1     |
+------------+-----------+----------+


