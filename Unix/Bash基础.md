## Bash

> Bourne Again SHell

- 记录历史命令
  - 前一次登陆执行的命令在`~/.bash_history`中记录
  - 本次登录执行的指令记录在内存中
- 命令与文件补全
- 命令别名设置 alias
  - 可直接设置，如`alias lm='ls -al'`
- 前后台工作控制 foreground/background job control
- 程序化脚本 shell scripts
- 通配符支持`*`
- 内建指令
  - `type cmd` 可查看是否为内建指令
- 变量
  - 环境变量，通常以大写字符表示
    - 使用`env` `export`可以查看
  - bash接口变量
    - `PS1`为命令提示符内容
  - 自定义变量
    - 与环境变量的区别在于变量是否被子程序所继承
    - 使用`export`使变量成为环境变量，如`export PATH`
    - 使用`set` 查看所有变量（环境变量+自定义变量+bash接口变量）
  - 变量设定规则
    - 变量与内容间以等号连接，等号两侧不能直接用空格
    - 变量名称为字母和数字，但不能数字开头
    - 变量内容可用单双引号
      - 若使用双引号，则特殊字符保有原本特性，`var="lang $LANG"`
      - 若使用单引号，则特殊字符保留纯文本
    - 使用`\`将特殊字符转义
    - 使用反单引号或`$(cmd)`来获得其他指令提供的信息，如`ver=$(uname -r)`
    - 使用`$name` 或`${name}`来累加变量内容，如`PATH="$PATH":/bin`
    - 使用`unset name`取消变量

P450