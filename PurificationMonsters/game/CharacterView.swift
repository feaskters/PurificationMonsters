//
//  CharacterView.swift
//  PurificationMonsters
//
//  Created by iOS123 on 2019/3/13.
//  Copyright © 2019年 iOS123. All rights reserved.
//

import UIKit

class CharacterView: UIView {
    
    //type == 0 -> monster
    //type == 1 -> animal
    private var type : Int = 0

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
    
    private let background = UIImageView.init(image: UIImage.init(named: "characterBackground"))
    
    lazy var imageView : UIImageView = {
        let view = UIImageView.init()
        view.frame = CGRect.init(x: 10, y: 10, width: 45, height: 45)
        view.animationDuration = 0.5
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.background.frame = CGRect.init(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.addSubview(background)
        updateImage()
        self.addSubview(self.imageView)
    }

    //更新图片状态
    func updateImage() {
        if self.tag == 0 {
            self.imageView.animationImages = self.monsterImageSet
        }else{
            self.imageView.animationImages = self.animalImageSet
        }
        self.imageView.startAnimating()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    //设置类型
    func setType(type:Int){
        self.type = type
        updateImage()
    }
    
    //翻转类型
    func reverseType() {
        if self.tag == 0 {
            setType(type: 1)
        }else{
            setType(type: 0)
        }
    }
}
