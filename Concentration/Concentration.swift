//
//  Concentration.swift
//  Concentration
//
//  Created by 賴乙豪 on 2018/8/11.
//  Copyright © 2018年 toHow. All rights reserved.
//

import Foundation

class Concentraion {

    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var pointsOfGame = 0
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard , matchIndex != index{
                //check match or not
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
            }else{
                //no cards are faceup or two card are faceup
                for flipOverIndex in cards.indices {
                    cards[flipOverIndex].isFaceUp = false
                }
                indexOfOneAndOnlyFaceUpCard = index
                cards[index].isFaceUp = true
            }
        }
    }
    init(numberOfPairsOfCards: Int) {
        Card.identifierFactory = 0
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            cards += [card,card]
        }
        cards = shuffle()
    }
    func shuffle() -> [Card] {
        var tem = [Card]()
        var plant = cards
        for _ in plant.indices{
            if plant.count>0{
                let randomIndex = Int(arc4random_uniform(UInt32(plant.count)))
                
                tem.append(plant.remove(at: randomIndex))
                
            }
        }
        return tem
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
