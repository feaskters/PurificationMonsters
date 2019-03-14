//
//  GameViewController.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameViewController: UIViewController,CharacterProtocol,GameOverProtocol {

    @IBOutlet weak var clickCount: UILabel!
    @IBOutlet weak var timeCount: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameView: UIView!
    /*
     tag == 0 -> normal
     tag == 1 -> random
     tag == 2 -> level
     */
    private var tag = 0;
    private var level = 1;
    private var characterArray : Array<Array<CharacterView>> = Array<Array<CharacterView>>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tag(tag: self.tag)
        
        //开始计时
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (Timer) in
            self.timeCount.text = String(Int(self.timeCount.text!)! + 1)
        }
    }
    
    //处理tag
    func tag(tag:Int) {
        let scSquare :CGFloat = 400
        let characterSquare : CGFloat = 70
        let space : CGFloat = (scSquare - characterSquare * 5) / 6
        for i in 0...4 {
            self.characterArray.append([])
            for j in 0...4{
                let x = space + CGFloat(j) * (characterSquare + space)
                let y = space + CGFloat(i) * (characterSquare + space)
                let cv = CharacterView.init(frame: CGRect.init(x: x, y: y, width: characterSquare, height: characterSquare))
                //获取type
                var type = 0
                switch tag{
                case 0:
                    type = tag0()
                    break
                case 1:
                    type = tag1()
                    break
                case 2:
                    type = tag2(x:i,y:j)
                    break
                default:
                    break
                }
                self.gameView.addSubview(cv)
                cv.setType(type: type)
                cv.setPosition(x: i, y: j)
                cv.delegate = self
                self.characterArray[i].append(cv)
                }
            }
        }

    //处理tag0
    func tag0() -> Int{
        return 0
    }
    
    //处理tag1
    func tag1() -> Int{
        return Int(arc4random() % 2)
    }
    
    //处理tag2
    func tag2(x:Int,y:Int)  -> Int{
        let array = Checkpoints.shared().checkPointsArray[self.level] as! Dictionary<String,Any>
        return (array["blocks"]! as! Array<Array<Int>>)[y][x]
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
    
    func setTag(tag:Int) {
        self.tag = tag
    }
    func setLevel(level:Int ) {
        self.level = level
    }
    
    //代理方法，按钮点击事件
    func characterClick(sender:CharacterView) {
        
        //点击次数增加
        self.clickCount.text = String(Int(self.clickCount.text!)! + 1)
        
        let position = sender.getPosition()
        //左边翻转
        if position["x"]! > 0 {
            self.characterArray[position["x"]! - 1][position["y"]!].reverseType()
        }
        //右边翻转
        if position["x"]! < 4 {
            self.characterArray[position["x"]! + 1][position["y"]!].reverseType()
        }
        //下边翻转
        if position["y"]! < 4 {
            self.characterArray[position["x"]!][position["y"]! + 1].reverseType()
        }
        //上边翻转
        if position["y"]! > 0 {
            self.characterArray[position["x"]!][position["y"]! - 1].reverseType()
        }
        judgeEnd()
    }
    
    //判断结束
    func judgeEnd() {
        var flag = true //是否有无怪标致
        for items in self.characterArray{
            for item in items{
                if item.getType() == 0{
                    flag = false
                }
            }
        }
        if flag {
            self.gameOver()
            if self.tag == 2{
                Checkpoints.shared().success(withLevel: Int32(self.level + 1))
            }
        }
    }
    
    //弹出结算页面
    func gameOver() {
        let gov = GameOverView.init(frame: CGRect.init(x: 0, y: -300, width: self.containerView.frame.width, height: 300))
        let result = ["click" : self.clickCount.text!,
                      "time" : self.timeCount.text!]
        gov.setResult(result: result)
        gov.delegate = self
        self.view.addSubview(gov)
        UIView.animate(withDuration: 0.2) {
            gov.frame = CGRect.init(x: 0, y: UIScreen.main.bounds.height / 2 - 150, width: self.containerView.frame.width, height: 300)
        }
    }
    
    //代理方法，游戏结束点击事件
    func gameOverViewTouchsBegan(sender:GameOverView) {
        self.back(UIButton.init())
        UIView.animate(withDuration: 0.2) {
            sender.frame = CGRect.init(x: 0, y: -300, width: self.containerView.frame.width, height: 300)
        }
    }
}
