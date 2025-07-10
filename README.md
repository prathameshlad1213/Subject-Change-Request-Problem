# Subject-Change-Request-Problem
# 📘 Subject Change Request System – MySQL Assignment

## 📌 Problem Statement

A college needs a system to **track and maintain the history of elective subject changes** made by students. At the beginning of the academic year, students may switch their elective subjects, and the college must preserve the **entire change timeline**.

### ✅ Key Requirements:
- Each student can have only **one active subject** (marked with `Is_valid = 1`) at a time.
- All previous subject allotments should be **preserved** with `Is_valid = 0`.
- New subject requests are stored in a separate `SubjectRequest` table.
- When processing requests:
  - If the subject is **different** from the current valid subject, insert the new subject and update old to invalid.
  - If the student is **not present** in the allotments table, insert the record as a valid entry directly.

---

## 🏗️ Database Structure

### 🔹 Table: `SubjectAllotments`
| Column     | Data Type   | Description                         |
|------------|-------------|-------------------------------------|
| StudentId  | VARCHAR     | Unique identifier for student       |
| SubjectId  | VARCHAR     | Code of the elective subject        |
| Is_valid   | BIT         | 1 = active subject, 0 = old subject |

### 🔹 Table: `SubjectRequest`
| Column     | Data Type   | Description                         |
|------------|-------------|-------------------------------------|
| StudentId  | VARCHAR     | Unique identifier for student       |
| SubjectId  | VARCHAR     | New subject requested               |

---

## 📥 Sample Data

### SubjectAllotments (Before Procedure Execution)
+------------+-----------+----------+
| StudentId | SubjectId | Is_valid |
+------------+-----------+----------+
| 159103036 | PO1491 | 1 |
| 159103036 | PO1492 | 0 |
| 159103036 | PO1493 | 0 |
| 159103036 | PO1494 | 0 |
| 159103036 | PO1495 | 0 |
+------------+-----------+----------+


### SubjectRequest
+------------+-----------+
| StudentId | SubjectId |
+------------+-----------+
| 159103036 | PO1496 |
| 159103037 | PO1497 |
+------------+-----------+


---

## ⚙️ Stored Procedure Logic


CALL ProcessSubjectRequests();

The stored procedure processes all rows in SubjectRequest:

If the student's current subject is different:
Marks old subject as Is_valid = 0
Inserts new subject as Is_valid = 1
If the student is new:
Directly inserts the subject with Is_valid = 1

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



✍️ Author
Prathamesh Lad
B.E. Computer Science 

