//
//  ViewController.swift
//  Simple Calorie Counter
//
//  Created by Arthur Shir on 12/8/15.
//  Copyright © 2015 Fantaandcrackers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var calorieCountLabel: UILabel!
    @IBOutlet var clearButton: UIButton!
    @IBOutlet var addButtons: [UIButton]!
    var pastCounts = [NSInteger]()
    
    
    func getSavedCalories()-> NSInteger{
        let defaults = NSUserDefaults.standardUserDefaults()
        let cal = defaults.integerForKey("savedCalories")
        return cal
    }
    
    func setSavedCalories(cal: NSInteger) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(cal, forKey: "savedCalories")
        updateCountLabel()
        
    }

    func updateCountLabel() {
        UIView.transitionWithView(calorieCountLabel, duration: 0.2, options: .TransitionFlipFromBottom, animations: { () -> Void in
                self.calorieCountLabel.text = "\(self.getSavedCalories()) Calories"
            }, completion: nil)
    }
    
    @IBAction func touchClearButton(sender: AnyObject) {
        if pastCounts.last != 0 {
            pastCounts.append(getSavedCalories())
        }
        setSavedCalories(0)
    }
    
    @IBAction func touchUndo(sender: AnyObject) {
        if let last = pastCounts.last {
            setSavedCalories(last)
            pastCounts.removeLast()
        }
    }
    
    
    func addButtonTouched(sender: AnyObject) {
        pastCounts.append(getSavedCalories())
        setSavedCalories(getSavedCalories() + sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calorieCountLabel.text = "\(getSavedCalories()) Calories"
        for button in addButtons {
            button.addTarget(self, action: Selector("addButtonTouched:"), forControlEvents: UIControlEvents.TouchUpInside)
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        }
    }


}

