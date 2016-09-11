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
        
        artistX = Double(canvas.center.x)
        artistY = Double(canvas.center.y)
        
        motion.startAccelerometerUpdates()
        motion.accelerometerUpdateInterval = 0.03
        motion.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()){
            (data, error) in
            if let stable = self.motion.accelerometerData {
                let strStable = String(stable)
                let tilt = strStable.componentsSeparatedByString(" ")
                
                
                //Movement logic
                let yTilt = Double(tilt[1])
                let xTilt = Double(tilt[3])
                
                if xTilt > 0.08 {
                    self.artistY -= 8.0
                } else if xTilt > 0.03 {
                    self.artistY -= 4.0
                } else if xTilt < -0.08 {
                    self.artistY += 8.0
                } else if xTilt < -0.03 {
                    self.artistY += 4.0
                }
                
                if yTilt > 0.08 {
                    self.artistX += 8.0
                } else if yTilt > 0.03 {
                    self.artistX += 4.0
                } else if yTilt < -0.08 {
                    self.artistX -= 8.0
                } else if yTilt < -0.03 {
                    self.artistX -= 4.0
                }
                
                
                
                //End movement logic
                
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
            
            
                
            }
            
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
