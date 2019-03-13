//
//  GameViewController.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameView: UIView!
    /*
     tag == 0 -> normal
     tag == 1 -> random
     tag == 2 -> level
     */
    private var tag = 0;
    private var characterArray : Array<Array<Int>> = Array<Array<Int>>.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        switch self.tag {
        case 0:
            tag0()
            break
        case 1:
            tag1()
            break
        case 2:
            tag2()
            break
        default:
            break
        }
    }

    //处理tag0
    func tag0() {
        let scSquare :CGFloat = 400
        let characterSquare : CGFloat = 70
        let space : CGFloat = (scSquare - characterSquare * 5) / 6
        for i in 0...4 {
            self.characterArray.append([])
            for j in 0...4{
                let x = space + CGFloat(j) * (characterSquare + space)
                let y = space + CGFloat(i) * (characterSquare + space)
                let cv = CharacterView.init(frame: CGRect.init(x: x, y: y, width: characterSquare, height: characterSquare))
                cv.setType(type: 0)
                self.gameView.addSubview(cv)
                self.characterArray[i].append(0)
            }
        }
    }
    
    //处理tag1
    func tag1() {
        
    }
    
    //处理tag2
    func tag2() {
        
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
}
