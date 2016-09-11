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

//    @IBOutlet weak var drawView: DrawView!
    @IBOutlet weak var drawView: DrawView!
    
    let motion = CMMotionManager()
    
    @IBOutlet var canvas: UIView!
    
    
    @IBOutlet weak var artist: UILabel!
    var artistX = 0.0
    var artistXState = 0
    var artistY = 0.0
    var artistYState = 0
    var lastSpot: CGPoint! //last location of the artist
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canBecomeFirstResponder() //for shaking
        
//        print(self.canvas.frame.maxX)
//        print(self.canvas.frame.maxY)
        
        artistX = Double(canvas.center.x)
        artistY = Double(canvas.center.y)
        lastSpot = CGPoint(x: artistX, y: artistY)

        
        motion.startGyroUpdates()
        motion.gyroUpdateInterval = 0.05
        motion.startGyroUpdatesToQueue(NSOperationQueue.mainQueue()){
            (data, error) in
            if let tilt = self.motion.gyroData {
                var xResult = "none"
                var yResult = "none"
                
                //AJR: changed these to +/- 2.0 to make drawing less jumpy
                if self.artistXState == 1 {
                    self.artistY -= 2.0
                } else if self.artistXState == -1 {
                    self.artistY += 2.0
                }
                
                if self.artistYState == 1 {
                    self.artistX += 2.0
                } else if self.artistYState == -1 {
                    self.artistX -= 2.0
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
                
                //adjusted not to go outside top of drawView frame
                if self.artistY < Double(self.drawView.frame.minY) {
                    self.artistY = Double(self.drawView.frame.minY)
                    self.artistYState = 0
                } else if self.artistY > Double(self.canvas.frame.maxY){
                    self.artistY = Double(self.canvas.frame.maxY)
                    self.artistYState = 0
                }
                
                
                
                
                
                self.artist.center = CGPoint(x: self.artistX, y: self.artistY)
                print("x: " + xResult + "  y: " + yResult)
                self.artist.hidden = false //initially hidden
                
                //add a line!
                self.drawView.lines.append(Line(start: self.lastSpot, end: self.artist.center, color: self.drawView.drawColor))
                self.lastSpot = self.artist.center
                self.drawView.setNeedsDisplay()
                
            }
                    }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //for shaking
    override func canBecomeFirstResponder() -> Bool {
        super.canBecomeFirstResponder()
        return true
    }
    
    //for shaking
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            //clear out all lines, redraw view
            drawView.lines = []
            drawView.setNeedsDisplay()
        }
    }

    
    //clear out all the lines!
    @IBAction func clearPressed(sender: UIButton) {
        drawView.lines = []
        drawView.setNeedsDisplay()
    }
    
    @IBAction func colorPressed(sender: UIButton) {
        var color: UIColor!
        switch sender.tag {
            case 1:
                color = UIColor.redColor()
            case 2:
                color = UIColor.orangeColor()
            case 3:
                color = UIColor.yellowColor()
            case 4:
                color = UIColor.greenColor()
            case 5:
                color = UIColor.cyanColor()
            case 6:
                color = UIColor.blueColor()
            case 7:
                color = UIColor.purpleColor()
            default:
                color = UIColor.greenColor()
        }
        drawView.drawColor = color
    }
    

}
