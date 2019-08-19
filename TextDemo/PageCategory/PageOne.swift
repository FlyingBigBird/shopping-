//
//  PageOne.swift
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/6/12.
//  Copyright © 2019 BaoBao. All rights reserved.
//

import UIKit


class PageOne: UIView, UITableViewDataSource,UITableViewDelegate {
    
    @objc var pageTab : UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        doInitUi()
    }
    func doInitUi() -> () {
        
        pageTab = UITableView.init(frame: self.bounds)
        self .addSubview(pageTab )
        pageTab.backgroundColor = UIColor.lightGray
        pageTab.dataSource = self
        pageTab.delegate = self
        pageTab.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        pageTab.tableFooterView  = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell : UITableViewCell = UITableViewCell.init()
        cell.contentView.backgroundColor = UIColor.white
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
