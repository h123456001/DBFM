import UIKit
import Alamofire
//import Alamofire
class HTTPController:NSObject{
    //定义一个代理
    var delegate:HttpProtocol?
    //接收网址，回调代理的方法传回数据
    
    func onSearch(url:String){
        Alamofire.request(.GET, url).responseJSON(queue: nil, options: NSJSONReadingOptions.MutableContainers) {Response in
            self.delegate?.didRecieveResult(Response.result.value!)
        }
        
        
    }
}
//定义http协议
protocol  HttpProtocol{
//    //定义一个方法，接受一个参数：AnyObject
   func didRecieveResult(results:AnyObject)
    
}