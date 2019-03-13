//
//  LevelSelectorViewController.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class LevelSelectorViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //初始不可见
        self.containerView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //动画淡入
        UIView.animate(withDuration: 0.5) {
            self.containerView.alpha = 1
        }
    }

    @IBAction func back(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        //退出动画
        UIView.animate(withDuration: 1, animations: {
            self.containerView.alpha = 0
            let trans = CGAffineTransform.init(scaleX: 0.0001, y: 0.0001)
            let trans2 = CGAffineTransform.init(rotationAngle: -2.5)
            let t = trans.concatenating(trans2)
            self.containerView.transform = t
        }) { (Bool) in
            self.dismiss(animated: false, completion: nil)
        }
    }


}
