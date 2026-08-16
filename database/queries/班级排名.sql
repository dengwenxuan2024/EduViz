-- ============================================================
-- 班级平均分排名
-- 说明：按年级、班级分组统计平均分，并按分数降序排列
-- ============================================================

SELECT 
    c.grade,
    c.class_name,
    ROUND(AVG(g.score), 2) AS avg_score,
    ROUND(MIN(g.score), 2) AS min_score,
    ROUND(MAX(g.score), 2) AS max_score,
    COUNT(DISTINCT s.student_id) AS student_count
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN classes c ON s.class_id = c.id
WHERE c.grade = '高一'  -- 可替换为 '高二' 或 '高三'
GROUP BY c.class_name, c.grade
ORDER BY avg_score DESC;