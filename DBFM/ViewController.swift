//
//  ViewController.swift
//  DBFM
//
//  Created by Justine on 16/3/29.
//  Copyright © 2016年 hxb. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HttpProtocol{

    @IBOutlet weak var playlist: UITableView!
    @IBOutlet weak var plate: MyUIImageView!
    @IBOutlet weak var bg: UIImageView!
    //定义网络操作类
    var eHttp:HTTPController = HTTPController()
    //用于接收频道数据和歌曲数据
    var tablesonglistData:[JSON] = []
    var tablechannellistData:[JSON]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plate.onRoatation()
        //设置 tableview 的数据源和代理为 当前视图
        playlist.delegate = self
        playlist.dataSource = self
        //设置模糊效果
        let  blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let  blurview = UIVisualEffectView(effect: blurEffect)
        blurview.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        bg.addSubview(blurview)
        // Do any additional setup after loading the view, typically from a nib.
        
        
//       //单独使用alamofire获取数据
//        Alamofire.request(.GET, "https://www.douban.com/j/app/radio/channels").responseJSON { (Response) in
//            print("使用Alamofire获得的数据：\(Response)")
//        }
        //使用自定义的类内嵌Alamofire获取数据
        eHttp.delegate = self
        //获取频道数据
        eHttp.onSearch("http://www.douban.com/j/app/radio/channels")
        //获取频道为-10歌曲数据
        eHttp.onSearch("http://douban.fm/j/mine/playlist?type=n&sid=&pt=0.0&channel=-10&from=mainsite")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //表格列数（区块）
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //表格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablesonglistData.count
    }
    //表格内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //节约内存表格重用
        let cell = playlist.dequeueReusableCellWithIdentifier("CELL")! as UITableViewCell
        
        //获取cell的数据
        let rowData:JSON = tablesonglistData[indexPath.row]
        
        
        //设置cell的标题
        cell.textLabel?.text = rowData["title"].string
        //设置cell的子标题
        cell.detailTextLabel?.text = rowData["singers.name"].string
        //设置封面网址
        let url = rowData["picture"].string
        
        //设置缩略图,使用Alamofire获取
        Alamofire.request(.GET,url!).responseData { (result) in
            let img = UIImage(data: result.result.value!)
            print("使用Alamofire:\(result.result.value)")
            cell.imageView?.image = img
        }
        //cell.imageView?.image = UIImage(named: "wangba")
        
        return cell
    }
    func didRecieveResult(results: AnyObject){
        print("使用HttpProtocol获得数据\(results)")
        //将获取到的数据进行判断类型
        let json = JSON.init(arrayLiteral: results)
        
        //判断是否是频道数据
        if let channels = json["channels"].array {
            self.tablechannellistData = channels
        }//歌曲数据
        else if let song = json["song"].array{
            self.tablesonglistData = song
        }
        //获取数据后更新tableview里的数据
        self.playlist.reloadData()
        
    }



}

