//
//  Concentration.swift
//  Concentration
//
//  Created by MacOS on 1/30/19.
//  Copyright © 2019 MacOS. All rights reserved.
//

import Foundation

struct Concentration
{
    private(set)  var cards = [Card]()
    private(set) var score = 0
  
    private var seenCards: Set<Int> = []
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return  cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
           
       
        }
        set {
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
            
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index),"Concentration.chooseCard (at: \(index)): chosen index not in cards")
        if !cards[index].isMatched{
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[index] == cards[matchIndex] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                    
                    
                    score += Points.matchBonus
                } else {
                    if seenCards.contains(index) {
                        score -= Points.missMatchPenalty
                    }
                    if seenCards.contains(matchIndex){
                        score -= Points.missMatchPenalty
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
            
            cards[index].isFaceUp = true
          
            
        } else {
          
            indexOfOneAndOnlyFaceUpCard = index
           }
        }
    }
    init(numberOfPairsOfCards: Int) {
         assert(numberOfPairsOfCards > 0,"Concentration.init (: \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards
        {  let card = Card()
            
            cards += [card,card]
            
        }
        // TODO: Shuffle The cards
        cards.shuffle()
    }
    
    
   
    }
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
        
    }
        
    }

struct Points {
    static var matchBonus = 2
    static var missMatchPenalty = 1
}
