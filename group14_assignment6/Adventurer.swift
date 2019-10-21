//
//  Adventurer.swift
//  group14_assignment6
//
//  Created by Arriaga, Miguel A on 10/16/19.
//  Copyright © 2019 Arriaga, Miguel A. All rights reserved.
//

import Foundation

class Adventurer {
    var name,_class : String
    var attack : Float
    var currentHP, totalHP : Int
    var HP : String
    
    init(name : String, _class : String, attack : Float) {
        self.name = name
        self._class = _class
        self.attack = attack
        self.currentHP = 0
        self.totalHP = 0
        self.HP = "\(currentHP)/\(totalHP)"
    }
}
