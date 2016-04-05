import UIKit
import Alamofire
//import Alamofire 网络操作类库


//定义一个类 叫HTTPController继承NSObject
class HTTPController:NSObject{
    //定义一个代理,遵循HttpProtocol---说明HTTPController是代理的发布者
    var delegate:HttpProtocol?
    //定义OnSearch方法接收网址，回调代理的方法传回数据
    func onSearch(url:String){
        Alamofire.request(.GET, url).responseJSON(queue: nil, options: NSJSONReadingOptions.MutableContainers) {Response in
            self.delegate?.didRecieveResult(Response.result.value!)
        }
        
        
    }
}
//定义http协议  遵循改协议的对象或类都要有个 didRecieveResult方法接受结果
protocol  HttpProtocol{
//    //定义一个方法，接受一个参数：AnyObject
   func didRecieveResult(results:AnyObject)
    
}

//回到ViewController.swift文件