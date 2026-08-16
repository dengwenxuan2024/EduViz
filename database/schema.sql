-- ============================================================
-- 数据库表结构设计
-- 设计参考：Dify 官方教程 + 学生成绩管理系统需求
-- 表结构：classes（班级）、students（学生）、grades（成绩）、evaluations（教师评价）
-- 说明：四张表通过外键关联，形成完整的教学数据模型
-- ============================================================

-- 1. 班级表
CREATE TABLE classes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    grade VARCHAR(20) NOT NULL
);

-- 2. 学生表
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL UNIQUE,
    student_name VARCHAR(50) NOT NULL,
    class_id INT NOT NULL,
    grade VARCHAR(20) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

-- 3. 成绩表
CREATE TABLE grades (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    subject VARCHAR(50) NOT NULL,
    score DECIMAL(5,2) NOT NULL,
    exam_date DATE NOT NULL,
    semester VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

-- 4. 教师评价表
CREATE TABLE evaluations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(20) NOT NULL,
    teacher_name VARCHAR(50) NOT NULL,
    evaluation TEXT NOT NULL,
    rating INT DEFAULT NULL,
    eval_date DATE NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);