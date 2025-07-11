#!/bin/dash

# create_test_files.sh - 创建示例测试文件

echo "Creating example test files..."

# 创建测试目录
mkdir -p example_tests

# 创建学生测试
mkdir -p example_tests/test_a
echo "Hello" > example_tests/test_a/stdout
echo "test_a" > example_tests/test_a/arguments

mkdir -p example_tests/test_b
echo "World" > example_tests/test_b/stdout
echo "test_b" > example_tests/test_b/arguments

mkdir -p example_tests/test_c
echo "42" > example_tests/test_c/stdout
echo "test_c" > example_tests/test_c/arguments

# 创建评分测试
mkdir -p example_tests/marking1
echo "Correct output" > example_tests/marking1/stdout
echo "marking1" > example_tests/marking1/arguments
echo "10" > example_tests/marking1/marks

mkdir -p example_tests/marking2
echo "Another correct output" > example_tests/marking2/stdout
echo "marking2" > example_tests/marking2/arguments
echo "30" > example_tests/marking2/marks

mkdir -p example_tests/marking3
echo "Third correct output" > example_tests/marking3/stdout
echo "marking3" > example_tests/marking3/arguments
echo "20" > example_tests/marking3/marks

mkdir -p example_tests/marking4
echo "Fourth correct output" > example_tests/marking4/stdout
echo "marking4" > example_tests/marking4/arguments
echo "42" > example_tests/marking4/marks

# 创建tar文件
tar -cf multiply.tests example_tests/

echo "Test files created: multiply.tests"
echo "Contains:"
tar -tf multiply.tests

# 清理临时目录
rm -rf example_tests 