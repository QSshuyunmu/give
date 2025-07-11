#!/bin/dash

# test6.sh - 并发和文件系统测试
# 测试并发操作和文件系统行为

echo "=== Test 6: Concurrency and filesystem test ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建测试文件
mkdir -p test_tests
echo "test" > test_tests/stdout
tar -cf test.tests test_tests/

# 创建测试程序
echo "#!/bin/dash" > test_program.sh
echo "echo 'Test program'" >> test_program.sh
chmod +x test_program.sh

# 测试1: 同时创建多个作业
echo "Test 1: Concurrent assignment creation"
./mygive-add lab1 test.tests >/dev/null &
./mygive-add lab2 test.tests >/dev/null &
./mygive-add lab3 test.tests >/dev/null &
wait

echo "Summary after concurrent creation:"
./mygive-summary

# 测试2: 同时提交到不同作业
echo "Test 2: Concurrent submissions to different assignments"
./mygive-submit lab1 z5000000 test_program.sh >/dev/null &
./mygive-submit lab2 z5000000 test_program.sh >/dev/null &
./mygive-submit lab3 z5000000 test_program.sh >/dev/null &
wait

echo "Status after concurrent submissions:"
./mygive-status z5000000

# 测试3: 同时提交到同一作业
echo "Test 3: Concurrent submissions to same assignment"
./mygive-submit lab1 z5111111 test_program.sh >/dev/null &
./mygive-submit lab1 z5222222 test_program.sh >/dev/null &
./mygive-submit lab1 z5333333 test_program.sh >/dev/null &
wait

echo "Summary after concurrent submissions to same assignment:"
./mygive-summary

# 测试4: 文件权限测试
echo "Test 4: File permissions test"
if [ -r ".mygive/lab1/submissions/z5000000/submission_1" ]; then
    echo "✓ Submission file is readable"
else
    echo "✗ Submission file should be readable"
    exit 1
fi

if [ -x ".mygive/lab1/submissions/z5000000/submission_1" ]; then
    echo "✓ Submission file is executable"
else
    echo "✗ Submission file should be executable"
    exit 1
fi

# 测试5: 目录结构完整性
echo "Test 5: Directory structure integrity"
if [ -d ".mygive/lab1/tests" ]; then
    echo "✓ Tests directory exists"
else
    echo "✗ Tests directory should exist"
    exit 1
fi

if [ -d ".mygive/lab1/submissions" ]; then
    echo "✓ Submissions directory exists"
else
    echo "✗ Submissions directory should exist"
    exit 1
fi

# 测试6: 文件内容完整性
echo "Test 6: File content integrity"
original_content=$(cat test_program.sh)
submitted_content=$(./mygive-fetch lab1 z5000000)

if [ "$original_content" = "$submitted_content" ]; then
    echo "✓ File content preserved correctly"
else
    echo "✗ File content should be preserved"
    exit 1
fi

# 清理
rm -f test_program.sh test.tests
rm -rf test_tests

echo "=== All concurrency and filesystem tests passed! ===" 