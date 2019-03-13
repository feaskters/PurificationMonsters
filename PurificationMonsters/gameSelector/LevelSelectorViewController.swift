//
//  LevelSelectorViewController.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class LevelSelectorViewController: UIViewController,CheckpointButtonProtocol {

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var checkpointScrollView: UIScrollView!
    private var checkPointButtons : Array<CheckPointButton> = Array.init()
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
        if self.checkPointButtons.count != 0 {
            //刷新按钮状态
            for item in 0...self.checkPointButtons.count - 1{
                self.checkPointButtons[item].setConfig(title: String(item + 1),enable: (Checkpoints.shared().checkPointsArray[item] as! Dictionary<String, Any>)["enable"] as! Bool)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        if self.checkPointButtons.count <= 0 {
            let sc_width = UIScreen.main.bounds.width - 20
            let btn_width : CGFloat = 100 //按钮宽度
            let space : CGFloat = (sc_width - btn_width * 3) / 4 //按钮间距
            print(space)
            let count = Checkpoints.shared().checkPointsArray.count //按钮数量
            //设置scrollview的contentsize
            self.checkpointScrollView.contentSize = CGSize.init(width: self.checkpointScrollView.bounds.width , height: CGFloat((count + 2)/3 ) * (btn_width + space))
            //添加按钮
            for i in 0...count - 1  {
                //初始化按钮
                let x : CGFloat = CGFloat(i % 3) * (btn_width + space) + space
                let y : CGFloat = CGFloat(i / 3) * (btn_width + space) + space
                let checkpoint = CheckPointButton.init(frame: CGRect.init(x: x, y: y, width: btn_width, height: btn_width))
                //设置按钮代理
                checkpoint.delegate = self
                checkpoint.tag = i
                checkpoint.setConfig(title: String(i + 1), enable: (Checkpoints.shared().checkPointsArray[i] as! Dictionary<String, Any>)["enable"] as! Bool)
                self.checkpointScrollView.addSubview(checkpoint)
                self.checkPointButtons.append(checkpoint)
            }
        }
    }
    
    //实现按钮代理协议
    func CheckpointButtonClick(sender: CheckPointButton) {
        print("click")
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
