//
//  ColorWheel.swift
//  FunFacts
//
//  Created by Collen Roller on 11/3/14.
//  Copyright (c) 2014 Collen Roller. All rights reserved.
//

import Foundation
import UIKit

struct ColorWheel {
    
    let colorsArray = [
        UIColor(red: 90/225.0, green: 187/255.0, blue: 181/255.0,
            alpha:1.0), //teal color
        UIColor(red: 222/225.0, green: 171/255.0, blue: 66/255.0,
            alpha:1.0), //yellow color
        UIColor(red: 223/225.0, green: 86/255.0, blue: 94/255.0,
            alpha:1.0), //red color
        UIColor(red: 239/225.0, green: 130/255.0, blue: 100/255.0,
            alpha:1.0), //orange color
        UIColor(red: 77/225.0, green: 75/255.0, blue: 82/255.0,
            alpha:1.0), //dark color
        UIColor(red: 105/225.0, green: 94/255.0, blue: 133/255.0,
            alpha:1.0), //purple color
        UIColor(red: 85/225.0, green: 176/255.0, blue: 112/255.0,
            alpha:1.0), //green color
    ]

    func getRandomColor() -> UIColor {
        var randomArrayCount = UInt32(colorsArray.count)
        var randomNumber = arc4random_uniform(randomArrayCount)
        var r = Int(randomNumber)
        return colorsArray[r]
    }
    
}
