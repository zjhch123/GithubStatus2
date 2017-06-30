这是一个macOS 系统上的状态栏(StatusBar)App。

# 功能是什么？
功能就是查某账号当日在github上提交了几次代码。可以切换不同的账号。账号也不一定得是自己的，也可以查你喜欢的人或者你不喜欢的人。

# 是如何实现的？
很简单粗暴，直接请求`https://github.com/{username}`，返回的html body里抓到`data-count="{count}" data-date="{now_date}"`这样的数据就可以了。`HTTP`请求库用了`SwiftHTTP`，正则库用了`CrossroadRegex`，Swift这个正则语法…让我有点懵逼。

# 为什么要做这个？
懒，纯粹是因为懒。因为每天都想在github上提交代码，但是有时候又会忘记，就希望能很实时的查看自己有没有提交过。有了这个App之后点一下就可以看见自己有没有提交过，方便很多。

# 做这个耗时多久？
差不多2天吧。基本上重学了一遍Swift，然后还做了两个不同的版本(1.0, 2.0)

# 为什么做两个版本？1.0版本在哪里？
1.0版本是基于菜单栏的，2.0版本是基于pop view的，两者不怎么一样。我也懒得切分支，所以就另外开了一个项目了。
1.0版本在[这里](https://github.com/zjhch123/GithubStatus)

# 接下来的打算？
大概还会加入定时提醒commit代码的功能吧…毕竟人老了，健忘…

# 下载地址
可以在[release](https://github.com/zjhch123/GithubStatus2/releases)里直接下载

# Update:
* 2017年06月30日: 增加了一抹绿色
* 2017年06月30日: 更新开机自动启动的设置
