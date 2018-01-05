# Swift_HttpRequest


## Demo说明
Demo主要介绍Swift的网络部分，代码已更新到swift4

### --网络部分
请求均采用 `Alamofire`

请求封装方式分为：
* 1.Moya（一个star很多的`Alamofire`的上层封装，为本demo推荐方式。我在使用过程中最终发现moya是极其优美的网络请求方式）
* 2.链式请求（如果你刚刚从OC转到swift，可能还不适应moya的方式，那么可以用这种请求方式来过渡）
* 3.仿AFN式请求（这应该是OC中常见的封装方式，但是真的不再适合swift这个优美的语言啦）

### --Progress及信息处理
加载动画及弹出框采用 MBProgressHUD

### --数据解析
在swift4之前，我一直用的是`HandyJSON`（下面有介绍）。在swift4之后我把model的解析转到到官方的Codable。

本来这个demo只是我转swift时用来学习网络的，但是发现对一些同学很有帮助，所以重新整理了一下代码，将代码由swift3升级到swift4，并且抛弃了`HandyJSON`，因为swift语言的特性，要学就学最新的，所以demo中不再提供其他josn解析方式的示例

### --缓存
缓存部分没有接入数据库，而是直接用了`write to file`,并将缓存封装到网络请求方法中

## 本demo内容可直接用于项目开发，我在项目中大量使用，感觉还不错哈哈哈

---------------------
## 三方库介绍

[Alamofire](https://github.com/Alamofire/Alamofire)：Swift中著名的网络请求库

[Moya](https://github.com/Moya/Moya)：著名的Alamofire封装，让网络请求看起来更加的优美，更有利于阅读与迭代

[MBProgressHUD](https://github.com/jdg/MBProgressHUD): 进度条，弹出框,OC写的库

[Kingfisher](https://github.com/onevcat/Kingfisher): 加载网络图片，类似SDWebImage
#### 已弃用

[HandyJSON](https://github.com/alibaba/HandyJSON) 是阿里巴巴开源的model的映射库。使用方式类似OC中的MJExtention

[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)：json解析库，需要手动写映射关系

具体可以看[在Swift语言中处理JSON - 转换JSON和Model](http://www.cocoachina.com/swift/20161010/17711.html)

## 接口说明
本demo使用接口为多米音乐接口
http://v5.pc.duomi.com/search-ajaxsearch-searchall?kw=关键字&pi=页码&pz=每页音乐数
请求数据参数：kw=像我这样的人&pi=1&pz=1

返回实例：
```
{
"album_offset": 0,
"albums": [
{
"artists": [
{
"id": 61799986,
"name": "Mc名决",
"portrait": null,
"valid": false
}
],
"available": true,
"company": "",
"cover": "http://pic.cdn.duomi.com/imageproxy2/dimgm/scaleImage?url=http://img.kxting.cn//p1/08/16/72494779.jpg&w=150&h=150&s=100&c=0&o=0&m=",
"id": 2742662,
"name": "像我这样的人",
"num_tracks": 4,
"release_date": "2017-08-22",
"type": "EP/单曲"
}
],
"artist_offset": 0,
"artists": null,
"dm_error": 0,
"error_msg": "操作成功",
"recommend": 0,
"total_albums": 1,
"total_artists": 0,
"total_tracks": 6,
"track_offset": 0,
"tracks": [
{
"album": {
"cover": "/p1/12/17/72493295.jpg",
"id": 2741390,
"name": "裙娣"
},
"artists": [
{
"id": 61792091,
"name": "DJ马哥",
"num_albums": 35,
"num_tracks": 233,
"portrait": "",
"valid": false
}
],
"availability": "1110",
"dlyric": "",
"id": 28136457,
"medias": [
{
"bitrate": 320,
"p2purl": "1A4DF5035CE09DB8DF0500000060CFABAC000000A9.mp3"
}
],
"mv": 0,
"slyric": "",
"title": "像我这样的人",
"isdown": "1",
"isplay": "1"
}
]
}
```
# End
----

## 作者语：

希望能达到抛砖引玉的效果

也给新学习swift的朋友一个简单的网络处理的方式

大家互相帮助，互相学习

如果对你有帮助还请给个Star，谢谢🙏
----
## 版本：

### 2.0 更新到swift4，重新整理代码

### 1.2 新增moya的demo

### 1.1 新增链式请求的封装
* 链式请求可以只组合需要的函数，本身默认为常用方式，简化常用的链式调用
* 对于非默认值的请求可以自定义进行设置
* 方便添加自定义行为，利于扩展
----------
### 1.0 类OC中的AFN封装
* 利于OC转swift的同学学习
* 其中对返回值做了JSON和String两种解析，String是为了方便实用HandyJSON，不使用HandyJSON可以自行删除部分代码
