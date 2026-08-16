# Dify Agent 工具配置说明

本文档用于说明如何配置本应用所依赖的 Dify 工具。

## 1. 工具清单

本应用使用了以下 Dify 工具/插件：
*   **Database 工具 (`hjlarry/database`)**: 用于连接 MySQL 数据库并执行 SQL 查询。
*   **AntV 可视化工具 (`antv/visualization`)**: 用于生成柱状图、饼图等图表。

## 2. Database 工具配置

1.  在 Dify 的「工具插件」市场中，确保已安装 `hjlarry/database` 插件。
2.  在 Agent 编排界面的「工具」栏，添加 `Database SQL Execute` 工具。
3.  在工具的「授权」或「设置」中，配置数据库连接：
    *   **连接 URI (示例)**：`mysql+pymysql://用户名:密码@主机地址:端口/数据库名`
    *   **注意**：请使用 `mysql+pymysql://` 格式，而不是 `mysql://`，以避免 `ModuleNotFoundError: No module named 'MySQLdb'` 的错误。
    *   **提示**：如果 Dify 部署在 Docker 中，且数据库也在 Docker 内，数据库主机地址可尝试使用 `host.docker.internal`。

## 3. AntV 可视化工具配置

1.  在 Dify 的「工具插件」市场中，确保已安装 `antv/visualization` 插件。
2.  在 Agent 编排界面的「工具」栏，根据需要添加 `visualization 生成柱状图`、`visualization 生成饼图`、`visualization 生成词云图` 等图表工具。
3.  此工具无需额外配置凭证，直接启用即可。

## 4. 导入与使用

1.  在 Dify 工作室中，点击「导入 DSL」按钮，选择本仓库中的 `dify/agent-export.yml` 文件。
2.  导入成功后，务必检查并配置 Database 工具的连接 URI（见上文第 2 节）。
3.  导入示例数据（见 `database/sample_data.sql`）后，即可开始测试。