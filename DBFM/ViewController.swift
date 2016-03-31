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
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,HttpProtocol{

    @IBOutlet weak var playlist: UITableView!
    @IBOutlet weak var plate: MyUIImageView!
    @IBOutlet weak var bg: UIImageView!
    //定义网络操作类
    var eHttp:HTTPController = HTTPController()
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
        
        
        //单独使用alamofire获取数据
        Alamofire.request(.GET, "https://www.douban.com/j/app/radio/channels").responseJSON { (Response) in
            print("使用Alamofire获得的数据：\(Response)")
        }
        //使用自定义的类内嵌Alamofire获取数据
        eHttp.delegate = self
        eHttp.onSearch("https://www.douban.com/j/app/radio/channels")
        
        
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
        return 10
    }
    //表格内容
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //节约内存表格重用
        let cell = playlist.dequeueReusableCellWithIdentifier("CELL")! as UITableViewCell
        //设置cell的标题

        cell.textLabel?.text = "标题：\(indexPath.row)"
        cell.detailTextLabel?.text = "子标题\(indexPath.row)"
        //设置缩略图
        cell.imageView?.image = UIImage(named: "wangba")
        return cell
    }
    func didRecieveResult(results: AnyObject){
        print("使用HttpProtocol获得数据\(results)")
    }



}

