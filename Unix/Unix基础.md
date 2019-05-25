[TOC]

## 指令

#### 实用指令

##### 一般指令

- `date` 显示日期和时间
- `cal` 显示日历
- `bc` 计算器

##### 压缩指令

> 若为目录，则将目录下的文件分别压缩

- `gzip` 预设`.gz`类型，应用最广
- `bzip2` 更优的压缩
- `xz` 更优的压缩，但效率较低

##### 打包指令

> 将多个目录或文件打包成一个大文件，同时进行压缩

- `tar`
  - `-c` 建立
  - `-t` 查看
  - `-x` 解压

#### 文件目录指令

- `ls` `-a`显示全部，`-l`显示为列表，可以结合在一起`-al`
  - `--time=mtime` 默认使用，显示内容变动时间
  - `--time=atime` 最后读取时间
  - `--time=ctime` 最后修改状态时间
- `cd` change directory 变换目录
  - `.` 此目录
  - `..` 上层目录
  - `-` 前一个工作目录
  - `~` 目前用户身份的主目录
  - `~account` 其他用户主目录
- `pwd` print working directory 显示当前目录，`-P`显示实际路径（针对link）
- `mkdir` make directory 新建文件夹，`-m` 设定权限，`-p` 递归建立各层级目录（针对一次性创建多级目录）
- `rmdir` 删除空目录
- `rm` 删除文件或目录
  - `-f` 忽略不存在的文件，不进行警告
  - `-i` 删除前会进行询问
  - `-r` 递归删除，危险！
- `touch filename` 建立空的文件，或是修改文件时间属性
- `cp source1 source2 ... to`  进行拷贝，来源大于1个时，目的必须为目录
  - `-a`联同文件全部特性一同复制
  - `-r`可以进行递归复制
  - `-p`联同文件属性一同复制
  - `-l`建立hard link，涉及inode，link数会增加
  - `-s`建立symbolic link，即快捷方式，文件名右侧会有`->`符号指向实际文件
  - `-d` 复制link时，若不加该参数，则复制实际文件，加入时复制link文件
  - `-u` 目标文件与源文件存在差异时复制
- `mv source1 source2 ... to` 进行移动，也可用于重命名，来源大于1个时，目的必须为目录
  - `-f` 若目标文件已存在，直接覆盖
  - `-i` 目标文件已存在时询问
  - `-u` 若source比目标文件新时更新目标文件
- `rename` 重命名
- `basename path` 取得路径的文件名
- `dirname path` 取得路径的目录名称

#### 文件内容指令

- `zcat` `zmore` `zless` 读取纯文本压缩文件

- `cat` concatenate 从头开始显示文件内容
  - `-A` 显示出原为空白的特殊字符
  - `-b` 打印出出非空白行行号
  - `-n` 打印出全部行号
- `tac` 从最后开始显示文件内容
- `nl` 显示文件时输出行号
- `more` 按页显示文件
  - `space` 向下翻页
  - `enter` 向下一行
  - `/keyword` 向下搜寻该关键词
  - `:f` 显示文件名以及目前行数
  - `q` 退出浏览
  - `b` 往回翻页
- `less` 同`more`，但可向前翻页
  - `page up` `page down` 翻页
  - `?keyword` 向上搜寻关键词
  - `n` 重复前一个搜寻
  - `N` 反向重复前一个搜寻
  - `g` 跳转到文件第一行
  - `G` 跳转到文件最后一行
- `head` 只显示最前面几行，默认十行
  - `-n number` 修改显示的行数，若为负数，则显示除最后number行以外的全部行
- `tail` 只显示最后面几行
  - `-n number` 类似head该参数
  - `-f` 持续检测该文件，新加入的数据均会被打印到屏幕
- `od` 以二进制方式读取
  - `-t oCc` 可以输出储存值与ASCII的对照表，与`echo`加管道结合使用可以快速翻译
- `file` 查询文件类型，如ASCII data binary等

#### 文件系统指令

- `df` 列出文件系统的整体磁盘使用量，主要读取superblock中的信息
  - `-h` 以Byte MB KB等格式显示
  - `-i` 以inode数量显示
- `du` 评估文件系统的磁盘使用量（推测目录所占容量）
  - 默认仅统计目录下的文件量
  - `-a` 列出文件与目录容量
  - `-s` 仅列出总量
- `lsblk` list block device 列出系统上所有磁盘列表
- `blkid` 列出装置的UUID等参数，UUID为全局单一标识符universally unique identifier
- `parted` 列出磁盘的分区表类型与分区信息
- `fdisk` MBR下分区操作
- `gdisk` GPT下分区操作
- `partprobe` 更新linux核心的分区表信息
- `mkfs` make filesystem 格式化文件系统，综合指令
  - `mkfs.xfs` 
  - `mkfs.ext4` 
  - ...
- `xfs_repair` xfs文件系统检查与修复
- `fsck` 检查与修复综合指令
  - `fsck.ext4`
- `mount` 挂载文件系统
- `umount` 卸载文件系统
- `mknod` 建立并查阅设备
- `xfs_admin` 修改xfs文件系统的UUID与label name
- `tune2fs` 修改ext4的UUID与label name
- `xfsdump` xfs文件系统备份
- `xfsrestore` xfs文件系统还原

#### 指令与文件搜寻指令

##### 指令搜寻

- `which` 仅搜寻PATH内的目录，不包含bash内建指令等
  - `-a` 将所有找到的指令列出，而不仅是第一个找到的指令
- `type` 

##### 文件搜寻

- `whereis filename/dirname` 仅搜寻特定目录下的文件
  - `-l` 列出默认搜寻目录
  - `-b` 仅搜索可执行即binary文件
  - `-s` 仅搜索source来源文件
  - `-m` 尽在manual路径下寻找
  - `u` 搜寻不在上述三个中的其他特殊文件
- `locate keyword` 利用数据库搜寻，只要整体路径中包含关键词就添加到结果
  - 数据库的更新有延迟，可使用`updatedb`来手动更新
  - `-i` 忽略大小写
  - `-c` 仅统计结果数量
  - `-l` 限制输出结果数量
  - `-r` 正规表示
- `find` 直接硬盘搜寻，速度慢
  - 时间相关参数
  - 使用者群组相关参数
  - 文件属性名称相关参数
  - 额外动作参数

#### 系统状态指令

- `who`  查看当前在线用户
- `netstat -a` 查看网络联机状态
- `ps -aux` 查看后台执行程序
- `sync` 主动将内存中尚未更新到硬盘的内容写入硬盘
  - 默认情况下，某些加载到内存并被修改的数据不会直接写回硬盘
  - 在一般账户下使用该命令，仅更新自己账户所使用的内存数据
- `shutdown` / `reboot` / `halt` / `poweroff` 功能相似，但shutdown有向其他在线用户发出警告等特殊用法
- `systemctl xx` **管理/调用系统中所有服务**
- `ulimit` 限制用户的某些系统资源
- `stty -a` setting tty，查看终端环境按键设定等


#### `man`
> `man xx` 用于获得命令/文件的详细介绍，默认存放在`usr/share/man`

- man为manual， xx为查询的内容，可以使用`man man`获得其详细说明
    - 使用`page up`/`page down`或空格来进行翻页
    - 使用`home`/`end`来快速移动至页首/页尾
    - 使用`?keyword`/`/keyword`来向上/向下进行关键词搜寻，使用`n`来跳转到当前搜索方向的下一个目标
- 在其显示的man page中，名字后的代号分别代表不同含义
    - **1** 用户在shell环境中可以操作的指令或可执行文件
    - 2 系统核心客户叫的函数与工具等
    - 3 常用的函数与库，多为C
    - 4 文件说明，通常为/dev下的文件
    - **5** 配置文件或是某些文件的格式
    - 6 游戏
    - 7 惯例与协议等，如文件系统/网络协议
    - **8** 系统管理员可用的管理指令
    - 9 跟kernel有关的文件
- 变种
    - `man -f xx` 根据指令名称精确查找
    - `man -k xx` 根据关键词进行模糊查找

#### `info`

> Linux系统下的命令/文件介绍，与man相近，增加类似超链接的跳转方式，默认存放在`usr/share/info`

...



## 功能

#### `--help` 参数

> 多数指令后加该参数可以显示指令基本用法与选项参数介绍

#### `tab` 补全
> Unix-like的shell中使用`tab`具有补全功能，可以避免输入错误

- 在cmd即第一个字段时使用代表命令补全
- 在第二及后续字段使用代表文件名/参数选项补全

#### `ctrl+c` 终止当前程序

#### `ctrl+d` EOF
> 可以用来取代多数情况下的exit/quit

#### `shift+PageUp/PageDown` 屏幕翻页





## 文件系统

#### 文件系统管理

- VFS virtual filesystem switch
  - linux核心通过VFS管理各文件系统
- 文件系统挂载与卸载
  - 单一文件系统不应该被重复挂载到不同的目录中
  - 单一目录不应重复挂载多个文件系统
  - 作为挂载点的目录，最好为空目录
- 开机挂载 `/etc/fstab` 以及 `/etc/mtab` 
  - P345，暂不记录
- 内存置换空间swap
  - P351，暂不记录

#### 文件系统类型

- FAT文件系统
  - 无inode
  - 每个block记录在前一个block中，链式读取
  - block过于离散时，读取效率很低，需要碎片整理
- 索引式文件系统 indexed allocation
  - superblock 记录filesystem的整体信息
  - inode 记录文件的权限与属性
  - block 记录实际的文件内容
- EXT 文件系统
  - 支持度广，但格式化效率低
  - 在格式化时划分为多个区块群block group，各自拥有独立的superblock inode block
  - 整体文件系统最开始是启动扇区boot sector用于安装开机管理程序，这样可以将不同开机程序安装到各个不同的文件系统
  - data block 放置文件实际内容数据
    - 支持1k 2k 4k三种固定大小，格式化后确定，具有编号，不同的block的文件系统支持的最大磁盘容量和最大单文件容量不同
    - 每个block只能放置一个文件的数据（内部碎片）
    - 文件可能占用多个block
  - inode table 放置inode
    - 大小固定为128B-256B，包括
      - 12个block
      - 1个间接索引，利用block来记录实际地block
      - 1个双重索引
      - 1个三重索引
    - 一个文件对应一个inode，即文件系统能拥有的文件数量与inode数量有关
    - 读取文件时先使用inode内的信息判断，若可取再读取实际文件内容
    - 记录内容
      - 文件存取模式 rwx
      - 文件拥有者和群组
      - 文件容量
      - 文件时间参数 c/a/m time
      - 特性标志 SUID SGID ...
      - block
  - superblock 记录整个文件系统的信息
    - inode/block总量
    - inode/block使用量、剩余量
    - inode/block大小
    - 文件系统的格式
    - 文件系统挂载时间、最后写入数据时间、最后检验磁盘时间等相关信息
  - filesystem description 文件系统描述说明
    - 描述每个block group 的开始和结束block，用于划分区段
  - block bitmap 区块对照表
    - 记录未使用的block
  - inode bitmap inode对照表
    - 记录未使用的inode
- 日志式文件系统 journaling filesystem
  - 在系统中规划出专门用于记录文件系统变动的区块，简化一致性检查
  - 开始前，先在日志记录区块记录相关信息
  - 实际对文件进行操作，并更新metadata数据
  - 完成操作和更新后，在日志记录区块中结束该记录
- 挂载点 mount point
  - 文件系统要链接到目录树才能使用
  - 将文件与目录树结合的过程称为挂载
  - 挂载点一定是目录，该目录为该文件系统的入口
- XFS文件系统
  - 日志式文件系统，用于高容量磁盘及高性能文件系统
  - 资料区 data section
    - 分为多个储存区群组allocation group，与EXTblock group类似
    - 但inode block都是根据需要动态配置，且两者大小的可选范围也有扩展
  - 活动登陆区 log section
    - 记录文件系统的变化，类似日志区
    - 每条记录直到操作全部完成后被终结
    - 磁盘活动相当频繁，建议指定外部ssd磁盘用于该区域
  - 实时运作区 realtime section
    - 文件被建立时，在该区段找到数个extent区块，将文件放置到相应区块后，写入到data section的inode block中
    - extent区块大小在格式化时被指定，建议与磁盘阵列的stripe相等

#### 使用者与群组

- 文件的权限管理类别
  - owner 所有者
  - group 群组 （支持多群组）
  - others 其他人
- 记录文件
  - 账户相关信息 `/etc/passwd`
  - 个人密码 `/etc/shadow`
  - 群组 `/etc/group`

#### 文件属性

##### 类型和权限属性 

> 使用`ls -l`显示的文件权限包括十位字符，如 `-rwxr-x---`

- 第一个字符代表文件类型
  - `d` directory，目录
  - `-` 常规文件
    - 纯文本文件
    - 二进制文件
    - 数据格式文件，即特定格式文件
  - `l` link file，类似快捷方式
  - `b` block，表示为可供随机储存的接口设备，如硬盘
  - `c` character，表示为串行端口设备，如鼠标键盘
  - `s` sockets，套接字接口文件，用于网络通信
  - `p` pipe，数据输送文件，FIFO，用于解决多个程序同时存取一个文件造成的错误问题
- 接下来的字符每三个一组，分别为`r` `w` `x`，若无对应权限使用`-`占位
  - 第一组为文件拥有者owner具备的权限
  - 第二组为加入此群组的账号的权限
  - 第三组为其他账户的权限
- 意义
  - 对文件而言，针对的是文件内容
    - `r`代表内容可读
    - `w`代表内容可写，但文件本身的删除不包括在内
    - `x`代表可执行，但不代表文件本身是执行用文件，不同于windows系统由扩展名决定是否可执行
  - 对目录而言，针对的是其下记录的文件列表
    - `r`代表列表可读，即通过`ls`可进行显示等
    - `w`表示可以对文件进行异动，如新建/删除/修改/移动文件与目录
    - `x`代表可以进入该目录并使其成为当前工作目录，即通过`cd`切换等

##### hard link

- `ln source dir` 建立hard link

- 多个文件对应同一个inode
- 建立新的hard link仅在目录的block中增加一条关联数据，不会消耗磁盘空间和inode数量
- 将任何一个文件删除时，只要链接计数不为0，则原inode block均不删除
- 不能跨filesystem建立
- 不能创建目录的hard link

##### symbolic link

- `ln -s source to` 建立symbolic link

- 类似快捷方式，建立一个独立的文件，会让读取指向其link的实际文件
- 会占用磁盘空间和inode，其内容为目标文件的完整路径
- 实际文件本删除后，则无法使用

##### 扩展名

- unix-like系统并没有真正的扩展名，文件是否具有被执行能力取决于x属性
- 适当的扩展名用于增加可读性
  - `.sh` 脚本或批处理文件，为shell使用
  - `.Z` `.tar` `.tar.gz` `.zip` `.tgz` 压缩文件
- 以`.`开头的文件和文件夹为隐藏文件/文件夹

##### 文件时间属性

- modification time: 内容被变动时更新
- status time: 权限与属性被变动时更新
- access time: 被取用时更新

#### 修改文件属性和权限

##### `chgrp` 修改所属组群

> chgrp [-R] dirname/filename ...

##### `chown` 修改文件拥有者

> chown [-R] account:group dirname/filename

##### `chmod` 修改权限

> chmod [-R] xyz dirname/filename

- 数字方式修改
  - r-4 w-2 x-1
  - 对每组的权限进行累加，分别替换xyz
  - example `chmod 755 filename`
- 符号方式修改
  - `u` user, `g` group, `o` others
  - `+` add, `-` remove, `=` set
  - `r` / `w` / `x`
  - example `chmod u=rwx,go=rx filename`, here no white spaces among the string

#### 文件隐藏属性

> 仅部分Linux文件系统支持

##### `chattr` 配置隐藏属性

- `+` 增加新的属性
- `-` 移除特定属性
- `=` 配置为指定属性
- `a` 设定后仅能增加数据而不能删除或修改
- `i` 设定后不能删除修改和增加数据

##### `lsattr` 查看隐藏属性

- `-a` 显示隐藏文件
- `-d` 若为目录，仅显示目录本身属性
- `-R` 递归显示子目录

#### 文件特殊权限

> P273 暂不记录

##### SUID

##### SGID

##### SBIT

#### 文件预设权限`umask`

> umask用于指定当前用户在建立文件或目录时的默认权限值

- 默认权限
  - 建立文件时默认权限为`-rw-rw-rw-`
  - 建立目录时默认权限为`-drwxrwxrwx`
- `umask`使用
  - 默认查看数字形式，共四位数字，第一位为特殊权限使用
  - `umask -S`查看符号形式
  - `umask ugo` 设置umask
  - 显示的内容为需要撤销的权限，类似子网掩码

#### FHS(Filesystem Hierarchy Standard)

> 规范特定目录下放置的数据内容

##### 核心规定

- `/` root根目录，与开机系统有关
  - 所在分区越小越好，不要将应用程序安装软件放在该分区
- `/usr` **unix software resource**，与软件安装/执行有关，存放的数据具有可分享和不变动的性质，软件应将数据合理分别放置在该目录下的子目录中，而不应该建立单独的目录
  - `/usr/bin` 所有一般用户能够使用的指令，不应含有子目录，现在被`/bin`link
  - `/usr/lib` 现在被`/lib`link
  - `/usr/local ` 系统管理员在本机安装的软件，便于管理，含有bin etc include lib等子目录
  - `/usr/sbin ` 现在被`/sbin`link
  - `/usr/share ` 放置只读的数据文件和共享文件，多为文本文件
    - `/usr/share/man` 联机帮助文件
    - `/usr/share/doc` 软件说明文件
- `/var` variable，与系统运行过程有关，针对变动性数据文件
  - `/var/cache` 应用程序运行过程中的缓存
  - `/var/lib` 程序执行过程中需要使用的数据文件，各软件使用独立的子目录
  - `/var/lock` 独占资源，目前移动到`/run/lock`
  - `/var/log` 存放登陆文件
  - `/var/mail` 个人邮箱目录，与`/var/spool/mail`互为链接文件
  - `/var/run` 存放进程PID，与`/run`相同
  - `/var/spool` 存放队列数据，等待程序使用
- `/bin` 存放执行文件，用于单人维护模式下的指令，如chmod chown mkdir bash等
- `/sbin` 由root用于设定系统环境，一般用户只能查询，包括开机过程以及修复还原系统需要的指令，如fdisk ifconfig等
- `/boot` 放置开机使用的文件，包括核心文件以及开机选单和配置文件
- `/dev` 设备接口以文件形式存在于该目录
- `/etc` 存放系统的配置文件，只有root有权修改，不应放置可执行文件
  - `/etc/opt` 放置第三方软件的相关配置文件
- `/lib` 现在link到`/usr/lib`，开机时会用到的以及`/bin` `/sbin` 的指令会调用的程序库
  - `/lib/modules` 放置可装卸的核心相关模块即驱动程序
- `/media` 放置可移除的设备
- `/mnt ` 暂时挂载的设备
- `/opt` 用于安装第三方软件
- `/run` 存放开机后产生的各项信息，可以使用内存模拟
- `/srv` 网络服务需要取用的数据目录，如www服务器的网页资料放置在`/srv/www`
- `/tmp` 一般用户或是正在执行的程序暂时存放文件的地方，完全公开存取，定期清理

##### 建议规定

- `/home` 系统默认的用户目录
- `/lib<qual>` 存放与`/lib`不同格式的二进制程序库，如64位的`/lib64`
- `/root` 系统管理员的目录，用于单人维护模式时挂载使用，与`/`在同一分区
- `/proc` 虚拟文件系统，数据均在内存中，不占用硬盘空间
- `/sys` 类似`/proc`

- `/usr` 
  - `/usr/games` 游戏相关数据
  - `/usr/include` 编程语言头文件与包含文件
  - `/usr/libexec` 一般用户不常用的执行指令和脚本
  - `/usr/lib<qual>` 
  - `/usr/src` 源码
- `/etc` 
  - `/etc/X11` 与X Window有关的配置文件
  - `/etc/sgml` 与sgml格式有关的配置文件
  - `/etc/xml` 与xml格式有关的配置文件

#### 文件路径变量 `$PATH`

- 执行指令时，系统会依照PATH的设定按顺序搜寻该指令的可执行文件，先搜寻到的先被执行
- `echo $PATH` 可以输出其内容
- `PATH="${PATH}:/root"` 可以添加`/root`到PATH中
- 安全起见，不建议将`.`即当前目录添加到PATH目录中
- 不同用户预设的PATH不同，默认执行的指令也可能不同          