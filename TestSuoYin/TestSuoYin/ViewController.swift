//
//  ViewController.swift
//  TestSuoYin
//
//  Created by 徐镇东 on 2018/8/27.
//  Copyright © 2018年 徐强. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.sectionIndexColor = UIColor.brown;
        }
    }
    var mainArray:NSMutableArray!
    let sortArray = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    lazy var indexLabel:UILabel? = UILabel()
    var indexView:S4SIndexView?
    var centerLabel:UILabel!
    var currentTitle = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLocalData();
        self.initSelfIndexLabel();
        self.initCenterIndexLabel();
        
    }
    //初始化中央字母显示的label
    func initCenterIndexLabel() {
        self.centerLabel = UILabel.init(frame: CGRect.init(x: self.view.frame.width/2-40, y: self.view.frame.height/2-40, width: 80, height: 80))
        self.centerLabel.textColor = .brown
        self.centerLabel.font = UIFont.systemFont(ofSize: 25)
        self.centerLabel.textAlignment = .center
        self.centerLabel.alpha = 0.0
        self.view.addSubview(self.centerLabel)
    }
    //初始化自定义索引
    func initSelfIndexLabel(){
        self.indexView = S4SIndexView.init(frame: CGRect.init(x: self.view.frame.width-100, y: 80, width: 100, height: self.view.frame.height-100), data: self.sortArray)
        self.indexView?.click = {title in
            if title != self.currentTitle{
                self.currentTitle = title
                UIView.animate(withDuration: 0.5, animations: {
                    self.centerLabel.text = title
                    self.centerLabel.alpha = 0.7
                }, completion: { (compeletion) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.centerLabel.alpha = 0.0
                    })
                })
                self.tableView.scrollToRow(at: IndexPath.init(row: 0, section: self.sortArray.index(of: title)!), at: UITableViewScrollPosition.top, animated: true)
            }
            
        }
        self.view.addSubview(self.indexView!)
    }
    //初始化模拟数据
    func setLocalData()
    {
        self.mainArray = NSMutableArray()
        
        for charTmp in self.sortArray
        {
            let array = NSMutableArray()
            let number = arc4random() % 10 + 1
            for index in 1...number
            {
                let text = String(format: "%@-%ld", arguments: [charTmp, index])
                array.add(text)
            }
            
            let dict = NSMutableDictionary()
            dict.setObject(array, forKey: "sectionArray" as NSCopying)
            dict.setObject(charTmp, forKey: "sectionTitle" as NSCopying)
            self.mainArray.add(dict)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dict:NSDictionary! = self.mainArray.object(at: section) as! NSDictionary
        let array:NSArray! = dict.object(forKey: "sectionArray") as! NSArray
        
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        if cell == nil
        {
            cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")
        }
        
        let dict:NSDictionary! = self.mainArray.object(at: indexPath.section) as! NSDictionary
        let array:NSArray! = dict.object(forKey: "sectionArray") as! NSArray
        let text:String! = array.object(at: indexPath.row) as! String
        cell.textLabel!.text = text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section,indexPath.row)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mainArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let dict:NSDictionary! = self.mainArray.object(at: section) as! NSDictionary
        let text:String! = dict.object(forKey: "sectionTitle") as! String
        
        return text
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

