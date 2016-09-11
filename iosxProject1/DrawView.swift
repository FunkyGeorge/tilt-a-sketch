//
//  DrawView.swift
//  Tilt-a-Sketch
//
//  Created by Annie Ritch on 9/9/16.
//  Copyright © 2016 Johnny Capra. All rights reserved.
//

import UIKit

class DrawView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    var lines: [Line] = []
    var lastPoint: CGPoint!
    var drawColor = UIColor.greenColor()

    required init?(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.blackColor()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent!) {
        if let touch = touches.first {
            lastPoint = touch.locationInView(self)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let newPoint = touch.locationInView(self)
            lines.append(Line(start: lastPoint, end: newPoint, color: drawColor))
            lastPoint = newPoint
        }
        
        self.setNeedsDisplay() //redraw the view
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineCap(context, .Round)
        CGContextSetLineWidth(context, 4)
        
        for line in lines {
            CGContextBeginPath(context)
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
            CGContextSetStrokeColorWithColor(context, line.color.CGColor)
            CGContextStrokePath(context) //stroke at the end
        }
    
    }
    
    
    

}
