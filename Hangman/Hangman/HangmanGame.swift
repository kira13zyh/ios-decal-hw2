//
//  HangmanGame.swift
//  Hangman
//
//  Created by Emily Hill on 2/17/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import Foundation
class HangmanGame {
    //variables
    var gameState: Bool
    var wrongAttempts: Int
    var wrongGuesses: [Character]
    var correctGuesses: [Character]
    var phrase: String
    var phraseArray: [Character]
    //initialization
    init() {
        self.gameState = true
        self.wrongAttempts = 0
        self.wrongGuesses = []
        self.correctGuesses = []
        self.phrase = ""
        self.phraseArray = []
    }
    func answer(phrase: String) {
        self.phrase = phrase
        //var i: Character
        for i in phrase {
            self.phraseArray.append(i)
        }
    }
    func gameOver() {
        gameState = false
    }
    func restart() {
        self.gameState = true
        self.wrongAttempts = 0
        self.wrongGuesses = []
        self.correctGuesses = []
        self.phrase = ""
        self.phraseArray = []
        let phraseGenerator = HangmanPhrases.init()
        let phrase = phraseGenerator.getRandomPhrase()
        self.answer(phrase: phrase)
    }
    func addWrongAttempt(wrongGuess: Character) {
        self.wrongAttempts += 1
        self.wrongGuesses.append(wrongGuess)
        checkGameOver()
    }
    func addCorrectAttempt(correctGuess: Character) {
        self.correctGuesses.append(correctGuess)
        checkGameOver()
    }
    func checkGameOver() {
        if self.wrongAttempts == 6 {
            gameOver()
        } else if phraseContainsCorrect() {
            gameOver()
        }
    }
    func phraseContainsCorrect() -> Bool {
        for i in self.phraseArray {
            if i == " " {
                continue
            } else if !correctGuesses.contains(i) {
                return false
            }
        }
        return true
    }
    func checkInput(letter: Character) -> Bool {
        print(self.phraseArray)
        if self.phraseArray.contains(letter) {
            return true
        } else {
            addWrongAttempt(wrongGuess: letter)
            return false
        }
    }
}
