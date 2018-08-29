//
//  S4SIndexView.swift
//  TestSuoYin
//
//  Created by 徐镇东 on 2018/8/27.
//  Copyright © 2018年 徐强. All rights reserved.
//

import UIKit

class S4SIndexView: UIView {
    var dataArray:[String] = NSMutableArray.init() as! [String]
    var click:((String)->Void)?
    private var currentIndex = -2
    let width:CGFloat = 40.0
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = frame
    }
    
    init(frame:CGRect,data:[String]) {
        super.init(frame: frame)
        
        self.frame = frame;
        self.dataArray = data;
        self.initView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let height:CGFloat = self.frame.height / CGFloat( self.dataArray.count );
        let set:NSSet = event?.allTouches as! NSSet
        let touch :UITouch = set.anyObject() as! UITouch;
        let point :CGPoint = touch.location(in: self);
        var index = Int( point.y / height) < 0 ? 0 : Int( point.y / height)
        index = Int( point.y / height) == self.dataArray.count ? self.dataArray.count - 1 : Int( point.y / height)
        let title = self.dataArray[index]
        self.currentIndex = index;
        if (self.click != nil) {
            self.click!(title)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animationCancel()
        let height:CGFloat = self.frame.height / CGFloat( self.dataArray.count );
        let set:NSSet = event?.allTouches as! NSSet
        let touch :UITouch = set.anyObject() as! UITouch;
        let point :CGPoint = touch.location(in: self);
        var index = Int( point.y / height) < 0 ? 0 : Int( point.y / height)
        index = Int( point.y / height) == self.dataArray.count ? self.dataArray.count - 1 : Int( point.y / height)
        let title = self.dataArray[index]
        self.currentIndex = index ;
        if (self.click != nil) {
            self.click!(title)
            self.animation()
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.animationCancel()
    }
    func animationCancel(){
        UIView.animate(withDuration: 0.5, animations: {
            let height:CGFloat = self.frame.height / CGFloat( self.dataArray.count );
            for index in self.currentIndex - 2...self.currentIndex + 2 {
                if index >= 0 && index < self.dataArray.count {
                    let button = self.subviews[index] as! UIButton
                    button.frame = CGRect.init(x: self.frame.width - self.width, y: CGFloat(index) * height, width: self.width, height: height)
                }
            }
        })
    }
    func animation(){
        UIView.animate(withDuration: 0.5, animations: {
            let height:CGFloat = self.frame.height / CGFloat( self.dataArray.count );
            
            for index in self.currentIndex - 2...self.currentIndex + 2 {
                if index >= 0 && index < self.dataArray.count {
                    let button = self.subviews[index] as! UIButton
                    button.frame = CGRect.init(x:CGFloat( abs(index - self.currentIndex)) * (self.frame.width - self.width)/3.0, y: CGFloat(index) * height, width: self.width , height: height)
                }
            }
        })
    }
    func initView() {
        let height:CGFloat = self.frame.height / CGFloat( self.dataArray.count );
        for (index,item) in self.dataArray.enumerated() {
            let button:UIButton = UIButton.init()
            button.frame = CGRect.init(x: self.frame.width-width, y: CGFloat(index) * height, width: width, height: height)
            button.backgroundColor = UIColor.clear
            button.setTitle(item, for: .normal);
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.setTitleColor(UIColor.brown, for: .normal)
            self.backgroundColor = UIColor.clear
            self.addSubview(button)
        }
    }
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return self
    }
    

}
