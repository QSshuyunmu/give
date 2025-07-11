#!/bin/dash

# demo.sh - MyGive系统演示脚本
# 展示系统的基本功能

echo "=== MyGive 系统演示 ==="
echo

# 清理之前的演示数据
rm -rf .mygive

# 创建演示测试文件
echo "1. 创建演示测试文件..."
mkdir -p demo_tests

# 学生测试
mkdir -p demo_tests/test_a
echo "Hello" > demo_tests/test_a/stdout
echo "test_a" > demo_tests/test_a/arguments

mkdir -p demo_tests/test_b
echo "World" > demo_tests/test_b/stdout
echo "test_b" > demo_tests/test_b/arguments

# 评分测试
mkdir -p demo_tests/marking1
echo "Correct output" > demo_tests/marking1/stdout
echo "marking1" > demo_tests/marking1/arguments
echo "10" > demo_tests/marking1/marks

mkdir -p demo_tests/marking2
echo "Another correct output" > demo_tests/marking2/stdout
echo "marking2" > demo_tests/marking2/arguments
echo "30" > demo_tests/marking2/marks

tar -cf demo.tests demo_tests/
echo "✓ 测试文件创建完成"
echo

# 创建演示程序
echo "2. 创建演示程序..."
echo "#!/bin/dash" > demo_program.sh
echo "import sys" >> demo_program.sh
echo "a=int(sys.argv[1])" >> demo_program.sh
echo "b=int(input())" >> demo_program.sh
echo "print(a * b)" >> demo_program.sh
chmod +x demo_program.sh
echo "✓ 演示程序创建完成"
echo

# 创建作业
echo "3. 创建作业..."
./mygive-add lab1 demo.tests
echo

# 提交作业
echo "4. 学生提交作业..."
./mygive-submit lab1 z5000000 demo_program.sh
./mygive-submit lab1 z5111111 demo_program.sh
echo

# 查看摘要
echo "5. 查看作业摘要..."
./mygive-summary
echo

# 查看学生状态
echo "6. 查看学生状态..."
echo "学生 z5000000 的提交:"
./mygive-status z5000000
echo

# 获取提交内容
echo "7. 获取提交内容..."
echo "学生 z5000000 的最后一个提交:"
./mygive-fetch lab1 z5000000
echo

# 运行学生测试
echo "8. 运行学生测试..."
./mygive-test lab1 demo_program.sh
echo

# 运行评分测试
echo "9. 运行评分测试..."
./mygive-mark lab1
echo

# 删除作业
echo "10. 删除作业..."
./mygive-rm lab1
echo "✓ 作业删除完成"
echo

# 清理
rm -f demo_program.sh demo.tests
rm -rf demo_tests

echo "=== 演示完成 ==="
echo "MyGive 系统功能演示完毕！" 