# MyGive 作业提交和测试系统

这是一个简单的作业提交、测试和评分系统，实现了8个主要的shell脚本命令。

## 系统组件

### 主要脚本

1. **mygive-add** - 创建新作业
2. **mygive-submit** - 学生提交作业
3. **mygive-summary** - 查看所有作业摘要
4. **mygive-status** - 查看学生提交状态
5. **mygive-fetch** - 获取学生提交内容
6. **mygive-test** - 运行学生测试
7. **mygive-mark** - 运行评分测试
8. **mygive-rm** - 删除作业

### 辅助脚本

- **create_test_files.sh** - 创建示例测试文件
- **test0.sh** 到 **test9.sh** - 测试脚本

## 使用方法

### 1. 创建作业

```bash
./mygive-add <assignment> <tests-file>
```

- `assignment`: 作业名称（必须以小写字母开头，只能包含字母、数字和下划线）
- `tests-file`: 测试文件路径（tar格式）

示例：
```bash
./mygive-add lab1 multiply.tests
```

### 2. 提交作业

```bash
./mygive-submit <assignment> <zid> <filename>
```

- `assignment`: 作业名称
- `zid`: 学生ID（格式：z + 7位数字）
- `filename`: 提交文件路径

示例：
```bash
./mygive-submit lab1 z5000000 my_program.sh
```

### 3. 查看摘要

```bash
./mygive-summary
```

显示所有作业及其提交学生数量。

### 4. 查看学生状态

```bash
./mygive-status <zid>
```

显示指定学生的所有提交。

### 5. 获取提交内容

```bash
./mygive-fetch <assignment> <zid> [n]
```

- `n`: 可选参数，指定提交编号
  - 正数：第n个提交
  - 负数：倒数第n个提交
  - 0或省略：最后一个提交

示例：
```bash
./mygive-fetch lab1 z5000000     # 获取最后一个提交
./mygive-fetch lab1 z5000000 1   # 获取第一个提交
./mygive-fetch lab1 z5000000 -1  # 获取倒数第二个提交
```

### 6. 运行学生测试

```bash
./mygive-test <assignment> <filename>
```

运行作业的学生测试（不包含marks文件的测试）。

### 7. 运行评分测试

```bash
./mygive-mark <assignment>
```

运行作业的评分测试（包含marks文件的测试）。

### 8. 删除作业

```bash
./mygive-rm <assignment>
```

删除指定的作业及其所有提交。

## 测试文件格式

测试文件是tar格式，包含多个测试目录。每个测试目录可以包含以下文件：

- `arguments` - 命令行参数
- `stdin` - 标准输入
- `stdout` - 期望的标准输出
- `stderr` - 期望的标准错误输出
- `exit_status` - 期望的退出状态（默认0）
- `options` - 比较选项（bcdw）
- `marks` - 分数（如果存在，则为评分测试）

### 比较选项

- `b` - 忽略空行差异
- `c` - 忽略大小写差异
- `d` - 只比较数字和换行符
- `w` - 忽略空格和制表符差异

## 数据存储

所有数据存储在 `.mygive` 目录中：

```
.mygive/
├── <assignment1>/
│   ├── tests/
│   │   └── <tests-file>
│   └── submissions/
│       ├── <zid1>/
│       │   ├── submission_1
│       │   ├── submission_1_info
│       │   ├── submission_2
│       │   └── submission_2_info
│       └── <zid2>/
└── <assignment2>/
```

## 运行测试

运行所有测试脚本：

```bash
chmod +x test*.sh
./test0.sh
./test1.sh
# ... 等等
```

或者运行单个测试：

```bash
./test0.sh  # 基本功能测试
./test1.sh  # 错误处理测试
./test2.sh  # 多提交测试
# ... 等等
```

## 示例工作流程

1. 创建作业：
```bash
./create_test_files.sh
./mygive-add lab1 multiply.tests
```

2. 学生提交：
```bash
./mygive-submit lab1 z5000000 my_program.sh
```

3. 运行测试：
```bash
./mygive-test lab1 my_program.sh
```

4. 查看状态：
```bash
./mygive-status z5000000
./mygive-summary
```

5. 评分：
```bash
./mygive-mark lab1
```

6. 清理：
```bash
./mygive-rm lab1
```

## 注意事项

- 所有脚本使用POSIX兼容的shell语法
- 学生ID必须是z + 7位数字格式
- 作业名称必须以小写字母开头
- 文件名只能包含字母、数字、下划线、连字符、点和斜杠
- 系统会自动创建 `.mygive` 目录
- 不要修改 `.mygive/.reference` 目录（如果存在） 