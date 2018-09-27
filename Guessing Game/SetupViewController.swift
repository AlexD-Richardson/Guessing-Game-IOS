//
//  SetupViewController.swift
//  Guessing Game
//
//  Created by Alex Richardson on 9/25/18.
//  Copyright © 2018 Alex Richardson. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var Greeting: UILabel!
    
    @IBOutlet weak var UpperBoundNumber: UITextField!
    
    @IBOutlet weak var InstructionLabel: UILabel!
    
    @IBOutlet weak var Play: UIButton!
    
    var randomNumberUB: Int!
    
    @IBOutlet weak var thinkingGIF:
        UIImageView!
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? ViewController {
            
            randomNumberUB = Int(UpperBoundNumber.text!)
            
            
            guard randomNumberUB != nil else { return viewController.maxNumber = 100 }
            
            viewController.maxNumber = randomNumberUB
            
            if randomNumberUB == 0 {
                
                viewController.maxNumber = 100
                
            } 
        }
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
         view.addGestureRecognizer(tap)
        
        let gifBackground = UIImage.gifImageWithName("Deep thought")
        
        thinkingGIF.image = gifBackground

        // Do any additional setup after loading the view.
    }
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
