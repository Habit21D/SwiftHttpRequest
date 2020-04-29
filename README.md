# SwiftHttpRequest(Swift5)
![](https://img.shields.io/badge/Swift-4.2-green.svg?style=flat)
![](https://img.shields.io/badge/Swift-5.0-green.svg?style=flat)


这里主要介绍了swift版本的网络请求，封装中带有Progress及错误信息处理，缓存等的统一解决方案

[简书地址https://www.jianshu.com/p/caa1a57e7423](https://www.jianshu.com/p/caa1a57e7423)

 ---------

<h3 id="demo_explain"> Demo说明</h3>
Demo主要介绍Swift的网络部分，代码已更新到swift5.0

**本demo内容可直接用于项目开发**

1. Moya文件夹中：MoyaBase是对Moya的封装。/Moya/MoyaBase/组建是可以不用更改的，当然，你也可以自定义组件
2. MoyaConfig.swift需要根据项目进行配置。每一项代码中都有明确的注释。
3. HttpRequest.swift需要自己重写跳转登录的代码，如果用不到可以删除或者将HttpCode.needLogin改为不可能用到的值
4. MoyaAPI里是后台接口及model文件
5. 提供跨类型解析方案，提供codable默认值解决方案


<h5 id="网络部分"> 一. 网络部分</h5>

请求均采用 `Alamofire`

请求封装方式分为：
- **1.Moya（一个star很多的`Alamofire`的上层封装，为本demo推荐方式。我在使用过程中发现moya是极其优美的网络请求方式）**
- **2.链式请求（如果你刚刚从OC转到swift，可能还不适应moya的方式，那么也可以用这种请求方式）**
- **3.仿AFN式请求（这应该是OC中常见的封装方式）**


<h5 id="Progress及信息处理"> 二. Progress及信息处理</h5>

加载动画及弹出框采用 `MBProgressHUD`


<h5 id="数据解析"> 三. 数据解析</h5>

在swift4之前，我一直用的是`HandyJSON`（下面有介绍）。在swift4之后我把model的解析转到到官方的Codable。


<h5 id="缓存"> 四. 缓存</h5>

缓存部分没有接入数据库，而是直接用了`write to file`,并将缓存封装到网络请求方法中

<h5 id="接口说明"> Demo所用接口</h5>

接口：http://app.u17.com/v3/appV3_3/ios/phone/rank/list
请求方式：get


<h4> 作者语：</h4>

希望能达到抛砖引玉的效果

也给新学习swift的朋友一个简单的网络处理的方式

大家互相帮助，互相学习

如果对你有帮助还请给个Star，谢谢🙏

----
<h5 id="版本"> 版本：</h5>

* 2.3 更新到Swift5

* 2.2 修改文件结构。使用moya时请配置MoyaConfig和HttpRequest文件。这是一个demo，不是一个拿来即用的三方库，所以请认真阅读代码，根据自己的项目做出更改和优化

* 2.1 `Codable`跨类型解析：`Int`解析成`String`， `String`解析成`Int`

* 2.0 更新到swift4，重新整理代码

* 1.2 新增`moya`的demo

* 1.1 新增链式请求的封装
 链式请求可以只组合需要的函数，本身默认为常用方式，简化常用的链式调用；
 对于非默认值的请求可以自定义进行设置；
 方便添加自定义行为，利于扩展；

* 1.0 类OC中的AFN封装
 利于OC转swift的同学学习。
 其中对返回值做了JSON和String两种解析，String是为了方便实用HandyJSON，不使用HandyJSON可以自行删除部分代码
