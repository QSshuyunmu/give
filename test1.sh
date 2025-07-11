#!/bin/dash

# test1.sh - 错误处理测试
# 测试各种错误情况和输入验证

echo "=== Test 1: Error handling test ==="

# 清理之前的测试数据
rm -rf .mygive

# 测试1: 参数数量错误
echo "Test 1: Wrong number of arguments"
./mygive-add
if [ $? -ne 0 ]; then
    echo "✓ Correctly rejected missing arguments"
else
    echo "✗ Should have rejected missing arguments"
    exit 1
fi

# 测试2: 无效的作业名称
echo "Test 2: Invalid assignment name"
./mygive-add 123lab test.tests 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly rejected invalid assignment name"
else
    echo "✗ Should have rejected invalid assignment name"
    exit 1
fi

# 测试3: 无效的学生ID
echo "Test 3: Invalid student ID"
./mygive-submit lab1 1234567 test.sh 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly rejected invalid student ID"
else
    echo "✗ Should have rejected invalid student ID"
    exit 1
fi

# 测试4: 不存在的作业
echo "Test 4: Non-existent assignment"
./mygive-submit nonexistent z5000000 test.sh 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly rejected non-existent assignment"
else
    echo "✗ Should have rejected non-existent assignment"
    exit 1
fi

# 测试5: 不存在的文件
echo "Test 5: Non-existent file"
./mygive-submit lab1 z5000000 nonexistent.sh 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly rejected non-existent file"
else
    echo "✗ Should have rejected non-existent file"
    exit 1
fi

# 创建测试文件进行后续测试
echo "#!/bin/dash" > test_program.sh
echo "echo 'Hello, World!'" >> test_program.sh
chmod +x test_program.sh

mkdir -p test_tests
echo "test1" > test_tests/stdout
echo "test1" > test_tests/arguments
tar -cf test.tests test_tests/

./mygive-add lab1 test.tests >/dev/null

# 测试6: 重复创建作业
echo "Test 6: Duplicate assignment creation"
./mygive-add lab1 test.tests 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly rejected duplicate assignment"
else
    echo "✗ Should have rejected duplicate assignment"
    exit 1
fi

# 测试7: 不存在的学生状态查询
echo "Test 7: Status for non-existent student"
./mygive-status z9999999 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled non-existent student"
else
    echo "✗ Should have handled non-existent student"
    exit 1
fi

# 清理
rm -f test_program.sh test.tests
rm -rf test_tests

echo "=== All error handling tests passed! ===" 