//
//  Adventurer.swift
//  group14_assignment6
//
//  Created by Wong, Rebecca M on 10/21/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import Foundation
import UIKit

class Adventurer {
    
    var name: String
    var level: Int
    var profession: String
    var attackScore: Float
    var hpScore: Float
    var image: String
    
    init(name: String, level: Int, profession: String, attackScore: Float, hpScore: Float, image: String){
        
        self.name = name
        self.level = level
        self.profession = profession
        self.attackScore = attackScore
        self.hpScore = hpScore
        self.image = image
    }
}
