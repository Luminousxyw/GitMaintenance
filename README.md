# GitHub 项目开发流程

## 目标

所有新项目统一采用相同的安全配置和开发流程，避免：

- API Key 泄露
- 证书或私钥误提交
- AI 插件缓存误提交
- 忘记配置 Git Hook
- 项目结构混乱

------

# 一、新建项目

创建项目目录：

```powershell
mkdir ProjectName
cd ProjectName
```

初始化 Git 仓库：

```powershell
git init
```

------

# 二、初始化安全配置

运行安全初始化脚本：

```powershell
..\init-security.ps1
```

脚本自动完成：

- 检查当前目录是否为 Git 仓库
- 检查 gitleaks 是否安装
- 检查 pre-commit 是否安装
- 复制 `.gitignore`
- 复制 `.pre-commit-config.yaml`
- 安装 pre-commit Hook
- 扫描现有文件

如果发现敏感信息：

- API Key
- Token
- 私钥
- 证书

则必须先处理后再继续开发。

------

# 三、创建项目结构

推荐结构：

```text
ProjectName/
├─ src/
├─ include/
├─ docs/
├─ tests/
├─ .gitignore
├─ .pre-commit-config.yaml
└─ README.md
```

目录说明：

| 目录      | 用途             |
| --------- | ---------------- |
| src       | 源代码           |
| include   | 头文件或公共模块 |
| docs      | 项目文档         |
| tests     | 测试代码         |
| README.md | 项目说明         |

------

# 四、开始开发

编写代码：

```text
src/
include/
docs/
```

开发过程中：

- 不提交 `.env`
- 不提交证书
- 不提交私钥
- 不提交数据库文件
- 不提交 AI 插件缓存

这些文件由 `.gitignore` 自动忽略。

------

# 五、首次提交

查看状态：

```powershell
git status
```

添加文件：

```powershell
git add .
```

提交：

```powershell
git commit -m "Initial commit"
```

提交时：

- pre-commit 自动运行
- Gitleaks 自动扫描

如果检测到敏感信息：

```text
Commit blocked
```

必须先修复问题再提交。

------

# 六、创建 GitHub 仓库

在 GitHub 创建仓库：

- Private（默认）
- Public（需要开源时）

创建完成后获得仓库地址。

------

# 七、关联远程仓库

添加远程：

```powershell
git remote add origin git@github.com:用户名/ProjectName.git
```

验证：

```powershell
git remote -v
```

------

# 八、首次推送

```powershell
git push -u origin main
```

首次推送成功后：

以后只需：

```powershell
git push
```

------

# 九、日常开发流程

获取最新代码：

```powershell
git pull
```

开发：

```text
编写代码
修改文档
添加测试
```

提交：

```powershell
git add .
git commit -m "实现某功能"
```

推送：

```powershell
git push
```

循环执行：

```text
Pull
 ↓
开发
 ↓
Commit
 ↓
Push
 ↓
Pull
```

------

# 十、安全检查清单

每次提交前确认：

-  没有提交 API Key
-  没有提交 Token
-  没有提交证书
-  没有提交私钥
-  没有提交数据库文件
-  没有提交 AI 插件缓存
-  Gitleaks 检查通过
-  Pre-commit 检查通过

------

# 当前安全体系

第一层：

```text
.gitignore
```

阻止敏感文件进入 Git。

第二层：

```text
Pre-commit
```

提交前自动检查。

第三层：

```text
Gitleaks
```

检测密钥和凭据泄露。

第四层：

```text
GitHub Secret Scanning
```

远程仓库二次检查。

------

# 新项目标准操作

每个新项目固定执行：

```powershell
mkdir ProjectName
cd ProjectName

git init

..\init-security.ps1

git add .
git commit -m "Initial commit"

git remote add origin git@github.com:用户名/ProjectName.git

git push -u origin main
```

完成项目初始化。