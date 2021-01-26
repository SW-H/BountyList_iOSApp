//
//  BountyInfo.swift
//  BountyListApp
//
//  Created by 한승원 on 2021/01/26.
//

import UIKit

struct BountyInfo{
    let name : String
    let bounty : Int
    var image : UIImage? {
        return UIImage(named:"\(name).jpg")
    }
    
    init(name:String, bounty:Int){
        self.name = name
        self.bounty = bounty
    }
}
