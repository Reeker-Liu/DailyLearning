[TOC]

#### 概览

- 动态类型语言、脚本语言
- 设计目的是为了嵌入应用程序中，为应用程序提供灵活的扩展和定制功能
- 特性
  - **轻量级**: 用标准C语言编写并以源代码形式开放，编译后体积为KB量级，可以很方便的嵌入程序
  - **可扩展**: 提供了非常易于使用的扩展接口和机制，由宿主语言(通常是C或C++)提供这些功能，像内置的功能一样使用
  - 支持面向过程(procedure-oriented)编程和函数式编程(functional programming)
  - 自动内存管理；只提供了一种通用类型的表(table)，用它可以实现数组，哈希表，集合，对象；语言内置模式匹配；闭包(closure)；函数也可以看做一个值；提供多线程(协同进程，并非操作系统所支持的线程)支持
  - 通过闭包和table可以很方便地支持面向对象编程所需要的一些关键机制，比如数据抽象，虚函数，继承和重载等



#### 注释

##### 单行注释

```lua
--this is comment
```

##### 多行注释

```lua
--[[
this
is
comment
--]]
```



#### 标示符

- 以一个字母A到Z或a到z或下划线_开头后加上0个或多个字母，下划线，数字(0到9)
- 一般约定，以下划线开头连接一串大写字母的名字(如_VERSION)被保留用于Lua内部
- 不允许使用特殊字符如 @, $, 和 % 来定义标示符



#### 变量

- 类型：全局变量、局部变量、表中的域

- 默认情况下，变量是全局的
- 全局变量不需要声明，赋值即等于创建，没有初始化的全局变量的值默认为nil，删除全局变量时只需赋值为nil
- 可以对多个变量同时赋值，先计算右边所有的值然后再执行赋值操作 `x, y = y, x`



#### 数据类型

| 类型     | 描述                                                         |
| -------- | ------------------------------------------------------------ |
| nil      | 表示一个无效值 / 在条件表达式中相当于false                   |
| boolean  | true / false                                                 |
| number   | 双精度类型的实浮点数                                         |
| string   | 字符串                                                       |
| function | 由 C 或 Lua 编写的函数                                       |
| userdata | 用户自定义数据，表示由应用程序或 C/C++ 语言库所创建的类型，可以将任意 C/C++ 的任意数据类型的数据（通常是 struct 和 指针）存储到 Lua 变量中调用 |
| thread   | 表示执行的独立线路，用于执行协同程序                         |
| table    | 本质为关联数组(associative arrays)，数组的索引可以是数字、字符串或表类型。table 的创建通过"构造表达式"来完成，最简单构造表达式是{}，用来创建空表。默认初始索引以 1 开始 |

- `type()`函数可用于测试给定变量/值的类型
- 可以用 2 个方括号 `[[  ]]` 来包括多行字符串
- 内容连接使用的是 `..`，如`"ab" .. "cd"` `123 .. 456`
- Lua 里，最主要的线程是协同程序（coroutine）。跟线程（thread）差不多，拥有自己独立的栈、局部变量和指令指针，可以跟其他协同程序共享全局变量和其他大部分东西。线程跟协程的区别：线程可以同时多个运行，而协程任意时刻只能运行一个，并且处于运行状态的协程只有被挂起（suspend）时才会暂停
- 索引为字符串类型时，`table["key"]` 等同于 `table.key`



#### 循环

支持break语句

##### while

```lua
while(true)
do
    ...
end
```

##### 数值for

```lua
-- var从exp1变化到exp2，每次变化以exp3为步长递增var，exp3默认为1
-- expr1 expr2 expr3的值在循环开始前被计算，开始后不再重新计算
for var = expr1, expr2, expr3
do
    ...
end
```

##### 泛型for

```lua
-- 通过迭代器函数遍历，类似foreach
for k,v in ipairs(table)
do
    ...
end
```

##### repeat

```lua
repeat
    ...
until(true)
```



#### 流程控制

##### if

```lua
if(true)
then
    ...
end
```

##### if else

```lua
if(true)
then
    ...
elseif(true)
    ...
else
    ...
end
```



#### 函数

```lua
-- optional_function_scope: 可选，默认为全局函数，局部函数使用关键字 local
optional_function_scope function function_name( argument1, argument2, ... argumentn)
    function_body
    return result_params_comma_separated --函数返回值，可以返回多个值，以逗号隔开
end

-- 使用 ... 表示函数有可变的参数
function average(...)
   result = 0
   local arg={...}
   for i,v in ipairs(arg) do
      result = result + v
   end
   -- 可以通过 select("#",...) 来获取可变参数的数量
   print("number: " .. select("#",...))
   return result/select("#",...)
end

do  
    function foo(...)  
        for i = 1, select('#', ...) do  -- 获取参数总数
            local arg = select(i, ...); -- 读取特定参数
            print("arg", arg);  
        end  
    end  
  
    foo(1, 2, 3, 4);  
end
```



#### 运算符

##### 算数运算符

- 常规 `+` `-` `*` `/` `%` 
- `^` 乘幂

##### 关系运算符

- 常规 `==` `>` `<` `<=` `>=`
- `~=` 不等于

##### 逻辑运算符

- `and` `or` `not` 

##### 其他

- `..` 连接两个字符串
- `#` 一元运算符，返回字符串或表的长度



#### 字符串

- 表示方式
  - 单引号间
  - 双引号间
  - [[ 和 ]] 间
- 常规转义字符

##### 字符串函数

> 查找和替换函数中，正则表达式使用%作为转义字符

- string.upper(str)
- string.lower(str)
- string.sub(str,init,[end])
- string.gsub(mainStr,findStr,replaceStr,num) 
  - 替换，mainStr为要替换的字符串， findStr为被替换的字符，replaceStr 要替换的字符，num替换次数（忽略则全部替换）
- string.find (str, substr, [init, [end]])
  - 在目标字符串中搜索指定内容，返回其起始位置和结束位置两个下标，不存在则返回 nil
- string.reverse(str)
- string.format(...) 
  - 常规占位符
- string.char(str) 将整型数字转成字符并连接
  - `string.char(97,98,99,100) --abcd`
- string.byte(str[,int]) 转换字符为整数值
  - `string.byte("abcd",4) --100`
- string.len(str)
- string.rep(str, n)
  - 返回字符串str的n个拷贝
- string.gmatch(str, pattern)
  - 返回一个迭代器函数，每一次调用返回下一个符合 pattern 描述的子串。若没有找到，迭代函数返回nil
  - `for word in string.gmatch("Hello Lua user", "%a+") do print(word) end`
- string.match(str, pattern, init)
  - ？
  - 寻找第一个配对. 参数init指定搜寻起点, 默认为1
  - 成功配对时, 返回配对表达式中的所有捕获结果; 如果没有设置捕获标记, 则返回整个配对字符串. 当没有成功的配对时, 返回nil



#### 数组

- 索引键值可以使用整数表示，默认起始为1
- 数组的大小不是固定的，动态添加



#### 迭代器

- 迭代器是一种对象，用来遍历标准模板库容器中的部分或全部元素，每个迭代器对象代表容器中的确定的地址，支持指针类型
- 泛型 for 实际保存三个值：迭代函数、状态常量、控制变量
- 执行过程：
  - 首先，初始化，计算 in 后面表达式的值，表达式应该返回泛型 for 需要的三个值：迭代函数、状态常量、控制变量
  - 第二，将状态常量和控制变量作为参数调用迭代函数
  - 第三，将迭代函数返回的值赋给变量列表
  - 第四，如果返回的第一个值为nil则循环结束，否则执行循环体
  - 第五，回到第二步

##### 无状态迭代器

- 不保留任何状态的迭代器，避免创建闭包花费额外的代价

- 每一次迭代，迭代函数用状态常量和控制变量的值作为参数调用，获取下一个元素

```lua
-- ipairs简单实现
function iter (a, i)
    i = i + 1
    local v = a[i]
    if v then
       return i, v
    end
end
 
function ipairs (a)
    return iter, a, 0
end
```

##### 多状态迭代器 ？

```lua
function elementIterator (collection)
   local index = 0
   local count = #collection
   -- 闭包函数
   return function ()
      index = index + 1
      if index <= count
      then
         --  返回迭代器的当前元素
         return collection[index]
      end
   end
end

for element in elementIterator(array)
do
   print(element)
end
```



#### 可能的坑

- 控制结构的条件中除了false和nil为假，其他值都为真（0和空串）
- for循环的初始值、步长、结束条件，均只在开始循环时计算
- 在Lua中调用C++函数时必须写上所有参数，包括缺省参数
- 在使用有 const char* 参数的注册函数中判断该参数是否为 NULL 的同时还要判断是否是空串，即""，并且在Lua中调用该函数时为 NULL 的参数改用空串""代替
- 有C++注册类对象的指针作为参数的注册函数，在Lua中调用时允许从nil转换到C++中的NULL