//
//  ViewController.swift
//  FunFacts
//
//  Created by Collen Roller on 10/30/14.
//  Copyright (c) 2014 Collen Roller. All rights reserved.
//

import UIKit
import Darwin

class ViewController: UIViewController {
    
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var funFactButton: UIButton!
    @IBOutlet weak var didYouKnowLabel: UILabel!
    
    var factList = ListOfFacts()
    var colorWheel = ColorWheel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showFunFact() {
        if(factList.needsShuffle()){
            factList.shuffle()
        }
        var color : UIColor = colorWheel.getRandomColor()
        view.backgroundColor = color
        funFactButton.setTitleColor(color, forState: UIControlState.Normal)
        didYouKnowLabel.textColor = color
        funFactLabel.text = factList.getRandomFact()
    }
}

