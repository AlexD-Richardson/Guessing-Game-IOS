//
//  ViewController.swift
//  Guessing Game
//
//  Created by Alex Richardson on 9/24/18.
//  Copyright © 2018 Alex Richardson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var time = Timer()
    
    var colorArray = [UIColor.red, .blue, .green, .yellow, .orange, .magenta, .purple]
    
    var newGame = false

    @IBOutlet weak var GuessLabel: UILabel!

    @IBOutlet weak var UserGuess: UITextField!
    
    @IBOutlet weak var SendGuess: UIButton!
    
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    @IBOutlet weak var NumOfTries: UILabel!
    
    @IBOutlet weak var Reset: UIButton!

    @IBOutlet weak var WinLabel: UILabel!

    @IBOutlet weak var RecordLabel: UILabel!
    
    var counter = 5
    
    var playerWins = 0
    
    var playerLosses = 0
    
    var maxNumber: Int!
    
    var randomNumber: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        GuessLabel.text = "Guess a number between 1 and \(maxNumber!) You will only get 5 tries. Good luck!"
        
        NumOfTries.text = "Attempts left: \(counter)"
        
        ProgressBar.progress = 0
        
        RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
        
        Reset.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        if let max = maxNumber {
            randomNumber = Int.random(in: 1..<max)
        } else {
            randomNumber = Int(arc4random_uniform(100)) + 1
        }
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        
        
        let userGuesses = Int(UserGuess.text!)
        
        guard userGuesses != nil else { return WinLabel.text = "Please enter in a number!"}
        
        if userGuesses! == 420 {
            
            WinLabel.text = "Blaze it bro! The random number is \(randomNumber!)"
            
    } else if userGuesses! > maxNumber! || userGuesses! < 1 {
            
            WinLabel.text = "Please enter in a number between 1 and 100"
            
        } else if userGuesses! == randomNumber {
            
            newGame = true
            
            time = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(winnerBackground), userInfo: nil, repeats: true)
            
            
            time.fire()

           WinLabel.text = "Congrats you won! Please tap the restart button if you want to play again."
            
            playerWins += 1
            
            RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
            
            UserGuess.isHidden = true
            
            SendGuess.isHidden = true
            
            Reset.isHidden = false
            
            self.view.backgroundColor = UIColor.green
            
            
            
        } else if userGuesses! > randomNumber {
            
            ProgressBar.progress += 0.2
            
            counter -= 1
            
             NumOfTries.text = "Attempts left: \(counter)"
            
            if counter == 0 {
                
                WinLabel.text = "Game over! The number was \(randomNumber!). If you'd like to play again please hit reset!"
                
                UserGuess.isHidden = true
                
                SendGuess.isHidden = true
                
                Reset.isHidden = false
                
                playerLosses += 1
                
                RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
                
                } else if counter == 3 {
                    
                    self.view.backgroundColor = UIColor.yellow
                    
            } else if counter == 1 {
                
                self.view.backgroundColor = UIColor.red
                
                
            } else {
                
                WinLabel.text = "Guess lower!"
                
            }
        
        } else if userGuesses! < randomNumber {
            
            ProgressBar.progress += 0.2
            
            counter -= 1
            
             NumOfTries.text = "Attempts left: \(counter)"
            
            if counter == 0 {
                
                WinLabel.text = "Game over! The number was \(randomNumber!). If you'd like to play again please hit reset!"
                
                playerLosses += 1
                
                RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
                
                UserGuess.isHidden = true
                
                SendGuess.isHidden = true
                
                Reset.isHidden = false
                
            } else if counter == 3 {
                
                self.view.backgroundColor = UIColor.yellow
                
            } else if counter == 1 {
                
                self.view.backgroundColor = UIColor.red
                
            } else {
                
                WinLabel.text = "Guess higher!"
                
            }
            
        }
        
    }
    @IBAction func resetGame(_ sender: Any) {
        
        time.invalidate()
        
        counter = 5
        
        randomNumber = Int.random(in: 1..<maxNumber!)
        
        SendGuess.isHidden = false
        
        UserGuess.isHidden = false
        
        Reset.isHidden = true
        
        ProgressBar.progress = 0
        
        UserGuess.text = ""
        
        WinLabel.text = ""
        
        self.view.backgroundColor = UIColor.white
        
    }
    
    @objc func winnerBackground() {
        if newGame == true {
            let randomColor = colorArray[Int(arc4random_uniform(UInt32(colorArray.count)))]
            self.view.backgroundColor = randomColor
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
}

