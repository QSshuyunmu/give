#!/bin/dash

# test0.sh - 基本功能测试
# 测试作业创建、提交和状态查看

echo "=== Test 0: Basic functionality test ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建测试文件
echo "#!/bin/dash" > test_program.sh
echo "echo 'Hello, World!'" >> test_program.sh
chmod +x test_program.sh

# 创建简单的测试文件
mkdir -p test_tests
echo "test1" > test_tests/stdout
echo "test1" > test_tests/arguments
tar -cf test.tests test_tests/

# 测试1: 创建作业
echo "Test 1: Creating assignment"
./mygive-add lab1 test.tests
if [ $? -eq 0 ]; then
    echo "✓ Assignment creation successful"
else
    echo "✗ Assignment creation failed"
    exit 1
fi

# 测试2: 提交作业
echo "Test 2: Submitting assignment"
./mygive-submit lab1 z5000000 test_program.sh
if [ $? -eq 0 ]; then
    echo "✓ Assignment submission successful"
else
    echo "✗ Assignment submission failed"
    exit 1
fi

# 测试3: 查看状态
echo "Test 3: Checking status"
./mygive-status z5000000
if [ $? -eq 0 ]; then
    echo "✓ Status check successful"
else
    echo "✗ Status check failed"
    exit 1
fi

# 测试4: 获取提交内容
echo "Test 4: Fetching submission"
./mygive-fetch lab1 z5000000
if [ $? -eq 0 ]; then
    echo "✓ Fetch successful"
else
    echo "✗ Fetch failed"
    exit 1
fi

# 测试5: 查看摘要
echo "Test 5: Checking summary"
./mygive-summary
if [ $? -eq 0 ]; then
    echo "✓ Summary check successful"
else
    echo "✗ Summary check failed"
    exit 1
fi

# 清理
rm -f test_program.sh test.tests
rm -rf test_tests

echo "=== All tests passed! ===" 