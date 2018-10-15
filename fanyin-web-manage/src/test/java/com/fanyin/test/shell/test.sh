#!/usr/bin/env bash
# 输出到屏幕
echo "hello world"
# 变量的定义,可重复定义
abc="hiababggfgxxx"
# 设置变量不可重复定义,这样变量在二次定义时会报错
readonly abc
# 使用变量 $abc或者${abc} 推荐第二种
echo ${abc}
#删除变量,无法删除只读变量
unset abc
#变量分类 1:局部变量 2:环境变量 3:shell变量(由shell程序设置的特殊变量) shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行
#字符串长度
echo ${#abc}
#字符串截取 第二个字符开始截取四个 iaba
echo ${abc:1:4}
#查找子字符串 查找ab出现的位置 哪个先查到就返回哪个  2,注意字符串不能有关键字
echo `expr index ${abc} ab`
#数组定义
array_name=(value0 value1 value2)
#读取数组
echo ${array_name[0]}
#数组长度
echo ${#array_name[@]}
echo ${#array_name[*]}
#运算符 2与4之间必须由空格
var=`expr 2 + 4`
echo "结果:${var}"


#带参数执行sh脚本 param.sh
echo "执行第一个参数:${0}"
echo "执行第二个参数:${1}"
echo "执行第三个参数:${2}"
echo "传递参数个数:${#}"
echo "参数字符串输出:$*"
echo "脚本运行的进程id:$$"
echo "参数字符串双引号时换行输出:$@"
#以上执行 ./param.sh 1,2,3将会输出一下结果 ${0}默认执行的文件名
:<<EOF
执行第一个参数 ./param.sh
执行第二个参数 1
执行第二个参数 2
EOF

#支持 + - * / % = == !=
#关系运算符 只支持数字
# -eq 两个数字是否相等
# -ne 两个数字是否不相等
# -gt 大于
# -lt 小于
# -ge 大于等于
# -le 小于等于
#布尔运算符
# ! 非
# -o 或运算 类似||
# -a 与运算 类似&&
#字符串运算符
# = 比较两个字符串是否相等 注意:不是==
# != 不等于
# -z 字符串长度是否为零 为零返回true
# -n 字符串长度是否不为零  不为零返回true
# str 字符串是否不为空 [$abc] 返回true
# 文件测试运算符
# -b file 检测文件是否是块设备文件，如果是，则返回 true [ -b $file ]
# -c file 检测文件是否是字符设备文件，如果是，则返回 true。
# -d file 检测文件是否是目录，如果是，则返回 true。
# -f file 检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。
# -g file 检测文件是否设置了 SGID 位，如果是，则返回 true。
# -k file 检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。
# -p file 检测文件是否是有名管道，如果是，则返回 true。
# -u file 检测文件是否设置了 SUID 位，如果是，则返回 true。
# -r file 检测文件是否可读，如果是，则返回 true。
# -w file 检测文件是否可写，如果是，则返回 true。
# -x file 检测文件是否可执行，如果是，则返回 true。
# -s file 检测文件是否为空（文件大小是否大于0），不为空返回 true。
# -e file 检测文件（包括目录）是否存在，如果是，则返回 true。

# 输出时间
echo `date`
read -p "请输入一段文字:" -n 6 -t 5 -s password
echo -e "password is ${password}"
# -p 输入提示文字
# -n 输入字符长度限制(达到6位，自动结束)
# -t 输入限时
#-s 隐藏输入内容