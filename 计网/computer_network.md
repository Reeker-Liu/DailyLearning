[TOC]

## 1 计算机网络和因特网

### 1.1 什么是因特网

- 主机 host / 端系统 end system 通过通信链路 communication link 和分组交换机 packet switch 连接在一起
- 链路的传输速率 bps
- 发送端将数据分段，加上首部后形成分组 packet，通过网络发送到目的段并装配成原始数据
- 从发送端到接收端，分组所经过的称为路径 path/route
- 端系统通过因特网服务提供商 Internet Service Provider ISP 接入因特网并获得服务
- 协议 protocol 控制因特网中信息的收发，最重要的是网际协议 Internet Protocol IP 和传输控制协议 Transmission Control Protocol TCP，协议定义了在两个或多个通信实体间交换的报文格式和次序，以及接受/发送信息时采取的动作
- 请求评论 Request For Comment RFC

### 1.2 网络边缘

- 端系统划分为客户 client和服务器 server
- 接入网 access network 指将端系统连接到边缘路由器 edge router 的物理链路，边缘路由器是端系统到其他远程端系统路径上的第一台路由器
- 数字用户线 Digital Subscriber Line DSL，DSL调制解调器，数字用户线接入复用器DSLAM，频分复用技术
- 电缆 cable，混合光纤同轴 Hybrid Fiber Coax HFC，电缆调制解调器 cable modem，电缆调制解调器端接系统 Cable Modem Termination System CMTS
- 局域网LAN

### 1.3* 网络核心

#### 分组交换 packet switching

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

#### 电路交换 circuit switching

- 电路交换网络中，端系统通信会话期间，预留了路径资源，即创建专用的端到端连接 end-to-end connection，而分组交换网络中，路径资源不预留，按需使用，因此可能发生等待

- 频分复用 Frequency-Division Multiplexing FDM 链路的频谱由所有连接共享，在连接期间每条连接专用一个频段
- 时分复用 Time-Division Multiplexing TDM 时间被划分为固定区间的帧，每帧被划分为固定数量的时隙，在每个帧中为连接指定时隙，转门为其传输所用

- 电路交换因为在静默期 silent period 专用电路空闲而效率较低

- 对比而言，分组交换
  - 不适合实时服务，因为端到端时延可变且不可预测
  - 提供给了更好的带宽共享，支持更高并发
  - 简单有效，实现成本低

#### 网络的网络

- 网络结构1 单一的全球承载ISP互联所有接入ISP，全球承载ISP为提供商 provider，接入ISP为客户 customer
- 网络结构2 数十万接入ISP和多个全球承载ISP
- 网络结构3 多层等级结构，向上级付费，最高层不向其他付费，区域ISP reginal，第x层ISP tier-x
- 网络结构4 增加存在点 Point of Presence PoP 存在于除底层的各层次，提供网络中一到多台路由器与提供商ISP连接，多宿 multi-home 使两个或更多提供商ISP互相连接，对等 peer 使相同等级的邻近ISP对直接连接，因特网交换点 Internet Exchange Point IXP 使多个ISP共同对等
- 网络结构5 在4的顶部增加内容提供商网络 content provider network

### 1.4* 分组交换网中的时延、丢包和吞吐量

结点总时延 total nodal delay 为以下4类时延之和

#### 处理时延 nodal processing delay

- 检查分组首部并决定转发链路
- 微秒或更少

#### 排队时延 queuing delay

- 分组在某链路的队列中等待传输
- 流量强度为 La/R，a pkt/s为分组到达速率，R为传输速率，L为分组大小
- 随着流量强度接近1，平均排队时延迅速增加

#### 传输时延 transmission delay

- 将分组向链路传输所需的时间
- 传输时延为 L/R，L表示该分组长度，R bps表示链路传输速率

#### 传播时延 propagation delay

- 从某链路的起点到终点消耗的时间，取决于物理媒体
- 传播时延为 d/s，d为链路距离，s为传播速率

#### 端到端时延

- 不考虑排队时延时 d<sub>end-end</sub> = N ( d<sub>proc</sub> + d<sub>trans</sub> + d<sub>prop</sub>)，路径上N条链路，N-1台路由器

#### 吞吐量

- 瞬时吞吐量 instantaneous throughtput
- 平均吞吐量 average throughtput
- 瓶颈链路 bottleneck link

### 1,5* 协议层次及其服务模型

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

### 1.6 网络攻击

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

### 2.2* Web和HTTP

- 超文本传输协议 HyperText Transfer Protocol 由客户程序和服务器程序实现，通过交换HTTP报文进行会话

