#!/bin/dash

# test4.sh - 测试和评分功能测试
# 测试mygive-test和mygive-mark功能

echo "=== Test 4: Testing and marking functionality test ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建测试文件
./create_test_files.sh >/dev/null

# 创建测试程序
echo "#!/bin/dash" > multiply_right.py
echo "import sys" >> multiply_right.py
echo "a=int(sys.argv[1])" >> multiply_right.py
echo "b=int(input())" >> multiply_right.py
echo "print(a * b)" >> multiply_right.py
chmod +x multiply_right.py

# 创建错误的程序
echo "#!/bin/dash" > multiply_wrong.sh
echo "echo 'Wrong output'" >> multiply_wrong.sh
chmod +x multiply_wrong.sh

# 创建作业
echo "Creating assignment..."
./mygive-add lab1 multiply.tests >/dev/null

# 提交作业
echo "Submitting assignments..."
./mygive-submit lab1 z5000000 multiply_wrong.sh >/dev/null
./mygive-submit lab1 z5000000 multiply_right.py >/dev/null

# 测试1: 运行学生测试
echo "Test 1: Running student tests"
echo "Testing correct program:"
./mygive-test lab1 multiply_right.py

echo "Testing wrong program:"
./mygive-test lab1 multiply_wrong.sh

# 测试2: 运行评分测试
echo "Test 2: Running marking tests"
./mygive-mark lab1

# 测试3: 测试不存在的文件
echo "Test 3: Testing non-existent file"
./mygive-test lab1 nonexistent.sh 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled non-existent file"
else
    echo "✗ Should have handled non-existent file"
    exit 1
fi

# 测试4: 测试不存在的作业
echo "Test 4: Testing non-existent assignment"
./mygive-test nonexistent multiply_right.py 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled non-existent assignment"
else
    echo "✗ Should have handled non-existent assignment"
    exit 1
fi

# 清理
rm -f multiply_right.py multiply_wrong.sh multiply.tests

echo "=== All testing and marking tests passed! ===" 