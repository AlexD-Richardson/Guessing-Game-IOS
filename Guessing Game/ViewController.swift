//
//  ViewController.swift
//  Guessing Game
//
//  Created by Alex Richardson on 9/24/18.
//  Copyright © 2018 Alex Richardson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    
    var randomNumber = Int(arc4random_uniform(100) + 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        GuessLabel.text = "Guess a number between 1 and 100! You will only get 5 tries. Good luck!"
        
        NumOfTries.text = "Attempts left: \(counter)"
        
        ProgressBar.progress = 0
        
        RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
        
        Reset.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        
        
        let userGuesses = Int(UserGuess.text!)
        
        guard userGuesses != nil else { return WinLabel.text = "Please enter in a number!"}
        
        
        if userGuesses! > 100 || userGuesses! < 1 {
            
            WinLabel.text = "Please enter in a number between 1 and 100"
            
        } else if userGuesses! == randomNumber {

           WinLabel.text = "Congrats you won! Please tap the restart button if you want to play again."
            
            playerWins += 1
            
            RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
            
            UserGuess.isHidden = true
            
            SendGuess.isHidden = true
            
            Reset.isHidden = false
            
            
            
        } else if userGuesses! > randomNumber {
            
            ProgressBar.progress += 0.2
            
            counter -= 1
            
             NumOfTries.text = "Attempts left: \(counter)"
            
            if counter == 0 {
                
                WinLabel.text = "Game over! The number was \(randomNumber). If you'd like to play again please hit reset!"
                
                UserGuess.isHidden = true
                
                SendGuess.isHidden = true
                
                Reset.isHidden = false
                
                playerLosses += 1
                
                RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
                
            } else {
                
                WinLabel.text = "Guess lower!"
                
            }
        
        } else if userGuesses! < randomNumber {
            
            ProgressBar.progress += 0.2
            
            counter -= 1
            
             NumOfTries.text = "Attempts left: \(counter)"
            
            if counter == 0 {
                
                WinLabel.text = "Game over! The number was \(randomNumber). If you'd like to play again please hit reset!"
                
                playerLosses += 1
                
                RecordLabel.text = "Record: \(playerWins)-\(playerLosses)"
                
                UserGuess.isHidden = true
                
                SendGuess.isHidden = true
                
                Reset.isHidden = false
                
            } else {
                
                WinLabel.text = "Guess higher!"
                
            }
            
        }
        
    }
    @IBAction func resetGame(_ sender: Any) {
        
        counter = 5
        
        randomNumber = Int(arc4random_uniform(100) + 1)
        SendGuess.isHidden = false
        
        UserGuess.isHidden = false
        
        Reset.isHidden = true
        
        ProgressBar.progress = 0
        
        UserGuess.text = ""
        
        WinLabel.text = ""
        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    
    
}

