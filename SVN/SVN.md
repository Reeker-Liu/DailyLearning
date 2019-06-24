#### 检出

` svn checkout svn://ip/trunk --username=user`

#### 更新

`svn update`

可用`-r`指定更新版本

#### 查看历史信息

`svn log` 显示版本信息

- 默认显示整个目录的版本信息，指定`filename`则仅查看某一文件的版本修改信息

- `-r m:n` 对比两版本
- `-v` 显示目录信息
- `-l N` 限定显示记录数量

`svn diff ` 检查历史修改详情

- 默认比较本地修改与本地原始副本内容
- `-r ver filename` 比较工作拷贝与版本库中ver版本的指定文件
- `-r m:n filename` 比较工作版本m和n中的指定文件

`svn cat filename` 查看文件，不进行对比

- `-r ver` 查看指定版本下的文件

`svn list url` 在不下载文件的情况下查看目录内容

#### 查看工作副本状态

`svn status`

`?`为未添加文件，不属于版本库控制，不能提交，使用`svn add filename`添加到版本库

`A`为已添加

`M`为已修改

#### 版本回退

单个文件

`svn revert filename`

整个目录

`svn revert -R dir`

#### 分支/标签

如有需要再补

#### 提交更改

`svn commit -m "comment for this commit"`

