//
//  ShortestKnightViewController.swift
//  Algorithms
//
//  Created by pvharsha on 7/7/19.
//  Copyright © 2019 SPH. All rights reserved.
//

import UIKit

class ShortestKnightVC: UIViewController {
    
    @IBOutlet var xCordinateTextField:UITextField?
    @IBOutlet var yCordinateTextField:UITextField?
    @IBOutlet var answerLabel:UILabel?
    @IBOutlet var traverseDetailBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for x:Int64 in 0 ... 7 {
            var resultString:String = ""
            for y:Int64 in 0 ... 7 {
                resultString = resultString + " " + String(ShortestKnightAlgorithm().getShortestPath_minimumSteps(x: x, y: y))
            }
            print(resultString)
            resultString = ""
        }
    }
    
    @IBAction func calculateResult() {
        let x:Int64 = Int64(xCordinateTextField!.text!) ?? 0
        let y:Int64 = Int64(yCordinateTextField!.text!) ?? 0
        let minimumSteps = ShortestKnightAlgorithm().getShortestPath_minimumSteps(x: x, y: y)
        self.answerLabel?.text = "Minimum steps needed by a knight to traverse from (0,0) to (" + String(x) + "," + String(y) + ") is " + String(minimumSteps)
        
        if (minimumSteps) > 0 {
            self.traverseDetailBtn?.isHidden = false
        } else {
            self.traverseDetailBtn?.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShortestKnightPathVC" {
            let vc:ShortestKnightPathVC = segue.destination as! ShortestKnightPathVC
            vc.destinationPoint = (Int64(xCordinateTextField!.text!) ?? 0, Int64(yCordinateTextField!.text!) ?? 0)
        }
    }
}
