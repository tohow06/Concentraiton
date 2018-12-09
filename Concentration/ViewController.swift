//
//  ViewController.swift
//  Concentration
//
//  Created by 賴乙豪 on 2018/8/11.
//  Copyright © 2018年 toHow. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concentraion(numberOfPairsOfCards: (cardButtons.count)/2)
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
            pointCountLabel.text = "Points: \(game.pointsOfGame)"
        }
    }
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var pointCountLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        game = Concentraion(numberOfPairsOfCards: (cardButtons.count)/2)
        flipCount = 0
        updateViewFromModel()
        indexOfThemes = Int(arc4random_uniform(UInt32(themes.count)))
        emojiChoices = themes[indexOfThemes]
        emoji.removeAll()
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        
        if let cardNumber = cardButtons.index(of: sender){
            if !game.cards[cardNumber].isFaceUp,!game.cards[cardNumber].isMatched {
                flipCount += 1
            }
        game.chooseCard(at: cardNumber)
        updateViewFromModel()
        }else {
            print("sadsadasdas")
        }
    }
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.4863265157, blue: 0, alpha: 1)
            }
        }
    }
    
    var animals = ["🐶","🐰","🐨","🐷","🙈","🐣","🐔","🦉","🐴","🦋"]
    var faces = ["😀","😂","😇","😘","🤓","🤩","😎","👩‍🎓","🙆‍♂️","🤰"]
    var foods = ["🍏","🍋","🍓","🍍","🍆","🌶","🍠","🥨","🥞","🍖"]
    var excercises = ["⚽️","🎾","🏓","🏑","🎣","⛸","⛷","🤼‍♀️","🏀","🏐"]
    var cars = ["🚗","🚎","🚒","🚜","🏍","🚘","🚟","🚝","🚂"]
    var things = ["⌚️","⌨️","🖲","💾","📷","📽","📟","🎙","⏲","⏳"]
    lazy var themes = [animals,faces,foods,excercises,cars,things]
    
    lazy var indexOfThemes = Int(arc4random_uniform(UInt32(themes.count)))
    lazy var emojiChoices = themes[indexOfThemes]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
        let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
   

}

