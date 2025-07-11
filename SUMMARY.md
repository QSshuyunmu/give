# MyGive 项目总结

## 项目概述

本项目实现了一个完整的作业提交、测试和评分系统，包含8个主要的shell脚本命令，完全符合POSIX标准。

## 实现的功能

### 核心命令

1. **mygive-add** - 创建新作业
   - 验证作业名称格式（小写字母开头，只包含字母数字下划线）
   - 验证测试文件路径格式
   - 自动创建.mygive目录结构
   - 防止重复创建同名作业

2. **mygive-submit** - 学生提交作业
   - 验证学生ID格式（z + 7位数字）
   - 验证文件名格式
   - 支持多次提交，自动编号
   - 记录提交时间、文件大小等信息

3. **mygive-summary** - 查看作业摘要
   - 列出所有作业
   - 显示每个作业的提交学生数量
   - 跳过.reference目录

4. **mygive-status** - 查看学生状态
   - 显示指定学生的所有提交
   - 按作业分组显示
   - 包含提交编号、文件名、大小、时间

5. **mygive-fetch** - 获取提交内容
   - 支持正向索引（1, 2, 3...）
   - 支持负向索引（0, -1, -2...）
   - 默认获取最后一个提交
   - 验证索引范围

6. **mygive-test** - 运行学生测试
   - 只运行没有marks文件的测试
   - 支持命令行参数、stdin、stdout、stderr、退出状态
   - 支持比较选项（bcdw）
   - 自动设置文件可执行权限

7. **mygive-mark** - 运行评分测试
   - 只运行有marks文件的测试
   - 为每个学生运行最后一个提交
   - 计算总分和得分
   - 显示详细的测试结果

8. **mygive-rm** - 删除作业
   - 完全删除作业及其所有提交
   - 验证作业存在性

### 测试脚本

创建了10个全面的测试脚本：

- **test0.sh** - 基本功能测试
- **test1.sh** - 错误处理测试
- **test2.sh** - 多提交测试
- **test3.sh** - 作业删除测试
- **test4.sh** - 测试和评分功能测试
- **test5.sh** - 边界情况测试
- **test6.sh** - 并发和文件系统测试
- **test7.sh** - 复杂测试场景
- **test8.sh** - 完整工作流程测试
- **test9.sh** - 性能和压力测试

### 辅助工具

- **create_test_files.sh** - 创建示例测试文件
- **demo.sh** - 系统功能演示
- **README.md** - 详细使用说明

## 技术特点

### 1. POSIX兼容性
- 所有脚本使用POSIX兼容的shell语法
- 使用/bin/dash作为解释器
- 只使用允许的外部命令

### 2. 错误处理
- 全面的参数验证
- 清晰的错误消息
- 适当的退出状态码

### 3. 数据存储
- 结构化的目录组织
- 分离的测试和提交存储
- 元数据文件保存提交信息

### 4. 测试支持
- 灵活的测试文件格式
- 多种比较选项
- 分离的学生测试和评分测试

### 5. 性能考虑
- 高效的文件操作
- 合理的目录结构
- 支持大量数据

## 文件结构

```
give/
├── mygive-add          # 创建作业
├── mygive-submit       # 提交作业
├── mygive-summary      # 查看摘要
├── mygive-status       # 查看状态
├── mygive-fetch        # 获取提交
├── mygive-test         # 运行测试
├── mygive-mark         # 运行评分
├── mygive-rm           # 删除作业
├── create_test_files.sh # 创建测试文件
├── demo.sh             # 演示脚本
├── test0.sh - test9.sh # 测试脚本
├── README.md           # 使用说明
└── SUMMARY.md          # 项目总结
```

## 数据存储结构

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

## 测试文件格式

测试文件是tar格式，包含多个测试目录：

```
test_file.tests
├── test1/
│   ├── arguments
│   ├── stdin
│   ├── stdout
│   ├── stderr
│   ├── exit_status
│   ├── options
│   └── marks (可选)
└── test2/
    └── ...
```

## 使用示例

```bash
# 创建作业
./mygive-add lab1 multiply.tests

# 提交作业
./mygive-submit lab1 z5000000 my_program.sh

# 查看状态
./mygive-status z5000000

# 运行测试
./mygive-test lab1 my_program.sh

# 评分
./mygive-mark lab1

# 删除作业
./mygive-rm lab1
```

## 项目亮点

1. **完整性** - 实现了所有要求的功能
2. **健壮性** - 全面的错误处理和验证
3. **可测试性** - 10个全面的测试脚本
4. **可维护性** - 清晰的代码结构和注释
5. **可扩展性** - 模块化设计，易于扩展
6. **文档完善** - 详细的使用说明和示例

## 总结

这个MyGive系统成功实现了一个功能完整、健壮可靠的作业提交和测试系统。所有脚本都严格遵循POSIX标准，具有良好的错误处理能力和用户体验。通过10个测试脚本的全面测试，确保了系统的正确性和稳定性。 