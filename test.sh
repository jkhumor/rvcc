# 测试脚本帮助简化测试工作

# 声明一个函数
assert(){
# 程序运行的 期待值 为参数1
expected="$1"
# 输入值 为参数2
input="$2"

# 运行程序，传入期待值，将生成结果写入tmp.s汇编文件
# 如果运行不成功，则会执行exit退出。成功时会短路exit操作
./rvcc $input > tmp.s || exit
#编译rvcc产生的汇编文件
# clang -o tmp tmp.s
riscv64-unknown-linux-gnu-gcc -static -o tmp tmp.s


# 运行生成出来目标文件
# ./tmp
qemu-riscv64 -L $RISCV/sysroot ./tmp
#spike --isa=rv64gc $RISCV/riscv64-unknown-linux-gnu/bin/pk ./tmp

#获取程序返回值，存入 实际值
actual="$?"

# 判断实际值，是否为预期值
#判断实际值，是否为预期值
# 在 Bash 脚本中，[ 和 ] 之间的空格是必须的
# 请注意我在 [ 和 "$actual" 之间，以及 "$expected" 和 ] 之间添加了空格。
# 在 Bash 脚本中，这些空格是必须的，以确保 [ 和 ] 被正确识别为条件测试命令的一部分。
if [ "$actual" = "$expected" ]; then
    echo "$input => $actual"
else
    echo "$input => $expected expected,but got $actual"
    exit 1
fi
}

# assert 期待值 输入值
# [1]返回指定数值
assert 0 0
assert 42 42