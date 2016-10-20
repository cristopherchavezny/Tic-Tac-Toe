//
//  ViewController.swift
//  TicTacToeSecondTry
//
//  Created by Cris on 9/30/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Minimum Viable Product 
    //Play TicTacToe with the following rules
    // - A player can't go twice
    // - Player must enter x or o
    
    
    var turnsTaken = 0
    var playerOne = ""
    var playerTwo = ""
    var lastTurn = ""
    var currentPlayer = ""
    
    @IBOutlet weak var playerLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var topLeft: UITextField!
    
    @IBOutlet weak var topCenter: UITextField!
    
    @IBOutlet weak var topRight: UITextField!
    
    @IBOutlet weak var centerLeft: UITextField!
    
    @IBOutlet weak var centerCenter: UITextField!
    
    @IBOutlet weak var centerRight: UITextField!
    
    @IBOutlet weak var bottomLeft: UITextField!
    
    @IBOutlet weak var bottomCenter: UITextField!
    
    @IBOutlet weak var bottomRight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        messageLabel.isHidden = true
        playerLabel.isHidden = true
        topLeft.delegate = self
        topCenter.delegate = self
        topRight.delegate = self
        centerLeft.delegate = self
        centerCenter.delegate = self
        centerRight.delegate = self
        bottomLeft.delegate = self
        bottomCenter.delegate = self
        bottomRight.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    
    func disableAllTextFields(){
        playerLabel.isEnabled = false
        topLeft.isEnabled = false
        topCenter.isEnabled = false
        topRight.isEnabled = false
        centerLeft.isEnabled = false
        centerCenter.isEnabled = false
        centerRight.isEnabled = false
        bottomLeft.isEnabled = false
        bottomCenter.isEnabled = false
        bottomRight.isEnabled = false
    }
    
    func enableAllButtons() {
        playerLabel.isEnabled = true
        topLeft.isEnabled = true
        topCenter.isEnabled = true
        topRight.isEnabled = true
        centerLeft.isEnabled = true
        centerCenter.isEnabled = true
        centerRight.isEnabled = true
        bottomLeft.isEnabled = true
        bottomCenter.isEnabled = true
        bottomRight.isEnabled = true
    }
    
    func clearTextFields(){
        topLeft.text = ""
        topCenter.text = ""
        topRight.text = ""
        centerLeft.text = ""
        centerCenter.text = ""
        centerRight.text = ""
        bottomLeft.text = ""
        bottomCenter.text = ""
        bottomRight.text = ""
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Hide Keyboard
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        disableKeyboard(textField: textField)
        checkIfWon()
    }
    
    func checkIFXorO(textField: UITextField) {
        if let text = textField.text {
            if !(text == "X" || text == "O" || text == "x" || text == "o"){
                messageLabel.isHidden = false
                messageLabel.text = "Please enter x or o"
                textField.text = nil
                textField.isEnabled = true
            } else if textField.text == ""{
                textField.isEnabled = true
            } else if text == lastTurn {
                messageLabel.isHidden = false
                messageLabel.text = "You can't go twice!"
                textField.text = nil
                textField.isEnabled = true
            }
        }
    }
    
    func currentTurn(){
        if turnsTaken % 2 == 1 {
            currentPlayer = "Player One"
        } else if turnsTaken % 2 == 0 {
            currentPlayer = "Player Two"
        }
    }
    
    func whoIsFirst(textField: UITextField) {
        turnsTaken += 1
        switch turnsTaken {
        case 1:
            playerLabel.isHidden = false
            if let playerOnes = textField.text {
                playerOne = playerOnes
                playerLabel.text = "Player 1 is \(playerOne)"
            }
        case 2:
            if let playerTwos = textField.text {
                playerTwo = playerTwos
                playerLabel.text = "Player 1 is \(playerOne) | Player 2 is \(playerTwo)"
            }
        default:
            break
        }
    }
    
    func disableKeyboard(textField: UITextField) {
        textField.isEnabled = false
        checkIFXorO(textField: textField)
        if textField.isEnabled == false {
            whoIsFirst(textField: textField)
            lastTurn = textField.text!
            messageLabel.isHidden = true
        }
    }
    
    func checkIfWon() {
        if let topLeft = topLeft.text, let topCenter = topCenter.text, let topRight = topRight.text, let centerLeft = centerLeft.text, let centerCenter = centerCenter.text, let centerRight = centerRight.text, let bottomLeft = bottomLeft.text, let bottomCenter = bottomCenter.text, let bottomRight = bottomRight.text {
            var isWinner = false
            if (topLeft == topCenter && topCenter == topRight && topLeft.characters.count > 0){
                isWinner = true
            } else if centerLeft == centerCenter && centerRight == centerCenter && centerLeft.characters.count > 0{
                messageLabel.isHidden = false
                isWinner = true
            } else if bottomLeft == bottomCenter && bottomCenter == bottomRight && bottomLeft.characters.count > 0 {
                isWinner = true
            } else if topLeft == centerLeft && centerLeft == bottomLeft && topLeft.characters.count > 0{
                isWinner = true
            } else if topCenter == centerCenter && centerCenter == bottomCenter && topCenter.characters.count > 0{
                isWinner = true
            } else if topRight == centerRight && centerRight == bottomRight && topRight.characters.count > 0{
                isWinner = true
            } else if topLeft == centerCenter && centerCenter == bottomRight && topLeft.characters.count > 0{
                isWinner = true
            } else if topRight == centerCenter && centerCenter == bottomLeft && topRight.characters.count > 0{
                isWinner = true
            }
            if isWinner == true {
                messageLabel.isHidden = false
                currentTurn()
                messageLabel.text = "\(currentPlayer) wins! "
                disableAllTextFields()
            }
        }
    }
    
    
    @IBAction func resetButton(_ sender: UIButton) {
        resetButton()
    }
    
    func resetButton() {
        playerLabel.isHidden = true
        playerLabel.text = ""
        messageLabel.isHidden = true
        messageLabel.text = ""
        turnsTaken = 0
        playerOne = ""
        playerTwo = ""
        lastTurn = ""
        currentPlayer = ""
        enableAllButtons()
        clearTextFields()
    }
}

