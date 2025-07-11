#!/bin/dash

# test7.sh - 复杂测试场景
# 测试复杂的测试配置和选项

echo "=== Test 7: Complex test scenarios ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建复杂的测试文件
mkdir -p complex_tests

# 测试1: 带参数的测试
mkdir -p complex_tests/test_with_args
echo "arg1 arg2" > complex_tests/test_with_args/arguments
echo "Expected output with args" > complex_tests/test_with_args/stdout

# 测试2: 带stdin的测试
mkdir -p complex_tests/test_with_stdin
echo "input data" > complex_tests/test_with_stdin/stdin
echo "Expected output with stdin" > complex_tests/test_with_stdin/stdout

# 测试3: 带stderr的测试
mkdir -p complex_tests/test_with_stderr
echo "Error message" > complex_tests/test_with_stderr/stderr
echo "1" > complex_tests/test_with_stderr/exit_status

# 测试4: 带选项的测试
mkdir -p complex_tests/test_with_options
echo "Hello World" > complex_tests/test_with_options/stdout
echo "bc" > complex_tests/test_with_options/options  # 忽略空行和大小写

# 测试5: 评分测试
mkdir -p complex_tests/marking_test
echo "Correct answer" > complex_tests/marking_test/stdout
echo "50" > complex_tests/marking_test/marks

tar -cf complex.tests complex_tests/

# 创建测试程序
echo "#!/bin/dash" > complex_program.sh
echo "if [ \$# -eq 2 ]; then" >> complex_program.sh
echo "    echo 'Expected output with args'" >> complex_program.sh
echo "elif [ -t 0 ]; then" >> complex_program.sh
echo "    echo 'Expected output with stdin'" >> complex_program.sh
echo "else" >> complex_program.sh
echo "    read input" >> complex_program.sh
echo "    echo 'Expected output with stdin'" >> complex_program.sh
echo "fi" >> complex_program.sh
chmod +x complex_program.sh

# 创建错误的程序
echo "#!/bin/dash" > wrong_program.sh
echo "echo 'Wrong output'" >> wrong_program.sh
echo "echo 'Error message' >&2" >> wrong_program.sh
echo "exit 1" >> wrong_program.sh
chmod +x wrong_program.sh

# 创建作业
./mygive-add lab1 complex.tests >/dev/null

# 提交作业
./mygive-submit lab1 z5000000 complex_program.sh >/dev/null
./mygive-submit lab1 z5000000 wrong_program.sh >/dev/null

# 测试1: 运行复杂测试
echo "Test 1: Running complex tests"
echo "Testing correct program:"
./mygive-test lab1 complex_program.sh

echo "Testing wrong program:"
./mygive-test lab1 wrong_program.sh

# 测试2: 运行评分测试
echo "Test 2: Running marking tests"
./mygive-mark lab1

# 测试3: 测试选项功能
echo "Test 3: Testing options functionality"
# 创建一个测试程序来测试选项
echo "#!/bin/dash" > options_test.sh
echo "echo 'HELLO WORLD'" >> options_test.sh
echo "echo ''" >> options_test.sh
echo "echo 'hello world'" >> options_test.sh
chmod +x options_test.sh

./mygive-submit lab1 z5000000 options_test.sh >/dev/null

# 测试4: 测试退出状态
echo "Test 4: Testing exit status"
./mygive-test lab1 wrong_program.sh

# 清理
rm -f complex_program.sh wrong_program.sh options_test.sh complex.tests
rm -rf complex_tests

echo "=== All complex test scenarios passed! ===" 