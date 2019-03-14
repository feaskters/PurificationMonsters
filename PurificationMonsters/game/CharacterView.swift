//
//  CharacterView.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

protocol CharacterProtocol {
    func characterClick(sender:CharacterView);
}

class CharacterView: UIView {
    
    //type == 0 -> monster
    //type == 1 -> animal
    private var type : Int = 0
    private var position : Dictionary<String,Int>?
    var delegate : CharacterProtocol?

    lazy var monsterImageSet : Array<UIImage> = {
        var array = Array<UIImage>.init()
        for i in 1...4{
            let image = UIImage.init(named: "骷髅" + String(i))
            array.append(image!)
        }
        return array
    }()
    
    lazy var animalImageSet : Array<UIImage> = {
        var array = Array<UIImage>.init()
        for i in 1...4{
            let image = UIImage.init(named: "鹿" + String(i))
            array.append(image!)
        }
        return array
    }()
    
    lazy var magicImageSet : Array<UIImage> = {
        var array = Array<UIImage>.init()
        for i in 1...15{
            let image = UIImage.init(named: "magic" + String(i))
            array.append(image!)
        }
        return array
    }()
    
    lazy var damageImageSet : Array<UIImage> = {
        var array = Array<UIImage>.init()
        for i in 1...17{
            let image = UIImage.init(named: "damage" + String(i))
            array.append(image!)
        }
        return array
    }()
    
    private let background = UIImageView.init(image: UIImage.init(named: "characterBackground"))
    
    lazy var imageView : UIImageView = {
        let view = UIImageView.init()
        view.frame = CGRect.init(x: 10, y: 10, width: 45, height: 45)
        view.animationDuration = 0.5
        return view
    }()
    
    lazy var effectiveView : UIImageView = {
        let view = UIImageView.init()
        view.frame = CGRect.init(x: 10, y: 10, width: 45, height: 45)
        view.animationDuration = 0.5
        view.animationRepeatCount = 1
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.background.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(background)
        self.addSubview(self.imageView)
        self.addSubview(self.effectiveView)
    }

    //更新图片状态
    func updateImage() {
        if self.type == 0 {
            self.imageView.animationImages = self.monsterImageSet
        }else{
            self.imageView.animationImages = self.animalImageSet
        }
        self.imageView.startAnimating()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.reverseType()
        Music.shared().musicPlayMergeEffective()
        //代理方法
        delegate?.characterClick(sender: self)
    }
    
    //设置类型
    func setType(type:Int){
        self.type = type
        updateImage()
    }
    
    //获取类型
    func getType() -> Int{
        return self.type
    }
    
    //翻转类型
    func reverseType() {
        if self.type == 0 {
            self.effectiveView.animationImages = self.magicImageSet
            self.effectiveView.startAnimating()
            setType(type: 1)
        }else{
            self.effectiveView.animationImages = self.damageImageSet
            self.effectiveView.startAnimating()
            setType(type: 0)
        }
    }
    
    //设置位置
    func setPosition(x:Int,y:Int) {
        let dic : Dictionary<String,Int> = ["x" : x,
                                            "y" : y]
        self.position = dic
    }
    
    //获取位置
    func getPosition() -> Dictionary<String,Int> {
        return self.position!
    }
}
