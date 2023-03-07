//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
//Enhancements
//1.    Wes Well Done Egg? if well done, double the times that the eggs will cook.
//2. If switch is on than another if else statement generates a dancing bacond array activiated by a button.If the swithc is off, a message of the label says the bacon doesnt dance for you

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var isWellDone: UISwitch!
    @IBOutlet weak var baconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isWellDone.isOn = false
    }
    
    
    //Will have to make this var for your if welldone egg switch button
    var eggTimes = ["Soft": 4, "Medium": 7, "Hard": 10]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!

   
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
//------------------------Is Well Done or Not-----------------//
        if isWellDone.isOn
        {
            eggTimes = ["Soft": 8, "Medium": 14, "Hard": 20]
        }
        else
        {
            eggTimes = ["Soft": 4, "Medium": 7, "Hard": 10]
        }

        
        timer.invalidate()
        let hardness = sender.currentTitle! //Soft, Medium, Hard
       totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
        
    }
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
           
            
            
        } else{
            timer.invalidate()
            titleLabel.text = "DONE!"
           
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
    
    //-------------------Bacon Arary if the is welldone-------/
    @IBAction func gotBacon(_ sender: Any) {
        if isWellDone.isOn {
            let baconArray = [#imageLiteral(resourceName: "BaconLeftSlash"), #imageLiteral(resourceName: "BaconRightSlash")]
            baconImage.animationImages = baconArray
            baconImage.animationDuration = 2.0
            baconImage.animationRepeatCount = 4
            baconImage.startAnimating()
        } else{
            titleLabel.text = "The Bacon Does not dance for you!!"
        }
        }
            
        
            
            
    }
    
    
    

