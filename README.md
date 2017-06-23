# Swift_HttpRequest
### 1.1 新增链式请求的封装
* 链式请求可以只组合需要的函数，本身默认为常用方式，简化常用的链式调用
* 对于非默认值的请求可以自定义进行设置
* 方便添加自定义行为，利于扩展
----------
### 1.0 类OC中的AFN封装
* 利于OC转swift的同学学习
* 其中对返回值做了JSON和String两种解析，String是为了方便实用HandyJSON，不使用HandyJSON可以自行删除部分代码

---------------------
### 使用到的三方库介绍

Swift中常用的网络请求库当属[Alamofire](https://github.com/Alamofire/Alamofire)，GitHub上也有对Alamofire的封装，比较有名的就是Moya了。
但是我个人习惯了在OC中的封装，所以还是把Alamofire当作AFN来用了。



[HandyJSON](https://github.com/alibaba/HandyJSON) 是阿里巴巴开源的model的映射库。

比[ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)好的在于：
* HandyJSON不需要自己写映射，
* 不需要继承自NSObject，可以使用Struct来建model

我在OC最喜欢的就是MJExtention了，所以swift中你肯定会爱上HandyJSON的
具体可以看[在Swift语言中处理JSON - 转换JSON和Model](http://www.cocoachina.com/swift/20161010/17711.html)



Demo中对HandyJSON的使用没有做详细的介绍
希望能达到抛砖引玉的效果

也给新学习swift的朋友一个简单的网络处理的方式

欢迎大家知道，互相学习
