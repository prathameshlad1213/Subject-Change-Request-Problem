-- 1. Create the database
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- 2. Create SubjectAllotments table
CREATE TABLE IF NOT EXISTS SubjectAllotments (
    StudentId VARCHAR(20),
    SubjectId VARCHAR(20),
    Is_valid BIT,
    PRIMARY KEY (StudentId, SubjectId)
);

-- 3. Create SubjectRequest table
CREATE TABLE IF NOT EXISTS SubjectRequest (
    StudentId VARCHAR(20),
    SubjectId VARCHAR(20)
);

-- 4. Insert sample data into SubjectAllotments
INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid) VALUES
('159103036', 'PO1491', 1),
('159103036', 'PO1492', 0),
('159103036', 'PO1493', 0),
('159103036', 'PO1494', 0),
('159103036', 'PO1495', 0);

-- 5. Insert sample data into SubjectRequest
INSERT INTO SubjectRequest (StudentId, SubjectId) VALUES
('159103036', 'PO1496'),    -- Existing student, new subject
('159103037', 'PO1497');    -- New student not in SubjectAllotments

-- 6. Create stored procedure
DELIMITER $$

CREATE PROCEDURE ProcessSubjectRequests()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_StudentId VARCHAR(20);
    DECLARE v_SubjectId VARCHAR(20);
    
    -- Cursor to iterate SubjectRequest table
    DECLARE cur CURSOR FOR 
        SELECT StudentId, SubjectId FROM SubjectRequest;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO v_StudentId, v_SubjectId;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Case 1: Student already exists in SubjectAllotments
        IF EXISTS (SELECT 1 FROM SubjectAllotments WHERE StudentId = v_StudentId) THEN
            -- Check if current valid subject is different from request
            IF EXISTS (
                SELECT 1 FROM SubjectAllotments
                WHERE StudentId = v_StudentId AND Is_valid = 1 AND SubjectId != v_SubjectId
            ) THEN
                -- Invalidate current subject
                UPDATE SubjectAllotments 
                SET Is_valid = 0 
                WHERE StudentId = v_StudentId AND Is_valid = 1;
                
                -- Insert new subject as valid
                INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
                VALUES (v_StudentId, v_SubjectId, 1);
            END IF;
            
        ELSE
            -- Case 2: New student, insert directly
            INSERT INTO SubjectAllotments (StudentId, SubjectId, Is_valid)
            VALUES (v_StudentId, v_SubjectId, 1);
        END IF;
    END LOOP;
    
    CLOSE cur;
END$$

DELIMITER ;

-- 7. Call the stored procedure
CALL ProcessSubjectRequests();

-- 8. View final result
SELECT * FROM SubjectAllotments ORDER BY StudentId, Is_valid DESC;
