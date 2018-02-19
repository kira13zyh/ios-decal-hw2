//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Emily Hill on 2/17/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController, UITextFieldDelegate {
    //outlets and variables
    var game = HangmanGame.init()
    //var wrongGuesses: String
    @IBOutlet weak var HangmanImage: UIImageView!
    @IBOutlet weak var answerField: UILabel!
    @IBAction func startOver(_ sender: UIButton) {
        game.restart()
        self.resetScene()
    }
    
    @IBAction func guessConfirmed(_ sender: UIButton) {
        if !(myGuess.text! == "") {
            if myGuess.text!.isEmpty {
            }
            else if game.checkInput(letter: (Character)(myGuess.text!)) { //if user guessed the correct
                game.addCorrectAttempt(correctGuess: (Character)(myGuess.text!))
                //display the corresponding letters
                var result = ""
                for i in game.phrase {
                    if i == (Character)(myGuess.text!) {
                        result.append((Character)(myGuess.text!))
                        result.append(" ")
                    } else if i == " " {
                        result.append(" ")
                    } else if game.correctGuesses.contains(i){
                        result.append(i)
                        result.append(" ")
                    } else {
                        result.append("_ ")
                    }
                }
                answerField.text = result
                if game.gameState == false {
                    let alertController = UIAlertController(title: "Congrats", message: "You Win!", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                    let action1 = UIAlertAction(title: "New Game", style: .default) { (action:UIAlertAction) in
                        print("You've pressed New Game");
                    }
                    alertController.addAction(action1)
                    self.game.restart()
                    self.resetScene()
                }
            } else { // 
                var badGuesses = ""
                for i in game.wrongGuesses {
                    badGuesses.append(i)
                }
                IncorrectGuesses.text = "Incorrect Guesses: " + badGuesses
                var image = "hangman"
                let number = game.wrongAttempts + 1
                image.append((String)(number))
                HangmanImage.image = UIImage(named: image)
                //print(number)
                if game.gameState == false {
                    let alertController = UIAlertController(title: "Sorry", message: "You Lose", preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                    let action1 = UIAlertAction(title: "New Game", style: .default) { (action:UIAlertAction) in
                        print("You've pressed New Game");
                        self.game.restart()
                        self.resetScene()
                    }
                    alertController.addAction(action1)
                }
                
            }
        }
    }
    @IBOutlet weak var IncorrectGuesses: UILabel!
    @IBOutlet weak var myGuess: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //initial setup
        self.myGuess.delegate = self
        self.resetScene()
    }
    
    func resetScene() {
        let phraseGenerator = HangmanPhrases.init()
        let phrase = phraseGenerator.getRandomPhrase()
        game.answer(phrase: phrase)
        //let dashes = phrase.count
        var result = ""
        for i in phrase {
            if i == " " {
                result.append(" ")
            } else {
                result.append("_ ")
            }
        }
        answerField.text = result
        HangmanImage.image = UIImage(named: "hangman1")
        IncorrectGuesses.text = "Incorrect Guesses: "
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return allowedCharacters.isSuperset(of: characterSet) && updatedText.count <= 1
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
