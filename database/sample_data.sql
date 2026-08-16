-- ============================================================
-- 示例数据
-- 说明：插入12个班级、120名学生、2880条成绩、60条评价
-- ============================================================

-- 1. 插入班级数据
INSERT INTO classes (class_name, grade) VALUES
('高一(1)班', '高一'),
('高一(2)班', '高一'),
('高一(3)班', '高一'),
('高一(4)班', '高一'),
('高二(1)班', '高二'),
('高二(2)班', '高二'),
('高二(3)班', '高二'),
('高二(4)班', '高二'),
('高三(1)班', '高三'),
('高三(2)班', '高三'),
('高三(3)班', '高三'),
('高三(4)班', '高三');

-- 2. 插入学生数据（每班10人，共120人）
-- 使用存储过程生成（或直接INSERT，这里提供存储过程方式）
DELIMITER $$
CREATE PROCEDURE generate_students()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE class_id INT DEFAULT 1;
    DECLARE student_num INT DEFAULT 1;
    DECLARE current_class_id INT;
    DECLARE current_grade VARCHAR(20);
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR SELECT id, grade FROM classes;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO current_class_id, current_grade;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET i = 1;
        WHILE i <= 10 DO
            INSERT INTO students (student_id, student_name, class_id, grade, created_at, updated_at)
            VALUES (
                CONCAT('2024', LPAD(student_num, 3, '0')),
                CONCAT('学生_', student_num),
                current_class_id,
                current_grade,
                NOW(),
                NOW()
            );
            SET student_num = student_num + 1;
            SET i = i + 1;
        END WHILE;
    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;

CALL generate_students();

-- 3. 插入成绩数据（每个学生3学期×8科目，共2880条）
DELIMITER $$
CREATE PROCEDURE generate_grades()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE v_student_id VARCHAR(20);
    DECLARE cur CURSOR FOR SELECT student_id FROM students;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO v_student_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- 第一学期（8科）
        INSERT INTO grades (student_id, subject, score, exam_date, semester, created_at, updated_at) VALUES
            (v_student_id, '数学', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW()),
            (v_student_id, '英语', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW()),
            (v_student_id, '物理', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW()),
            (v_student_id, '化学', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW()),
            (v_student_id, '生物', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW()),
            (v_student_id, '历史', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW()),
            (v_student_id, '地理', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW()),
            (v_student_id, '政治', ROUND(60 + RAND()*40, 2), DATE_ADD('2024-09-01', INTERVAL RAND()*90 DAY), '2024-2025学年第一学期', NOW(), NOW());
        -- 第二学期（8科）
        INSERT INTO grades (student_id, subject, score, exam_date, semester, created_at, updated_at) VALUES
            (v_student_id, '数学', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW()),
            (v_student_id, '英语', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW()),
            (v_student_id, '物理', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW()),
            (v_student_id, '化学', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW()),
            (v_student_id, '生物', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW()),
            (v_student_id, '历史', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW()),
            (v_student_id, '地理', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW()),
            (v_student_id, '政治', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-02-01', INTERVAL RAND()*90 DAY), '2024-2025学年第二学期', NOW(), NOW());
        -- 第三学期（8科）
        INSERT INTO grades (student_id, subject, score, exam_date, semester, created_at, updated_at) VALUES
            (v_student_id, '数学', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW()),
            (v_student_id, '英语', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW()),
            (v_student_id, '物理', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW()),
            (v_student_id, '化学', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW()),
            (v_student_id, '生物', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW()),
            (v_student_id, '历史', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW()),
            (v_student_id, '地理', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW()),
            (v_student_id, '政治', ROUND(60 + RAND()*40, 2), DATE_ADD('2025-09-01', INTERVAL RAND()*90 DAY), '2025-2026学年第一学期', NOW(), NOW());
    END LOOP;
    CLOSE cur;
END$$
DELIMITER ;

CALL generate_grades();

-- 4. 插入教师评价数据（60条）
INSERT INTO evaluations (student_id, teacher_name, evaluation, rating, eval_date, created_at, updated_at) VALUES
('2024001', '张老师', '讲课生动有趣，能激发学生学习兴趣', 5, '2025-06-15', NOW(), NOW()),
('2024001', '李老师', '讲解清晰，但有时进度太快', 4, '2025-06-15', NOW(), NOW()),
('2024001', '王老师', '课堂互动充分，但内容有时偏难', 3, '2025-06-16', NOW(), NOW()),
('2024002', '张老师', '非常有耐心，课后答疑很细致', 5, '2025-06-16', NOW(), NOW()),
('2024002', '王老师', '教学严谨，逻辑清晰', 4, '2025-06-17', NOW(), NOW()),
('2024002', '李老师', '语言生动，课堂氛围活跃', 5, '2025-06-17', NOW(), NOW()),
('2024003', '李老师', '教学方法多样，课堂氛围活跃', 5, '2025-06-17', NOW(), NOW()),
('2024003', '张老师', '知识点讲解透彻，容易理解', 5, '2025-06-18', NOW(), NOW()),
('2024003', '王老师', '作业布置合理，批改认真', 4, '2025-06-18', NOW(), NOW()),
('2024004', '王老师', '课堂纪律严格，但讲解略显枯燥', 3, '2025-06-18', NOW(), NOW()),
('2024004', '李老师', '善于启发式教学，引导独立思考', 5, '2025-06-19', NOW(), NOW()),
('2024004', '张老师', '板书工整，条理清晰', 4, '2025-06-19', NOW(), NOW()),
('2024005', '张老师', '认真负责，关注每个学生的学习进度', 5, '2025-06-19', NOW(), NOW()),
('2024005', '王老师', '课程设计合理，但语速稍快', 4, '2025-06-20', NOW(), NOW()),
('2024005', '李老师', '课堂氛围轻松，重点突出', 4, '2025-06-20', NOW(), NOW()),
('2024006', '李老师', '课后辅导耐心，能针对薄弱点讲解', 4, '2025-06-20', NOW(), NOW()),
('2024006', '张老师', '教学经验丰富，深入浅出', 5, '2025-06-21', NOW(), NOW()),
('2024006', '王老师', '课堂互动多，但内容有时偏难', 3, '2025-06-21', NOW(), NOW()),
('2024007', '王老师', '课堂氛围轻松，但重点不够突出', 3, '2025-06-21', NOW(), NOW()),
('2024007', '李老师', '语言风趣幽默，深受学生喜爱', 5, '2025-06-22', NOW(), NOW()),
('2024007', '张老师', '注重基础知识巩固，适合打基础', 4, '2025-06-22', NOW(), NOW()),
('2024008', '张老师', '讲课充满激情，感染力强', 5, '2025-06-22', NOW(), NOW()),
('2024008', '王老师', '逻辑严谨，思路清晰', 4, '2025-06-23', NOW(), NOW()),
('2024008', '李老师', '善于调动学生积极性，课堂效率高', 5, '2025-06-23', NOW(), NOW()),
('2024009', '李老师', '授课风格幽默，但偶尔内容不够深入', 3, '2025-06-23', NOW(), NOW()),
('2024009', '张老师', '非常有亲和力，学生都很喜欢', 5, '2025-06-24', NOW(), NOW()),
('2024009', '王老师', '教学进度适中，大多数学生能跟上', 4, '2025-06-24', NOW(), NOW()),
('2024010', '王老师', '课堂互动充分，但内容有时偏难', 3, '2025-06-24', NOW(), NOW()),
('2024010', '李老师', '板书清晰，逻辑性强', 4, '2025-06-25', NOW(), NOW()),
('2024010', '张老师', '讲解细致，注重细节', 5, '2025-06-25', NOW(), NOW()),
('2024011', '张老师', '课堂气氛活跃，学生参与度高', 5, '2025-06-25', NOW(), NOW()),
('2024011', '李老师', '讲解深入浅出，通俗易懂', 4, '2025-06-26', NOW(), NOW()),
('2024011', '王老师', '作业量适中，批改及时', 4, '2025-06-26', NOW(), NOW()),
('2024012', '李老师', '善于发现学生的闪光点', 5, '2025-06-26', NOW(), NOW()),
('2024012', '张老师', '课堂节奏把控得当', 4, '2025-06-27', NOW(), NOW()),
('2024012', '王老师', '教学内容丰富，但重点不够突出', 3, '2025-06-27', NOW(), NOW()),
('2024013', '王老师', '课堂管理能力强，学生专注度高', 4, '2025-06-27', NOW(), NOW()),
('2024013', '李老师', '语言表达清晰，逻辑性强', 5, '2025-06-28', NOW(), NOW()),
('2024013', '张老师', '教学方法灵活，善于因材施教', 5, '2025-06-28', NOW(), NOW()),
('2024014', '张老师', '课堂气氛轻松愉快', 4, '2025-06-28', NOW(), NOW()),
('2024014', '王老师', '讲解透彻，通俗易懂', 5, '2025-06-29', NOW(), NOW()),
('2024014', '李老师', '作业批改认真，反馈及时', 4, '2025-06-29', NOW(), NOW()),
('2024015', '李老师', '善于引导学生思考', 5, '2025-06-29', NOW(), NOW()),
('2024015', '张老师', '课堂互动充分，学生参与积极', 5, '2025-06-30', NOW(), NOW()),
('2024015', '王老师', '教学内容充实，但节奏稍快', 3, '2025-06-30', NOW(), NOW()),
('2024016', '王老师', '课堂纪律好，学习氛围浓厚', 4, '2025-06-30', NOW(), NOW()),
('2024016', '李老师', '语言生动幽默，深受欢迎', 5, '2025-07-01', NOW(), NOW()),
('2024016', '张老师', '板书工整，重点突出', 4, '2025-07-01', NOW(), NOW()),
('2024017', '张老师', '教学经验丰富，方法得当', 5, '2025-07-01', NOW(), NOW()),
('2024017', '王老师', '讲解细致，注重细节', 4, '2025-07-02', NOW(), NOW()),
('2024017', '李老师', '课堂氛围活跃，学生热情高', 5, '2025-07-02', NOW(), NOW()),
('2024018', '李老师', '善于启发式教学，培养思维能力', 5, '2025-07-02', NOW(), NOW()),
('2024018', '张老师', '教学进度合理，学生跟得上', 4, '2025-07-03', NOW(), NOW()),
('2024018', '王老师', '课堂互动多，但秩序良好', 4, '2025-07-03', NOW(), NOW()),
('2024019', '王老师', '教学内容丰富，拓展面广', 4, '2025-07-03', NOW(), NOW()),
('2024019', '李老师', '语言流畅，表达清晰', 5, '2025-07-04', NOW(), NOW()),
('2024019', '张老师', '课堂掌控力强，学生专注', 4, '2025-07-04', NOW(), NOW()),
('2024020', '张老师', '非常有亲和力，关爱学生', 5, '2025-07-04', NOW(), NOW()),
('2024020', '王老师', '教学认真负责，一丝不苟', 5, '2025-07-05', NOW(), NOW()),
('2024020', '李老师', '课堂氛围和谐，学生乐于参与', 4, '2025-07-05', NOW(), NOW());