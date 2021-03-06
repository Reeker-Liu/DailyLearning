[TOC]

## Bash

> Bourne Again SHell

- 命令与文件补全

- 前后台工作控制 foreground/background job control

- 程序化脚本 shell scripts

- 内建指令

  - `type cmd` 可查看是否为内建指令


##### 快捷键

-  **ctrl-w** 删除键入的最后一个单词
- **ctrl-a** 将光标移至行首
- **ctrl-e** 将光标移至行尾
- **ctrl-u** 删除光标所在位置之前的内容
- **ctrl-k** 删除光标至行尾的所有内容
- **ctrl-l** 清屏

##### 变量

- 环境变量，通常以大写字符表示

  - 使用`env` `export`可以查看

- bash接口变量

  - `PS1`为命令提示符内容

- 自定义变量
  - 与环境变量的区别在于变量是否被子程序所继承
  - 使用`export`使变量成为环境变量，如`export PATH`
  - 使用`set` 查看所有变量（环境变量+自定义变量+bash接口变量）

- 变量设定规则

  - 变量类型默认为字符串类型
  - 变量与内容间以等号连接，等号两侧不能直接用空格
  - 变量名称为字母和数字，但不能数字开头
  - 变量内容可用单双引号
    - 若使用双引号，则特殊字符保有原本特性，`var="lang $LANG"`
    - 若使用单引号，则特殊字符保留纯文本
  - 使用`\`将特殊字符转义
  - 使用反单引号或`$(cmd)`来获得其他指令提供的信息，如`ver=$(uname -r)`
  - 使用`$name` 或`${name}`来累加变量内容，如`PATH="$PATH":/bin`
  - 使用`unset name`取消变量

- `read variable` 读取变量输入

  - `-p` 后接提示字符
  - `-t` 后接等待秒数

- `declare variable` 声明变量类型，可累加声明

  - 无任何参数时，显示所有变量名称与内容，同`set`
  - `-a` 将变量定义为数组类型
  - `-i` 将变量定义为整型
  - `-x` 将变量变为环境变量
  - `-r` 将变量设为readonly类型
  - `+r` 可取消readonly属性

- `${var SYMBOL content}` 删除部分变量内容

  - content中可以使用通配符`*`
  - SYMBOL
    - #，从最前面开始删除，非贪心
    - ##，从最前面开始删除，贪心
    - %，从后面开始删除，非贪心
    - %%，从后面开始删除，贪心

- `${var SYMBOL content/new}` 替换部分变量内容

  - SYMBOL为/，仅第一个符合的被替换
  - SYMBOL为//，符合的均被替换

- 变量测试与内容修改，与具体符号有关

  | 变量设定方式     | str未设定          | str为空字符串      | str为非空字符串   |
  | ---------------- | ------------------ | ------------------ | ----------------- |
  | var=${str-expr}  | var=expr           | var=""             | var=$str          |
  | var=${str:-expr} | var=expr           | var=expr           | var=$str          |
  | var=${str+expr}  | var=""             | var=expr           | var=expr          |
  | var=${str:+expr} | var=""             | var=""             | var=expr          |
  | var=${str=expr}  | str=expr, var=expr | str不变, var=""    | str不变, var=$str |
  | var=${str:=expr} | str=expr, var=expr | str=expr, var=expr | str不变, var=$str |
  | var=${str?expr}  | expr输出至stderr   | var=""             | var=$str          |
  | var=${str:?expr} | expr输出至stderr   | expr输出至stderr   | var=$str          |

#### 

##### 命令别名`alias`

- 可直接设置，如`alias lm='ls -al'`
- 定义规则与变量基本相同
- 可以通过别名与命令名相同的方式取代默认指令
- 使用`unalias`取消别名



##### 历史命令`history`

- 前一次登陆执行的命令在`~/.bash_history`中记录，仅记录HISTFILESIZE
- 本次登录执行的指令记录在内存中
- 无参数时，显示全部内存中的历史指令
- 接数字时，显示制定数量的历史指令
- `-w` 将目前内存中的历史指令写入文件

- `!number` 执行历史纪录中标号为number的指令
- `!cmd` 执行最近的以cmd开头的指令
- `!!` 执行上一个指令



##### 指令调用优先级

> 可以使用`type -a cmd`查询指令的调用的优先顺序

1. 以相对/绝对滤镜执行的指令，`/bin/ls`
2. 由alias定义的别名指令
3. 由bash内建的指令
4. 通过$PATH顺序搜寻到的指令



##### 登录信息

- 终端登录欢迎信息`/etc/issue`
- 远程登录欢迎信息`/etc/issue.net`
- ? 公共信息`/etc/motd`



##### 环境配置文件

> bash中设置的别名、变量在注销bash后即失效，必须写入配置文件才能保存

- login shell：取得bash时需要完整登入流程，即输入账户密码
  - `~/.bash_profile` `~/.bash_login` `~/.profile` 个人设定文件
- non-login shell：取得bash接口不需要登入，如GUI下启动终端，或bash环境下通过bash进入子程序
- `/etc/profile`
  - 设定整体环境
  - login shell读取
  - PATH，依据UID决定是否含有sbin的系统指令目录
  - MAIL，根据用户设定
  - USER，同上
  - HOSTNAME，依据主机hostname指令决定
  - HISTSIZE
  - umask，root默认022，一般用户002
  - 呼叫其他设定数据
    - `/etc/profile.d/*.sh` 设定公用颜色、别名指令
    - `/etc/locale.conf` 语系
- `~/.bash_profile` `~/.bash_login` `~/.profile`
  - 设定个人配置
  - login shell读取
  - 按顺序查找，仅读取第一个查找到的文件
  - 读取`~/.bashrc`的设定内容
- `~/.bashrc`
  - non-login shell读取
- 实时读入配置文件
  - `source ~/.bashrc` 或 `. ~/.bashrc` 不需要注销再登入即可生效
  - 可以分别编写不同的环境变量配置方案，按需实时切换
- `~/.bash_logout` 
  - 注销后系统自动执行的内容



##### 特殊符号

- `ctrl + c` 终止当前命令
- `ctrl + d` EOF
- `ctrl + m` 回车
- `ctrl + s` 暂停屏幕输出
- `ctrl + q` 恢复屏幕输出
- `ctrl + u` 删除整列命令
- `ctrl + z`   暂停目前的命令
- `*` 0到n个任意字符
- `?` 1个任意字符
- `[...]` 任意一个括号中的字符，如`[ab14]`
- `[...-...]` 任意一个编码顺序内的字符，如`[0-9]`
- `[^...]` 反选
- `#` 注释
- `\` 转义符
- `|` 管道
- `;` 分割连续指令
- `&&` `||` 依赖前一个指令的结果决定后一个指令，短路算法
- `~` 用户主目录
- `$` 变量前缀符
- `&` job control，将指令转到后台
- `!` 逻辑非运算符
- `/` 目录符号
- `>` 输出重定向，取代
- `>>` 输出重定向，累加
- `<` 输入重定向
- `<<` 输入重定向
- `''` 纯文本内容，不进行变量内容转换
- `""` 将文本中的变量进行内容替换
- `()` 括号中为子shell的
- `{}` 括号中为命令区块组合



##### 数据流及重定向

- standard input / stdin
  - 代码为0，重定向使用`<` `<<` 
  - `<` 使用文件作为标准输入
  - `<<` 后接代表结束的字段（不包含在输入内）
- standard output / stdout
  - 代码为1，重定向使用`>` `>>`
  - 指令正确执行返回的信息
  - 输出到已存在的文件时，使用`>`原内容会被覆盖，而`>>`会追加
- standard error output / stderr
  - 代码为2，重定向使用`2>` `2>>`
  - 指令执行失败返回的信息
  - `2> /dev/null` 用于忽略所有错误信息
- 将stdout和stderr重定向到同一文件时，使用`>file 2>&1`或`&> file`
- 双向重定向 `tee file`
  - 同时将数据流输出到stdout和文件中
  - `-a` 以追加方式输出到文件
  - 如`ls /home | tee ~/tmp | more`可以在输出的同时将内容保存到tmp文件中



##### 管道

- 管道使用`|`作为分隔符
- 每个后续指令仅处理前一个指令stdout的信息，而忽略stderr
- 每个管道的后续指令必须能接受stdout的信息，使用`-`可以取用前一个指令的stdout



#####  `cut`

- 按行进行分析，输出处理后的结果，适用于有固定分隔符或格式整齐的情况
- `cut -d 'split symbol' -f fields`，如`echo $PATH | cut -d ':' -f 3,5`
- `cut -c intervals`，如`export | cut -c 12-`将切掉每行的前12个字符



##### `grep`

- 按行进行分析，输出符合要求的行
- `-a` 将binary文件以text文件的方式搜寻
- `-c` count，输出找到的搜寻字段的行数
- `-i` 忽略大小写
- `-n` 输出行号
- `-v` 反选，输出不符合的行
- `-A` after，后接数字，输出符合行后接的行
- `-B` before，后接数字，输出符合行前接的行
- 正规表达式



##### `sort`

- 对文件或stdin内容按特定方式排序
- `-f` 忽略大小写
- `-b` 忽略起始空白符
- `-M` 按月
- `-n` 按数字
- `-r` 反向排序
- `-u` unique
- `-t` 分隔符 `-f` 分割后的排序依据段



##### `unique`

- 将输入中重复的行去除
- `-i` 忽略大小写
- `-c` count，计数



##### `wc`

- 统计输出内容的各数据，默认显示全部三个统计结果
- `-l` 统计行数
- `-w` 统计字数（英文单字）
- `-m` 统计字符数



##### 字符转换命令

- `tr` 删除/替换
  - `-d` 删除字段，如`cat /etc/passwd | tr -d ':'`
  - `-s` 替换字段，如`last | tr '[a-z]' '[A-Z]'`

- `col`
  - `-x` 将tab转换为对应的空格，自动设置
- `expand` 
  - `-t` 后接数字，将tab转换为设定的空格
- `unexpand` 将空格转换为tab
- `join` 将两个文件中的关联行合并
  - 进行关联的文件需先排序处理
  - `-t` 各文件行的分隔符，默认空格
  - `-i` 忽略大小写
  - `-1` 指定第一个文件的行分割后使用的的字段，默认为1
  - `-2` 指定第二个文件
  - 如`join -t ':' -1 4 /etc/passwd -2 3 /etc/group`
- `paste file1 file2` 将两个文件中的行进行合并
  - `-d` 合并行中间的分隔符，默认tab
  - `-` file部分使用该符号代表使用stdin的内容



##### `split file prefix	` 

- 拆分文件，prefix为拆分后文件的前缀
- `-b` 后接拆分后的单文件大小，单位可以为b k m等
- `-l` 后接拆分后的单文件行数
- 文本文件复原时可以使用`cat prefix* >> file`



#### `xargs` 参数代换

- 用于产生某个指令的参数，用于不支持管道命令的指令，使其能够引用stdin
- `-n` 每次使用时消耗的参数个数
- `-p` 每次执行指令时询问是否执行
- `-e` 后接表示结束的字段