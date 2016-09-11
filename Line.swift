//
//  Line.swift
//  Tilt-a-Sketch
//
//  Created by Annie Ritch on 9/9/16.
//  Copyright © 2016 Johnny Capra. All rights reserved.
//

import UIKit

class Line {
    var start: CGPoint
    var end: CGPoint
    var color: UIColor
    
    init(start _start: CGPoint, end _end: CGPoint, color _color: UIColor!) {
        start = _start
        end = _end
        color = _color
    }
}