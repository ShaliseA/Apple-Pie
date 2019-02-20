//
//  ViewController.swift
//  Apple Pie
//
//  Created by Shalise Ayromloo on 2/19/19.
//  Copyright © 2019 Shalise Ayromloo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7 //number of incorrect guesses before it's game over
    var totalWins = 0 {
        didSet { //when the variable changes
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game! //we add this variable after creating a Game struct
    //the exclamation mark next to Game tells the compiler that it's ok if this variable is not initialized
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.isEnabled = false //once we choose a letter we can't choose it again
        let letterString = sender.title(for: .normal)! //returns a string from title of button so we can get the letter, set it to lower case
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        newRound()
        
    }

    func newRound() { //when we have a new round, we need to know where we are within the game. We want to choose a word and reset the number of moves left and in order to do that, we want to use a struct for the game
        if !listOfWords.isEmpty {
            
        
        let newWord = listOfWords.removeFirst() //will take the first word and removes it and assigns it to newWord
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
       
        enableLetterButtons(true)
        updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    
    
  
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)") //setting the first image to be tree and then the number
        
    }
    
    
    func updateGameState() {
        //how do we know when it's over
        //if the chosen word has all the letters, then we have wone
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    
    
    
}

