//
//  SecondViewController.swift
//  Tilt-a-Sketch
//
//  Created by User on 9/9/16.
//  Copyright © 2016 Johnny Capra. All rights reserved.
//

import UIKit
import CoreMotion

class SecondViewController: UIViewController {

    let motion = CMMotionManager()
    
    @IBOutlet var canvas: UIView!
    
    
    
    @IBOutlet weak var artist: UILabel!
    var artistX = 0.0
    var artistXState = 0
    var artistY = 0.0
    var artistYState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.canvas.frame.maxX)
        print(self.canvas.frame.maxY)
        
        artistX = Double(canvas.center.x)
        artistY = Double(canvas.center.y)
        
        motion.startGyroUpdates()
        motion.gyroUpdateInterval = 0.05
        motion.startGyroUpdatesToQueue(NSOperationQueue.mainQueue()){
            (data, error) in
            if let tilt = self.motion.gyroData {
                var xResult = "none"
                var yResult = "none"
                
                if self.artistXState == 1 {
                    self.artistY -= 10.0
                } else if self.artistXState == -1 {
                    self.artistY += 10.0
                }
                
                if self.artistYState == 1 {
                    self.artistX += 10.0
                } else if self.artistYState == -1 {
                    self.artistX -= 10.0
                }
                
                let strTilt = String(tilt)
                let tipData = strTilt.componentsSeparatedByString(" ")
                let xTilt = tipData[1]
                let yTilt = tipData[3]
                
                if (Float(xTilt) > 12.0){
                    if self.artistXState == 1 {
                        self.artistXState = 0
                    } else {
                        self.artistXState = -1
                    }
                    xResult = "up"
                } else if (Float(xTilt) < -12.0){
                    if self.artistXState == -1 {
                        self.artistXState = 0
                    } else {
                        self.artistXState = 1
                    }
                    xResult = "down"
                }
                
                if (Float(yTilt) > 12.0){
                    if self.artistYState == -1 {
                        self.artistYState = 0
                    } else {
                        self.artistYState = 1
                    }
                    yResult = "right"
                } else if (Float(yTilt) < -12.0){
                    if self.artistYState == 1 {
                        self.artistYState = 0
                    } else {
                        self.artistYState = -1
                    }
                    yResult = "left"
                }
                
                
                if self.artistX < 0 {
                    self.artistX = 0
                    self.artistXState = 0
                } else if self.artistX > Double(self.canvas.frame.maxX){
                    self.artistX = Double(self.canvas.frame.maxX)
                    self.artistXState = 0
                }
                
                if self.artistY < 0 {
                    self.artistY = 0
                    self.artistYState = 0
                } else if self.artistY > Double(self.canvas.frame.maxY){
                    self.artistY = Double(self.canvas.frame.maxY)
                    self.artistYState = 0
                }
                
                
                
                
                
                self.artist.center = CGPoint(x: self.artistX, y: self.artistY)
                print("x: " + xResult + "  y: " + yResult)
                
            }
                    }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
