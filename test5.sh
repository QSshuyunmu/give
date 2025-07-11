#!/bin/dash

# test5.sh - 边界情况测试
# 测试各种边界情况和特殊输入

echo "=== Test 5: Edge cases test ==="

# 清理之前的测试数据
rm -rf .mygive

# 测试1: 空文件名
echo "Test 1: Empty filename"
./mygive-submit lab1 z5000000 "" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled empty filename"
else
    echo "✗ Should have handled empty filename"
    exit 1
fi

# 测试2: 特殊字符在文件名中
echo "Test 2: Special characters in filename"
./mygive-submit lab1 z5000000 "file@name.sh" 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled special characters"
else
    echo "✗ Should have handled special characters"
    exit 1
fi

# 测试3: 非常长的作业名称
echo "Test 3: Very long assignment name"
long_name="a$(printf 'b%.0s' {1..100})"
./mygive-add "$long_name" test.tests 2>/dev/null
if [ $? -eq 0 ]; then
    echo "✓ Correctly handled long assignment name"
else
    echo "✗ Should have handled long assignment name"
    exit 1
fi

# 创建基本测试文件
mkdir -p test_tests
echo "test" > test_tests/stdout
tar -cf test.tests test_tests/

# 测试4: 大量提交
echo "Test 4: Many submissions"
./mygive-add lab1 test.tests >/dev/null

for i in $(seq 1 10); do
    echo "#!/bin/dash" > "prog$i.sh"
    echo "echo 'Submission $i'" >> "prog$i.sh"
    chmod +x "prog$i.sh"
    ./mygive-submit lab1 z5000000 "prog$i.sh" >/dev/null
done

echo "Checking status with many submissions:"
./mygive-status z5000000

# 测试5: 负索引边界
echo "Test 5: Negative index boundaries"
./mygive-fetch lab1 z5000000 -1 >/dev/null
./mygive-fetch lab1 z5000000 -5 >/dev/null
./mygive-fetch lab1 z5000000 -10 >/dev/null

# 测试6: 超出范围的索引
echo "Test 6: Out of range indices"
./mygive-fetch lab1 z5000000 15 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled out of range index"
else
    echo "✗ Should have handled out of range index"
    exit 1
fi

./mygive-fetch lab1 z5000000 -15 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled out of range negative index"
else
    echo "✗ Should have handled out of range negative index"
    exit 1
fi

# 清理
rm -f prog*.sh test.tests
rm -rf test_tests

echo "=== All edge case tests passed! ===" 