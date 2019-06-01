[TOC]

## 1 计算机网络和因特网

#### 1.1 什么是因特网

- 主机 host / 端系统 end system 通过通信链路 communication link 和分组交换机 packet switch 连接在一起
- 链路的传输速率 bps
- 发送端将数据分段，加上首部后形成分组 packet，通过网络发送到目的段并装配成原始数据
- 从发送端到接收端，分组所经过的称为路径 path/route
- 端系统通过因特网服务提供商 Internet Service Provider ISP 接入因特网并获得服务
- 协议 protocol 控制因特网中信息的收发，最重要的是网际协议 Internet Protocol IP 和传输控制协议 Transmission Control Protocol TCP，协议定义了在两个或多个通信实体间交换的报文格式和次序，以及接受/发送信息时采取的动作
- 请求评论 Request For Comment RFC

#### 1.2 网络边缘

- 端系统划分为客户 client和服务器 server
- 接入网 access network 指将端系统连接到边缘路由器 edge router 的物理链路，边缘路由器是端系统到其他远程端系统路径上的第一台路由器
- 数字用户线 Digital Subscriber Line DSL，DSL调制解调器，数字用户线接入复用器DSLAM，频分复用技术
- 电缆 cable，混合光纤同轴 Hybrid Fiber Coax HFC，电缆调制解调器 cable modem，电缆调制解调器端接系统 Cable Modem Termination System CMTS
- 局域网LAN

#### 1.3* 网络核心

##### 分组交换 packet switching

- 端系统交换报文 message，可以包含控制内容或数据
- 源端将长报文划分成分组 packet，通过通信链路和分组交换机（分组交换机有路由器 router 和链路层交换机 link-layer switch）传送
- 若源端系统或分组交换机经过一条链路发送L比特的分组，传输速率为R bps，则传输时间为L/R秒
- 储存转发传输 store-and-forward transmission
  - 分组交换机在输入端使用储存转发传输，在接收并处理整个分组后才开始向输出链路传输该分组，先缓存再转发
- 排队时延和分组丢失
  - 对每条相连的链路，分组交换机具有一个输出缓存 output buffer / 输出队列 output queue，储存准备发往该链路的分组
  - 排队时延 queue delay
  - 分组丢失/丢包 packet lost
- 转发表和路由选择协议
  - 每台路由具有一个转发表 forwarding table，当分组到达时，根据路由表将目的地址或其部分映射成输出链
  - 路由选择协议 routing protocol 用于自动设置转发表

##### 电路交换 circuit switching

- 电路交换网络中，端系统通信会话期间，预留了路径资源，即创建专用的端到端连接 end-to-end connection，而分组交换网络中，路径资源不预留，按需使用，因此可能发生等待

- 频分复用 Frequency-Division Multiplexing FDM 链路的频谱由所有连接共享，在连接期间每条连接专用一个频段
- 时分复用 Time-Division Multiplexing TDM 时间被划分为固定区间的帧，每帧被划分为固定数量的时隙，在每个帧中为连接指定时隙，转门为其传输所用

- 电路交换因为在静默期 silent period 专用电路空闲而效率较低

- 对比而言，分组交换
  - 不适合实时服务，因为端到端时延可变且不可预测
  - 提供给了更好的带宽共享，支持更高并发
  - 简单有效，实现成本低

##### 网络的网络

- 网络结构1 单一的全球承载ISP互联所有接入ISP，全球承载ISP为提供商 provider，接入ISP为客户 customer
- 网络结构2 数十万接入ISP和多个全球承载ISP
- 网络结构3 多层等级结构，向上级付费，最高层不向其他付费，区域ISP reginal，第x层ISP tier-x
- 网络结构4 增加存在点 Point of Presence PoP 存在于除底层的各层次，提供网络中一到多台路由器与提供商ISP连接，多宿 multi-home 使两个或更多提供商ISP互相连接，对等 peer 使相同等级的邻近ISP对直接连接，因特网交换点 Internet Exchange Point IXP 使多个ISP共同对等
- 网络结构5 在4的顶部增加内容提供商网络 content provider network

#### 1.4* 分组交换网中的时延、丢包和吞吐量

结点总时延 total nodal delay 为以下4类时延之和

##### 处理时延 nodal processing delay

- 检查分组首部并决定转发链路
- 微秒或更少

##### 排队时延 queuing delay

- 分组在某链路的队列中等待传输
- 流量强度为 La/R，a pkt/s为分组到达速率，R为传输速率，L为分组大小
- 随着流量强度接近1，平均排队时延迅速增加

##### 传输时延 transmission delay

- 将分组向链路传输所需的时间
- 传输时延为 L/R，L表示该分组长度，R bps表示链路传输速率

##### 传播时延 propagation delay

- 从某链路的起点到终点消耗的时间，取决于物理媒体
- 传播时延为 d/s，d为链路距离，s为传播速率

##### 端到端时延

- 不考虑排队时延时 d<sub>end-end</sub> = N ( d<sub>proc</sub> + d<sub>trans</sub> + d<sub>prop</sub>)，路径上N条链路，N-1台路由器

##### 吞吐量

- 瞬时吞吐量 instantaneous throughtput
- 平均吞吐量 average throughtput
- 瓶颈链路 bottleneck link

#### 1.5* 协议层次及其服务模型

- 服务模型 service model 即某层向其上层提供的服务
- 协议层 layer 能够由软件、硬件或结合来实现
- 优点
  - 使实现层所提供的服务易于改变
  - 概念化、结构化
- 缺点
  - 可能冗余较低层的工作
  - 某层的功能可能需要仅在其他层才出现的信息，违反了层次分离目标
- 各层协议综合起来成为协议栈 protocol stack
  - 应用层 application
    - HTTP SMTP FTP DNS
    - 位于多个端系统上，在应用程序间交换报文 message
  - //表示层
    - 使通信的应用程序能够解释交换数据的含义
    - 数据压缩、数据加密、数据描述
  - //会话层
    - 提供数据交换定界和同步功能
    - 建立检查点，恢复方案
  - 运输层 transport
    - TCP面向连接服务 UDP无连接服务
    - 在应用程序端点间传送报文段 segment
  - 网络层 network
    - IP定义数据报各字段内容 路由选择协议
    - 在主机间移动数据报 datagram
  - 链路层 link
    - 将帧 frame 从一个结点移动到下一结点
  - 物理层 physical
    - 将帧中的bit从当前结点移动到下一结点
    - 与实际传输媒体有关
- 封装 encapsulation 在每一层，一个分组具有两种类型的字段，首部字段和有效载荷信息 payload field，有效载荷是来自上一层的分组

#### 1.6 网络攻击

- 恶意软件 malware
- 僵尸网络 botnet
- 病毒 virus 需要用户交互来感染设备
- 蠕虫 worm 无需明显交互即可侵入设备
- 拒绝服务攻击 Denial-of-Service Dos
- 分布式Dos Distributed DDos
- 分组嗅探器 packet sniffer
- IP哄骗 spoofing



## 2 应用层

#### 2.1 应用层协议原理

- 客户服务器体系结构 client-server architecture
- P2P体系结构
- 进程 process 通过称为套接字 socket 的软件接口进行通信，套接字是应用层与运输层之间的接口，对运输层的控制限于选择运输层协议和设定参数
- 进程寻址需要
  - IP地址
  - 端口号 port number 指定接收主机上的接收进程
- 运输层协议提供的服务类型
  - 可靠数据传输 reliable data transfer
  - 吞吐量，暂无协议提供
  - 定时，暂无协议提供
  - 安全性，包括数据完整性
- TCP
  - 面向连接的服务，TCP connection是全双工的，连接双方进程可同时收发报文，结束时拆除
  - 可靠数据传输，无差错，有序交付
  - 拥塞控制机制
- UDP
  - 轻量级运输协议
  - 无连接
  - 不可靠数据传输，可能乱序到达或丢失
  - 无拥塞控制

- 应用层协议
  - 交换的报文类型，如请求报文、响应报文
  - 报文类型的语法，即各字段信息与描述
  - 字段的语义，即字段信息含义
  - 何时/如何发送报文，响应规则

#### 2.2* Web和HTTP

- 超文本传输协议 HyperText Transfer Protocol 由客户程序和服务器程序实现，通过交换HTTP报文进行会话
- Web页面由对象组成，包含一个基本文件和引用对象
- HTTP定义了Web客户与服务器请求和发送页面的方式，不用担心数据丢失和乱序
- HTTP不保存关于客户的任何信息，是一个无状态协议 stateless protocol
- HTTP默认采用持续连接 persistent connection，所有的请求及响应通过相同的TCP连接发送，超时未被使用则关闭该连接
- 非持续连接时，每个TCP连接在服务器发送一个对象后关闭，只传输一个请求报文和一个响应报文
- 往返时间 Round-Trip Time RTT，指一个短分组从客户到服务器再返回花费的时间

##### HTTP请求报文

- 第一行为**请求行** request line，包含三个字段：方法字段(GET/POST/HEAD/PUT/DELETE)、URL字段和HTTP版本字段
  - HEAD请求不会返回对象，用一个HTTP报文响应，常用于调试跟踪
  - PUT方法常与web发行工具联合使用，上传对象到指定的web服务器的指定路径
  - DELETE方法允许用户或应用程序删除Web服务器上的对象
- 后续的行为**首部行** header line
  - Host指明主机
  - Connection说明是否使用持续连接
  - User-agent指明用户代理
  - Accept-language表示需要的语言版本
  - Cookie设定识别cookie
- 在首部行和附加的回车和换行后有**实体体** entity body，使用POST方法时才使用

##### HTTP响应报文

- 1个**初始状态行** status line 包含三个字段：协议版本、状态码、相应状态信息
  - 200 OK 请求成功，对象在响应报文中
  - 301 Moved Permanently 对象被永久转移，新的URL在响应报文的Location中
    - 304 Not Modified 用于条件GET请求响应
  - 400 Bad Request 通用错误代码
  - 404 Not Found 被请求的内容不在服务器
  - 505 HTTP Version Not Supported 不支持协议版本
- 6个**首部行** header line
  - Connection用于通知是否保持TCP连接
  - Date指明产生并发送响应报文的日期和时间，不是对象创建或修改的时间
  - Server指明服务器类型
  - Last-Modified指明对象创建或最后修改的时间
  - Content-Length指明被发送对象的字节数
  - Content-Type指明实体体中的内容类型
- **实体体** entity body 包含了请求的对象

##### cookie

- 允许站点对用户进行跟踪，用于标识一个用户，可以在无状态HTTP上建立用户会话层
- 组件
  - HTTP响应报文中的cookie首部行
  - HTTP请求报文中的cookie首部行
  - 用户端系统中由浏览器管理的cookie文件
  - web服务器的数据库

##### web缓存

- web缓存器 cache 也叫代理服务器 proxy server，代表初始web服务器来满足HTTP请求
- web缓存器有自己的磁盘存储空间，并保存最近请求过的对象的副本，是服务器的同时也是客户，分别针对浏览器和初始服务器
- 内容分发网络 Content Distribution Network CDN 通过分散的缓存器，使大量流量本地化
- 优点
  - 可以减少对客户请求的响应时间
  - 可以减少机构的接入链路到因特网的通信量

##### 条件GET方法

- 条件GET conditional GET
  - 请求报文使用GET方法
  - 包含一个If-Modified-Since首部行

#### 2.3 文件传输协议FTP

- 使用两个并行的TCP连接，独立的控制连接信息称为带外 out-of-band 传送的
  - 控制连接 control connection 持续连接，用于在两主机间传输控制信息
  - 数据连接 data connection 非持续连接，用于实际文件传输，每次文件传输建立新的数据连接
- FTP服务器在整个会话期间保留用户的状态，限制了同时维护的会话总数

#### 2.4 电子邮件

- 组成部分
  - 用户代理 user agent
  - 邮件服务器 mail server
  - 简单邮件传输协议 Simple Mail Transfer Protocol SMTP
- 每个接收方在其邮件服务器上有一个邮箱 mailbox 管理和维护着发送给该用户的报文
- 流程：发送方用户代理，发送方邮件服务器的报文队列 message queue，接收方的邮件服务器，接收方邮箱

##### SMTP

- 由运行在发送方邮件服务器的客户端和运行在接收方邮件服务器的服务器端组成
- 每个邮件服务器上均运行客户端和服务器端
- 不使用中间邮件服务器发送邮件，邮件也不在中间邮件服务器存留
- 采用持续连接
- 与HTTP区别
  - HTTP为拉协议 pull protocol，由想接收文件的机器发起
  - SMTP为推协议 push protocol，由要发送该文件的机器发起
  - SMTP要求每个报文，包括体，均使用7bit的ASCII码，需要将二进制文件转码再还原

##### 邮件访问协议

- 第三版邮局协议 Post Office Protocol Version3 POP3
- 因特网邮件访问协议 Internet Mail Access Protocol IMAP

#### 2.5* DNS 因特网目录服务

- 主机标识方法包括：主机名 hostname 和IP地址 IP address

##### 服务

- 域名系统 Domain Name System 提供主机名到IP地址转换的目录服务
- DNS是由分层DNS服务器实现的分布式数据库，以及一个使主机能查询分布式数据库的应用层协议
- DNS协议运行在UDP上，使用53号端口，通常由其他应用层协议使用，将用户提供的主机名解析为IP地址

- 主机别名 host aliasing，通常比规范主机名 canonical hostname 容易记忆，应用程序可以调用DNS来获得主机别名对应的规范主机名以及主机的IP地址
- 邮件服务器别名 mail server aliasing，MX记录允许功德邮件服务器和web服务器使用同一个主机别名
- 负载分配 load distribution，在冗余的服务器之间进行负载分配，繁忙的站点被冗余分布在多台服务器上。由于冗余web服务器，一个IP地址集合与一个规范主机名相联系。当客户对某个主机名发出请求时，服务器用IP地址的整个集合进行相应，但对于每个独立的请求，循环这些IP地址的次序
- 注册登录机构 registrar 是一个商业实体，验证域名的唯一性，将域名输入DNS数据库，并收取服务费用

##### 工作原理

- 单一集中DNS服务器模式的问题
  - 单点故障 a single point of failure
  - 通信容量 traffic volume
  - 远距离的集中式数据库 distant centralized database
  - 维护 maintenance
- 采用分布式、层次数据库，没有单一DNS服务器拥有全部主机的映射，他们分散在所有DNS服务器上
  - 根DNS服务器，每个服务器都是一个冗余服务器网络，以提供安全性和可靠性
  - 顶级域DNS服务器 Top-Level Domain TLD，负责顶级域名如com org net edu
  - 权威DNS服务器，组织机构的权威DNS服务器保存了其提供公共可访问的DNS记录
  - 本地DNS服务器 local，不属于DNS服务器层次结构，起代理作用，将主机发出的请求转发到DNS服务器层次结构中
- 任何DNS查询都可能是递归查询 recursive query 或迭代查询 iterative query

##### DNS缓存 caching

- 在一个请求链中，当某DNS服务器接收到回答时，将信息缓存在本地
- 主机和主机名与IP的映射不是永久的，在一段时候缓存信息将被丢弃
- 资源记录 Resource Record RR 提供了主机名到IP地址的映射，包含四元组 (Name, Value, Type, TTL)
  - TTL为该记录的生存时间，决定了该记录从缓存中删除的时间
  - 若Type=A，则Name为主机名，Value为对应的IP地址，如`relay11.bar.foo.com, 145.37.93.126, A`
  - 若Type=NS，则Name为域，Value是该域相关的权威DNS服务器的主机名，用于沿查询链路由DNS查询，如`foo.com, dns.foo.com, NS`
  - 若Type=CNAME，则Value是别名为Name的主机对应的规范主机名，用于向查询的主机提供一个主机名对应的规范主机名，如`foo.com, relay11.bar.foo.com, CNMAE`
  - 若Type=MX，则Value是别名为Name的邮件服务器的规范主机名，为了获得邮件服务器的规范主机名，DNS客户应当请求MX记录，为了获得其他服务器的规范主机名，应当请求CNAME记录

##### DNS报文

- 查询和回答报文具有相同的格式
- 前12个字节是首部区域
  - 第一个字段用于标识该查询，16bit的数，会被复制到回答报文以进行匹配
  - 标志字段含有若干标志
    - 1bit查询/回答标志位指出报文类型
    - 1bit权威标志位
    - 1bit递归查询标志位
    - 1bit递归可用标志位
  - 问题数
  - 回答RR数
  - 权威RR数
  - 附加RR数
- 问题区域包括查询的名字和类型
- 回答区域包含对请求的响应RR
- 权威区域包含其他权威服务器的记录
- 附加区域包含了其他有帮助的记录

#### 2.6 P2P

- 分发时间 distribution time所有对等方得到文件副本需要的时间
- P2P体系结构具有自扩展性，因为对等方除了是bit的消费者，也是其分发者

##### BitTorrent

- 用于文件分发的P2P协议
- 参与特定文件分发的所有对等方的结合称为洪流 torrent
- 洪流中的对等方彼此下载等长的文件块 chunk
- 每个洪流具有一个基础设施节点称为追踪器 tracker，一个对等方加入时像追踪器注册自己，并周期性通知追踪器仍在洪流中
- 一个对等方加入时，追踪器随机选择对等方子集，并试图创建与他们的TCP连接，成功创建连接的对等方为邻近对等方，一个对等方的邻近对等方随时间波动
- 对等方周期性的向邻近对等方询问其块列表并对缺失的块进行请求，采用最稀缺优先 rarest first，使稀缺的块迅速重新分发，均衡各文件块在洪流中的副本数量
- 对换算法决定响应哪些请求，根据当前提供文件块的最高速率进行优先级排序，对于每个邻近对等方持续测量接收速率，速率最高的邻近对等方称为疏通 unchoked。同时，每隔一定时间随机选择另一个邻居发送数据，并参与排序，从而趋向于找到彼此协调的速率上载。其他邻近对等方被阻塞
- 交换的激励机制称为一报还一报 tit-for-tat

##### 分散式散列表 Distributed Hash Table DHT

- 每个对等方分配一个标识符
- 为标识符最邻近该键的对等方分配键值对
- 最邻近对等方定义为键的最邻近后继
- DHT通常以环形覆盖网络为基础，增加捷径，使每个对等方不仅联系它的直接后继和直接前任，而且联系分布在环上的捷径对等方
- 维护DHT时需要处理对等方扰动，每个对等方要周期性联系并证实其两个后继是存活的

#### 2.7* 套接字编程

参考课本UDP TCP程序代码



## 3 运输层

关键功能：将网络层在两个端系统间的交付服务扩展到运行在两个端系统上的应用进程之间的交付服务

#### 3.1 概述和运输层服务

- 运输层协议为不同主机上的进程提供了逻辑通信 logic communication，使其像直接相连；与此相对，网络层提供了主机之间的逻辑通信
- 发送端运输层将从应用程序进程接收到的报文转换成运输层分组，即报文段 segment，再传递给网络层
- 运输层协议仅在端系统而不是路由器中实现，对报文在网络核心如何移动并不做任何规定
- 运输层协议（最低限度）服务
  - 受限于底层网络层协议的服务模型，因此无法提供时延或带宽保证
  - 数据交付
  - 差错检查
- 网络层协议IP
  - 服务模型为尽力而为交付服务 best-effort-delivery service
  - 不可靠服务 unreliable

#### 3.2 多路复用与多路分解

- 运输层的多路复用 transport-layer multiplexing 与多路分解 demultiplexing 将主机间交付扩展到进程间交付



UDP 用户数据报协议 不可靠、无连接服务



TCP 传输控制协议 可靠、面向连接服务

拥塞控制congestion control