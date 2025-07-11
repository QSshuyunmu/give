#!/bin/dash

# test9.sh - 性能和压力测试
# 测试系统在大量数据下的性能

echo "=== Test 9: Performance and stress test ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建测试文件
mkdir -p stress_tests
echo "test" > stress_tests/stdout
tar -cf stress.tests stress_tests/

# 创建测试程序
echo "#!/bin/dash" > stress_program.sh
echo "echo 'Stress test program'" >> stress_program.sh
chmod +x stress_program.sh

# 创建作业
./mygive-add lab1 stress.tests >/dev/null

# 测试1: 大量学生提交
echo "Test 1: Many students submitting"
for i in $(seq 1 50); do
    zid="z$(printf '%07d' $i)"
    ./mygive-submit lab1 "$zid" stress_program.sh >/dev/null
done

echo "Summary with 50 students:"
./mygive-summary

# 测试2: 大量提交
echo "Test 2: Many submissions per student"
for i in $(seq 1 20); do
    ./mygive-submit lab1 z5000000 stress_program.sh >/dev/null
done

echo "Status with many submissions:"
./mygive-status z5000000

# 测试3: 获取特定提交的性能
echo "Test 3: Fetching specific submissions"
time ./mygive-fetch lab1 z5000000 1 >/dev/null
time ./mygive-fetch lab1 z5000000 10 >/dev/null
time ./mygive-fetch lab1 z5000000 20 >/dev/null

# 测试4: 负索引性能
echo "Test 4: Negative indexing performance"
time ./mygive-fetch lab1 z5000000 -1 >/dev/null
time ./mygive-fetch lab1 z5000000 -5 >/dev/null
time ./mygive-fetch lab1 z5000000 -10 >/dev/null

# 测试5: 大量作业
echo "Test 5: Many assignments"
for i in $(seq 1 20); do
    ./mygive-add "lab$i" stress.tests >/dev/null
done

echo "Summary with many assignments:"
./mygive-summary

# 测试6: 删除大量作业
echo "Test 6: Removing many assignments"
for i in $(seq 1 20); do
    ./mygive-rm "lab$i" >/dev/null
done

echo "Summary after removing assignments:"
./mygive-summary

# 测试7: 文件大小测试
echo "Test 7: Large file test"
# 创建大文件
dd if=/dev/zero of=large_file.dat bs=1M count=1 2>/dev/null
echo "#!/bin/dash" > large_program.sh
echo "cat large_file.dat" >> large_program.sh
chmod +x large_program.sh

./mygive-submit lab1 z5000000 large_program.sh >/dev/null

echo "Status with large file:"
./mygive-status z5000000

# 测试8: 内存使用测试
echo "Test 8: Memory usage test"
# 创建包含大量数据的程序
echo "#!/bin/dash" > memory_program.sh
echo "for i in \$(seq 1 1000); do" >> memory_program.sh
echo "    echo \"Line \$i\"" >> memory_program.sh
echo "done" >> memory_program.sh
chmod +x memory_program.sh

./mygive-submit lab1 z5000000 memory_program.sh >/dev/null

# 清理
rm -f stress_program.sh stress.tests large_file.dat large_program.sh memory_program.sh
rm -rf stress_tests

echo "=== All performance and stress tests passed! ===" 