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
    var artistY = 0.0
    var lastSpot: CGPoint! //last location of the artist
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.canBecomeFirstResponder() //for shaking
        
        artistX = Double(canvas.center.x)
        artistY = Double(canvas.center.y)
        lastSpot = CGPoint(x: artistX, y: artistY)

        
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
                    self.artistY -= 4.0
                } else if xTilt > 0.03 {
                    self.artistY -= 2.0
                } else if xTilt < -0.08 {
                    self.artistY += 4.0
                } else if xTilt < -0.03 {
                    self.artistY += 2.0
                }
                
                if yTilt > 0.08 {
                    self.artistX += 4.0
                } else if yTilt > 0.03 {
                    self.artistX += 2.0
                } else if yTilt < -0.08 {
                    self.artistX -= 4.0
                } else if yTilt < -0.03 {
                    self.artistX -= 2.0
                }
                
                
                
                //End movement logic
                
                if self.artistX < 5 {
                    self.artistX = 5
                } else if self.artistX > Double(self.canvas.frame.maxX){
                    self.artistX = Double(self.canvas.frame.maxX)
                }
                
                //for some reason had to hardcode the bottom edge
                if self.artistY < 0 {
                    self.artistY = 0
                } else if self.artistY > Double(self.canvas.frame.maxY - 80) {
                    self.artistY = Double(self.canvas.frame.maxY - 80)
                }
                
                self.artist.center = CGPoint(x: self.artistX, y: self.artistY)
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
