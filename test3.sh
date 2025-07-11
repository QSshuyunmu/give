#!/bin/dash

# test3.sh - 作业删除测试
# 测试作业删除功能

echo "=== Test 3: Assignment removal test ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建测试文件
echo "#!/bin/dash" > test_program.sh
echo "echo 'Hello, World!'" >> test_program.sh
chmod +x test_program.sh

mkdir -p test_tests
echo "test1" > test_tests/stdout
echo "test1" > test_tests/arguments
tar -cf test.tests test_tests/

# 测试1: 创建多个作业
echo "Test 1: Creating multiple assignments"
./mygive-add lab1 test.tests >/dev/null
./mygive-add lab2 test.tests >/dev/null
./mygive-add lab3 test.tests >/dev/null

# 提交一些作业
./mygive-submit lab1 z5000000 test_program.sh >/dev/null
./mygive-submit lab2 z5000000 test_program.sh >/dev/null

echo "Before removal:"
./mygive-summary

# 测试2: 删除作业
echo "Test 2: Removing assignment"
./mygive-rm lab2
if [ $? -eq 0 ]; then
    echo "✓ Assignment removal successful"
else
    echo "✗ Assignment removal failed"
    exit 1
fi

echo "After removal:"
./mygive-summary

# 测试3: 删除不存在的作业
echo "Test 3: Removing non-existent assignment"
./mygive-rm nonexistent 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled non-existent assignment removal"
else
    echo "✗ Should have handled non-existent assignment removal"
    exit 1
fi

# 测试4: 删除后尝试提交
echo "Test 4: Submitting to removed assignment"
./mygive-submit lab2 z5000000 test_program.sh 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly rejected submission to removed assignment"
else
    echo "✗ Should have rejected submission to removed assignment"
    exit 1
fi

# 测试5: 删除所有作业
echo "Test 5: Removing all assignments"
./mygive-rm lab1
./mygive-rm lab3

echo "Final summary:"
./mygive-summary 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled empty assignment list"
else
    echo "✗ Should have handled empty assignment list"
    exit 1
fi

# 清理
rm -f test_program.sh test.tests
rm -rf test_tests

echo "=== All removal tests passed! ===" 