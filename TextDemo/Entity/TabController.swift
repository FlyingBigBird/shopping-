//
//  TabController.swift
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/30.
//  Copyright © 2019 BaoBao. All rights reserved.
//

import UIKit

class TabController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        
        super .viewWillAppear(true)
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = false
        self.title = "swift-bridge"
        self.tabBarController?.tabBar.isHidden = true
        let attrisDic : [NSObject : NSObject] = [NSAttributedString.Key.foregroundColor as NSObject :UIColor .red] 
        self.navigationController?.navigationBar.titleTextAttributes = attrisDic as? [NSAttributedString.Key : Any]
        
        let scaleV : UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        scaleV.center = self.view.center
        scaleV.layer.masksToBounds = true
        scaleV.layer.cornerRadius = 10
        self.view .addSubview(scaleV)
        scaleV.backgroundColor = UIColor.red
        scaleV.isHidden = true
        
        UIView.transition(with: scaleV, duration: 1, options: .transitionCrossDissolve, animations: {
            
            scaleV.isHidden = false
            scaleV.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
            scaleV.center = self.view.center
        }) { (true) in
            
            scaleV.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
            scaleV.center = self.view.center
        }
        
    }
    
}
