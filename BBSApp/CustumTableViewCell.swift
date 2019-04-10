//
//  CustumTableViewCell.swift
//  BBSApp
//
//  Created by 早坂甫 on 2019/04/07.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class CustumTableViewCell: UITableViewCell {

    var timeLabel:UILabel!
    var alarmNameLabel:UILabel!
    var weekLabel:UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        timeLabel = UILabel()
        alarmNameLabel = UILabel()
        weekLabel = UILabel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //let cellWidth:CGFloat = self.frame.width
        //let cellHeight:CGFloat = self.frame.height
        
        //timeLabel
        timeLabel.frame = CGRect(x: 100, y: 8, width: 200, height: 24)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 24)
        timeLabel.textColor = UIColor.gray
        timeLabel.textAlignment = NSTextAlignment.left
        self.addSubview(timeLabel)
        
        //timeLabel
        alarmNameLabel.frame = CGRect(x: 100, y: 36, width: 200, height: 18)
        alarmNameLabel.font = UIFont.systemFont(ofSize: 18)
        alarmNameLabel.textColor = UIColor.gray
        alarmNameLabel.textAlignment = NSTextAlignment.left
        self.addSubview(alarmNameLabel)
        
        
        //timeLabel
        weekLabel.frame = CGRect(x: 100, y: 56, width: 200, height: 18)
        weekLabel.font = UIFont.systemFont(ofSize: 18)
        weekLabel.textColor = UIColor.gray
        weekLabel.textAlignment = NSTextAlignment.left
        self.addSubview(weekLabel)
        
    }
}
