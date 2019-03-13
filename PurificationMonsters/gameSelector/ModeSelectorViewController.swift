//
//  ModeSelectorViewController.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class ModeSelectorViewController: UIViewController {

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
            self.containerView.transform = CGAffineTransform.init(rotationAngle: 2.5)
        }) { (Bool) in
            
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    /*
     sender.tag == 0 -> normal
     sender.tag == 1 -> Random
     sender.tag == 2 -> Level
     */
    @IBAction func selectMode(_ sender: UIButton) {
        Music.shared().musicPlayEffective()
        switch sender.tag {
        case 0:
            break
        case 1:
            break
        case 2:
            break
        default:
            break
        }
        //退出动画
        UIView.animate(withDuration: 1, animations: {
            self.containerView.alpha = 0
            self.containerView.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        }) { (Bool) in
            
        }
        
    }

}
