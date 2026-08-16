-- ============================================================
-- 各学期各科目平均分趋势
-- 说明：按学期、科目分组统计平均分，展示时间变化趋势
-- ============================================================

SELECT 
    g.semester,
    g.subject,
    ROUND(AVG(g.score), 2) AS avg_score
FROM grades g
JOIN students s ON g.student_id = s.student_id
JOIN classes c ON s.class_id = c.id
WHERE c.grade = '高一'  -- 可替换为 '高二' 或 '高三'
GROUP BY g.semester, g.subject
ORDER BY g.semester, avg_score DESC;