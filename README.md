# EduViz：AI驱动的智能教学数据分析问询助手

> 2026 GOAI 世界人工智能开源大赛 —— 无界应用赛道 · AI+教育方向 参赛作品

EduViz 是一个基于 Dify Agent 的智能教学数据分析问询系统，让教育工作者通过自然语言对话，即可完成从数据查询到分析决策的全流程，无需具备 SQL 或数据分析技能。


## 项目背景

在中小学校和培训机构中，学生成绩数据的分析普遍面临以下困境：

- 技术门槛高：班主任、年级主任等教育工作者虽最了解教学情况，但大多不具备 SQL 或数据分析技能
- 效率低下：获取一个简单的分析结果（如"各班平均分排名"），通常需要向信息技术部门提需求，等待数小时甚至数天
- 分析维度单一：传统的成绩查询只能看到"分数"，缺乏多维度、多角度的综合分析能力

EduViz 正是为解决这些问题而生。


## 项目定位

EduViz 是一个基于 Dify Agent 的智能教学数据分析助手，让教育工作者通过自然语言对话，即可完成从数据查询到分析决策的全流程。

本作品参加 GOAI 世界人工智能开源大赛「无界应用」赛道 · AI+教育方向。


## 核心功能

### 自然语言问询
用户直接用自然语言提问，系统自动理解意图并生成分析结果。

### 12 种可视化图表
根据数据特征自动选择最合适的图表类型：

| 图表类型 | 适用场景 |
| :--- | :--- |
| 柱状图 | 类别对比（班级排名、科目对比） |
| 条形图 | 长标签类别对比 |
| 折线图 | 时间趋势（各学期变化） |
| 面积图 | 时间趋势 + 累积量展示 |
| 饼图 | 占比分布（成绩分段比例） |
| 雷达图 | 多维度综合对比（各科能力画像） |
| 箱线图 | 分布统计（成绩分散程度） |
| 小提琴图 | 分布形态与密度 |
| 散点图 | 两变量相关性 |
| 直方图 | 频数分布 |
| 瀑布图 | 累积变化 |
| 词云图 | 文本评价分析（教师评价关键词） |

### 多维度分析
- 班级排名对比
- 学期趋势变化
- 成绩分布形态
- 学科能力画像
- 成绩分段占比
- 学科相关性分析
- 教学评价关键词分析


## 技术架构

用户输入 → Dify Agent → 工具调用 → 结果交付
                ↓
        ┌───────┴───────┐
        ↓               ↓
   Database工具    AntV图表工具
        ↓               ↓
   MySQL数据库    可视化图表

### 核心技术栈

| 组件 | 技术选型 | 说明 |
| :--- | :--- | :--- |
| Agent框架 | Dify Agent | 自主推理、工具调度 |
| 数据库 | MySQL 8.0+ | 数据存储 |
| 图表引擎 | AntV Visualization | 12种图表类型 |
| 部署 | Docker Compose | 一键部署 |


## 项目结构

EduViz/
├── README.md                        # 项目说明（本文件）
├── LICENSE                          # 开源许可证（Apache 2.0）
├── .gitignore                       # Git忽略文件配置
│
├── docs/                            # 详细文档
│   ├── images/                      # 文档图片
│   ├── 01-项目背景与场景痛点.md      # 项目背景与目标用户说明
│   ├── 02-技术架构图.md             # 系统架构与数据流转说明
│   ├── 03-功能清单与使用说明.md      # 功能列表与部署指南
│   ├── 04-数据来源与隐私保护说明.md  # 数据来源与隐私保护说明
│   └── 05-异常处理与效果验证.md      # 异常处理与测试用例
│
├── dify/                            # Dify 应用配置（核心！可运行、可复制）
│   ├── agent-export.yml             # Dify Agent 导出文件（含所有提示词）
│   └── tools-config.md              # 工具配置说明（Database、AntV等）
│
├── database/                        # 数据库相关
│   ├── schema.sql                   # 完整建表语句（4张表）
│   ├── sample_data.sql              # 示例数据（可快速体验）
│   ├── test_data_generator.py       # 测试数据生成脚本
│   └── queries/                     # 典型查询SQL参考
│       ├── 班级排名.sql
│       ├── 科目趋势.sql
│       └── 教师评价词云.sql
│
├── docker/                          # 一键部署配置
│   ├── docker-compose.yml           # Dify + MySQL + Redis 完整编排
│   └── .env.example                 # 环境变量示例
│
├── demo/                            # 演示材料
│   ├── demo-video.mp4               # 演示视频
│   ├── 01-提问界面.png               # 功能截图
│   ├── 02-班级排名结果.png
│   ├── 03-多图表展示.png
│   └── case-studies.md              # 典型使用场景案例
│
└── prompts/                         # 提示词工程记录
    ├── system-prompt-final.md       # 最终版系统提示词
    ├── prompt-iteration-log.md      # 提示词迭代优化过程（6个版本）
    └── few-shot-examples.json       # Few-shot 示例集


## 快速开始

### 环境要求

| 依赖项 | 版本要求 |
| :--- | :--- |
| Docker | 20.10+ |
| Docker Compose | 2.24.0+ |
| MySQL | 8.0+ |
| Dify | 1.16.0+ |

### 部署步骤

1. 启动 Dify
   cd docker
   docker compose up -d

2. 导入数据库
   mysql -u root -p dify_test_v2 < database/schema.sql
   mysql -u root -p dify_test_v2 < database/sample_data.sql

3. 导入 Agent 配置
   - 进入 Dify 工作室
   - 点击「导入 DSL」
   - 选择 dify/agent-export.yml

4. 配置 Database 工具
   - 在 Agent 的「工具」中添加 Database 工具
   - 配置连接信息：
     mysql+pymysql://用户名:密码@主机:端口/dify_test_v2

5. 添加 AntV 图表工具
   - 在 Dify 插件市场安装 antv/visualization 插件
   - 在 Agent 中启用需要的图表工具

6. 开始使用
   - 在聊天框中输入测试问题，例如：
     - "高一年级各班级的平均分排名是多少？"
     - "分析高二年级整体成绩情况"
     - "张老师的评价有哪些高频关键词？"


## 测试用例

| 用例 | 测试问题 | 预期图表 |
| :--- | :--- | :--- |
| TC-01 | 高一年级各班级人数占比 | 饼图 |
| TC-02 | 高二年级各学期平均分变化趋势 | 面积图 |
| TC-03 | 高一各班成绩分布形态 | 小提琴图 |
| TC-04 | 高一各班各科目平均分排名 | 条形图 |
| TC-05 | 学生_1各学期总成绩累积变化 | 瀑布图 |
| TC-06 | 查询各班级的平均分和标准差 | 文字+表格 |
| TC-07 | 张三的各科成绩怎么样？ | 纯文字（异常处理） |
| TC-08 | 请用瀑布图展示各科成绩排名 | 条形图（自动纠错） |


## 模型测试结论

经过多轮测试，推荐使用以下模型：

| 模型 | 稳定性 | 速度 | 推荐指数 |
| :--- | :--- | :--- | :--- |
| qwen3-max | 极高 | 中等 | 极高 |
| qwen3.7-plus | 极高 | 快 | 极高 |
| DeepSeek-V4-Flash | 高 | 慢 | 高 |

详细测试数据见 prompts/prompt-iteration-log.md。


## 参赛信息

- 赛事名称：GOAI 世界人工智能开源大赛（Global Open-source AI Challenge）
- 参赛赛道：无界应用（Boundless Agents）
- 参赛方向：AI+教育
- 初赛截止：2026年8月16日
- 赛事官网：https://goaihz.com


## 许可证

本项目基于 Dify（https://github.com/langgenius/dify）（Apache License 2.0）构建，采用 Apache License 2.0 开源协议。

Copyright (c) 2026 邓雯煊

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0


## 作者

| 项目 | 信息 |
| :--- | :--- |
| 作者 | 邓雯煊 |
| 单位 | 澳门科技大学 |
| 身份 | 学生 |
| 参赛赛道 | GOAI 无界应用 · AI+教育 |


## 致谢

- Dify（https://github.com/langgenius/dify） — 开源 LLM 应用开发平台
- AntV（https://antv.antgroup.com/） — 数据可视化解决方案
- GOAI 大赛组委会


## 联系方式

如有问题或建议，欢迎通过 GitHub Issue 交流。