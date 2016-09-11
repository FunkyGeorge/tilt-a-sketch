//
//  SecondViewController.swift
//  Tilt-a-Sketch
//
//  Created by User on 9/9/16.
//  Copyright © 2016 Johnny Capra. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var drawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("second view loaded and controller ready")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //clear out all the lines!
    @IBAction func clearPressed(sender: AnyObject) {
        drawView.lines = []
        drawView.setNeedsDisplay()
    }
    
    @IBAction func colorPressed(sender: UIButton) {
        var color: UIColor!
        if (sender.titleLabel!.text == "Red") {
            color = UIColor.redColor()
        }
        drawView.drawColor = color
    }
    

}
