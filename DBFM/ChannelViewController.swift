//
//  ChannelViewController.swift
//  DBFM
//
//  Created by Justine on 16/3/29.
//  Copyright © 2016年 hxb. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    @IBOutlet weak var ChannelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
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
        let channelcell = ChannelView.dequeueReusableCellWithIdentifier("channelcell")! as UITableViewCell
        //设置cell的标题
        
        channelcell.textLabel?.text = "标题：\(indexPath.row)"
        return channelcell
    }


}
