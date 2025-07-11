#!/bin/dash

# test8.sh - 完整工作流程测试
# 测试从创建到删除的完整工作流程

echo "=== Test 8: Complete workflow test ==="

# 清理之前的测试数据
rm -rf .mygive

# 创建测试文件
mkdir -p workflow_tests

# 学生测试
mkdir -p workflow_tests/test1
echo "Correct output" > workflow_tests/test1/stdout

mkdir -p workflow_tests/test2
echo "Another correct output" > workflow_tests/test2/stdout

# 评分测试
mkdir -p workflow_tests/marking1
echo "Marking output" > workflow_tests/marking1/stdout
echo "25" > workflow_tests/marking1/marks

mkdir -p workflow_tests/marking2
echo "Another marking output" > workflow_tests/marking2/stdout
echo "25" > workflow_tests/marking2/marks

tar -cf workflow.tests workflow_tests/

# 创建测试程序
echo "#!/bin/dash" > workflow_program.sh
echo "echo 'Correct output'" >> workflow_program.sh
chmod +x workflow_program.sh

# 步骤1: 创建作业
echo "Step 1: Creating assignments"
./mygive-add lab1 workflow.tests
./mygive-add lab2 workflow.tests

# 步骤2: 查看初始摘要
echo "Step 2: Initial summary"
./mygive-summary

# 步骤3: 学生提交作业
echo "Step 3: Students submitting assignments"
./mygive-submit lab1 z5000000 workflow_program.sh
./mygive-submit lab1 z5111111 workflow_program.sh
./mygive-submit lab2 z5000000 workflow_program.sh

# 步骤4: 查看提交状态
echo "Step 4: Checking submission status"
./mygive-status z5000000
./mygive-status z5111111

# 步骤5: 查看摘要
echo "Step 5: Summary after submissions"
./mygive-summary

# 步骤6: 运行学生测试
echo "Step 6: Running student tests"
./mygive-test lab1 workflow_program.sh

# 步骤7: 运行评分测试
echo "Step 7: Running marking tests"
./mygive-mark lab1

# 步骤8: 获取提交内容
echo "Step 8: Fetching submissions"
echo "Fetching z5000000's submission:"
./mygive-fetch lab1 z5000000

echo "Fetching z5111111's submission:"
./mygive-fetch lab1 z5111111

# 步骤9: 多个提交
echo "Step 9: Multiple submissions"
./mygive-submit lab1 z5000000 workflow_program.sh
./mygive-submit lab1 z5000000 workflow_program.sh

echo "Checking multiple submissions:"
./mygive-status z5000000

# 步骤10: 删除作业
echo "Step 10: Removing assignments"
./mygive-rm lab1
./mygive-rm lab2

echo "Final summary:"
./mygive-summary 2>/dev/null
if [ $? -ne 0 ]; then
    echo "✓ Correctly handled empty assignment list"
else
    echo "✗ Should have handled empty assignment list"
    exit 1
fi

# 清理
rm -f workflow_program.sh workflow.tests
rm -rf workflow_tests

echo "=== Complete workflow test passed! ===" 