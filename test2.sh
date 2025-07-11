#!/bin/dash

# test2.sh - 多提交测试
# 测试多个提交和提交编号功能

echo "=== Test 2: Multiple submissions test ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建测试文件
echo "#!/bin/dash" > program1.sh
echo "echo 'First submission'" >> program1.sh
chmod +x program1.sh

echo "#!/bin/dash" > program2.sh
echo "echo 'Second submission'" >> program2.sh
chmod +x program2.sh

echo "#!/bin/dash" > program3.sh
echo "echo 'Third submission'" >> program3.sh
chmod +x program3.sh

# 创建测试文件
mkdir -p test_tests
echo "test1" > test_tests/stdout
echo "test1" > test_tests/arguments
tar -cf test.tests test_tests/

# 创建作业
./mygive-add lab1 test.tests >/dev/null

# 测试1: 多个提交
echo "Test 1: Multiple submissions"
./mygive-submit lab1 z5000000 program1.sh >/dev/null
./mygive-submit lab1 z5000000 program2.sh >/dev/null
./mygive-submit lab1 z5000000 program3.sh >/dev/null

# 检查状态
echo "Checking submission status:"
./mygive-status z5000000

# 测试2: 获取特定提交
echo "Test 2: Fetching specific submissions"
echo "Fetching submission 1:"
./mygive-fetch lab1 z5000000 1
echo "Fetching submission 2:"
./mygive-fetch lab1 z5000000 2
echo "Fetching submission 3:"
./mygive-fetch lab1 z5000000 3

# 测试3: 负索引
echo "Test 3: Negative indexing"
echo "Fetching last submission (0):"
./mygive-fetch lab1 z5000000 0
echo "Fetching second-last submission (-1):"
./mygive-fetch lab1 z5000000 -1
echo "Fetching third-last submission (-2):"
./mygive-fetch lab1 z5000000 -2

# 测试4: 默认获取最后一个
echo "Test 4: Default fetch (last submission)"
./mygive-fetch lab1 z5000000

# 测试5: 多个学生
echo "Test 5: Multiple students"
./mygive-submit lab1 z5111111 program1.sh >/dev/null
./mygive-submit lab1 z5222222 program2.sh >/dev/null

echo "Summary:"
./mygive-summary

# 清理
rm -f program1.sh program2.sh program3.sh test.tests
rm -rf test_tests

echo "=== All multiple submission tests passed! ===" 