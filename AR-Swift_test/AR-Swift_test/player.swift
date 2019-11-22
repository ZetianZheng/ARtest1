//
//  player.swift
//  AR-Swift_test
//
//  Created by Jiaxin Yan on 11/20/19.
//  Copyright © 2019 niexiaobo. All rights reserved.
//

import Foundation
import UIKit

class Player: NSObject {
 var name: String
 var game: String
 var rating: Int

init(name: String, game: String, rating: Int) {
self.name = name
self.game = game
self.rating = rating
super.init()
 }
}
