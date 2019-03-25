//
//  ViewController.swift
//  Concentration
//
//  Created by MacOS on 1/29/19.
//  Copyright © 2019 MacOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        chooseTheme()
    }
   private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
   var numberOfPairsOfCards: Int {
    
            return (cardButtons.count+1)/2
        
    }
    
    
    private(set)  var flipsCount: Int = 0
    {
        didSet {
            
            updateFlipCountLabel()
        }
    }
    private func updateFlipCountLabel(){
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.orange
            
        ]
        let attributedString = NSAttributedString(string:  String(flipsCount), attributes: attributes)
        flipsCountLabel.attributedText = attributedString
        
    }
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet private weak var flipsCountLabel: UILabel!{
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        flipsCountLabel.text = "0"
        flipsCount = 0
       
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if  card.isFaceUp == true{
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        
        chooseTheme()
       
        
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
  
    flipsCount += 1
        if  let cardNumber = cardButtons.index(of : sender){
              game.chooseCard(at: cardNumber)
              updateViewFromModel()
        } else {
            print("Chosen card was not in the cardButton")
        }
     
   
        
    }
   private func updateViewFromModel()
    {
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for : card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("  ", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) :#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    //var emojiChoices = ["👻","🎃","🍎","🍭","😱","😈","🧙‍♂️","🕷","🦇"]
    var  emojiChoices : String = ""
    
    var Halloween = "👻🎃🍎🍭😱😈🧙‍♂️🕷🦇"
    var Winter = "⛷❄️🥶⛄️🎿🎄🎅"
    var Hearts = "❤️🧡💛💚💙💜🖤💝💕"
    var Sports = "🏀🥎⚽️⚾️🏓🎱🏹🏄‍♀️🏆"
    var Animals = "🐶🐱🐭🐯🐼🐸🐥🐵"
    
    
  lazy  var emojiThemeChoice: [Int: String] = [0 : Halloween,
                                             1 : Winter,
                                             2 : Hearts,
                                             3 : Sports,
                                             4 :  Animals
                       ]
    
    
    var emoji = [Card: String]()
    
    func chooseTheme(){
        
        let randomIndexForTheme = Int(arc4random_uniform (UInt32(emojiThemeChoice.count)))
        
    
        emojiChoices = emojiThemeChoice[randomIndexForTheme] ?? ""
        
        
    }
    
  private  func emoji(for card: Card) -> String{
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] =  String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
        
        
    }
}
    extension Int {
        var arc4random: Int {
            if self > 0 {
                return Int(arc4random_uniform (UInt32(self)))
                
            }
            if self < 0 {
                return -Int(arc4random_uniform (UInt32(abs(self))))
            }
            else {
                return 0
                
            }
        }
    }


