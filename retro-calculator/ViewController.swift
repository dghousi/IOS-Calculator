//
//  ViewController.swift
//  retro-calculator
//
//  Created by NETLINKS on 6/13/16.
//  Copyright © 2016 netlinks. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
        
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftStr = ""
    var rightStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        onSoundLoad();
        
    }
    
    @IBAction func numberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDevidePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightStr = runningNumber
                runningNumber = ""
                switch currentOperation {
                case Operation.Multiply:
                    result = "\(Double(leftStr)! * Double(rightStr)!)"
                    break
                case Operation.Divide:
                    result = "\(Double(leftStr)! / Double(rightStr)!)"
                    break
                case Operation.Subtract:
                    result = "\(Double(leftStr)! - Double(rightStr)!)"
                    break
                case Operation.Add:
                    result = "\(Double(leftStr)! + Double(rightStr)!)"
                    break
                default:
                    result = ""
                }
                
                leftStr = result
                outputLbl.text = result
            }
            
            currentOperation = op
        } else {
            leftStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func onSoundLoad(){
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
            
        }catch let err as NSError {
            print(err.debugDescription)
        }
    }
}

