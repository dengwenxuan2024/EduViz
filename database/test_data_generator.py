#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
测试数据生成脚本
用于生成 students、grades、evaluations 表的模拟数据
"""

import random
import datetime
import json

# 配置
NUM_STUDENTS = 120
NUM_CLASSES = 12
SUBJECTS = ['数学', '英语', '物理', '化学', '生物', '历史', '地理', '政治']
SEMESTERS = ['2024-2025学年第一学期', '2024-2025学年第二学期', '2025-2026学年第一学期']
TEACHERS = ['张老师', '李老师', '王老师']

# 评价关键词库
KEYWORDS = [
    '生动有趣', '耐心细致', '讲解清晰', '逻辑严谨', '语言流畅',
    '板书工整', '善于启发', '因材施教', '认真负责', '条理清晰',
    '课堂活跃', '互动充分', '重点突出', '深入浅出', '感染力强',
    '方法多样', '严格要求', '亲和力强', '表达清晰', '循序渐进',
    '善于引导', '注重细节', '节奏适中', '内容丰富', '通俗易懂'
]

def generate_students():
    """生成学生数据"""
    students = []
    class_names = []
    for g in ['高一', '高二', '高三']:
        for c in range(1, 5):
            class_names.append(f'{g}({c})班')
    
    student_id_counter = 1
    for class_idx, class_name in enumerate(class_names):
        grade = class_name.split('(')[0]
        class_id = class_idx + 1
        for i in range(10):
            students.append({
                'student_id': f'2024{str(student_id_counter).zfill(3)}',
                'student_name': f'学生_{student_id_counter}',
                'class_id': class_id,
                'grade': grade,
                'created_at': datetime.datetime.now().isoformat(),
                'updated_at': datetime.datetime.now().isoformat()
            })
            student_id_counter += 1
    return students

def generate_grades(students):
    """生成成绩数据"""
    grades = []
    base_date = datetime.date(2024, 9, 1)
    for student in students:
        for semester in SEMESTERS:
            for subject in SUBJECTS:
                score = random.randint(60, 100)
                exam_date = base_date + datetime.timedelta(days=random.randint(0, 300))
                grades.append({
                    'student_id': student['student_id'],
                    'subject': subject,
                    'score': round(score, 2),
                    'exam_date': exam_date.isoformat(),
                    'semester': semester,
                    'created_at': datetime.datetime.now().isoformat(),
                    'updated_at': datetime.datetime.now().isoformat()
                })
    return grades

def generate_evaluations(students):
    """生成教师评价数据"""
    evaluations = []
    selected_students = random.sample(students, 20)
    for student in selected_students:
        for teacher in TEACHERS:
            # 随机选3-6个关键词组成评价
            num_keywords = random.randint(3, 6)
            selected_keywords = random.sample(KEYWORDS, num_keywords)
            eval_text = '，'.join(selected_keywords)
            rating = random.randint(3, 5)
            eval_date = datetime.date(2025, 6, random.randint(1, 30))
            evaluations.append({
                'student_id': student['student_id'],
                'teacher_name': teacher,
                'evaluation': eval_text,
                'rating': rating,
                'eval_date': eval_date.isoformat(),
                'created_at': datetime.datetime.now().isoformat(),
                'updated_at': datetime.datetime.now().isoformat()
            })
    return evaluations

def generate_sql(students, grades, evaluations):
    """生成SQL插入语句"""
    sql_lines = []
    # 学生
    for s in students:
        sql_lines.append(
            f"INSERT INTO students (student_id, student_name, class_id, grade, created_at, updated_at) VALUES "
            f"('{s['student_id']}', '{s['student_name']}', {s['class_id']}, '{s['grade']}', NOW(), NOW());"
        )
    # 成绩
    for g in grades:
        sql_lines.append(
            f"INSERT INTO grades (student_id, subject, score, exam_date, semester, created_at, updated_at) VALUES "
            f"('{g['student_id']}', '{g['subject']}', {g['score']}, '{g['exam_date']}', '{g['semester']}', NOW(), NOW());"
        )
    # 评价
    for e in evaluations:
        sql_lines.append(
            f"INSERT INTO evaluations (student_id, teacher_name, evaluation, rating, eval_date, created_at, updated_at) VALUES "
            f"('{e['student_id']}', '{e['teacher_name']}', '{e['evaluation']}', {e['rating']}, '{e['eval_date']}', NOW(), NOW());"
        )
    return '\n'.join(sql_lines)

if __name__ == '__main__':
    students = generate_students()
    grades = generate_grades(students)
    evaluations = generate_evaluations(students)
    
    print('-- 自动生成测试数据')
    print('-- 学生数:', len(students))
    print('-- 成绩数:', len(grades))
    print('-- 评价数:', len(evaluations))
    print()
    print(generate_sql(students, grades, evaluations))