//
//  Concentration.swift
//  Concentration
//
//  Created by Seokhwan Moon on 29/09/2019.
//  Copyright © 2019 Parannarae. All rights reserved.
//

import Foundation

class Concentration
{
    // getter needs to be public to show in UI, but setter should be internal work
    private(set) var cards = [Card]()
    
    // to check the status of current game
    // optional to make the case when there is no card is opened yet
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // use closure to make it cleaner
//            let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp } // Array of Arry.Index type is aliased into Int
//            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            // use extension
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly

            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        // no card is flipped yet
//                        foundIndex = index
//                    } else {
//                        // this is the second flipped card
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            // if no argument is given, `newValue` is a default argument name
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        // it crashed in development, but not in production
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        // ignore card if it is already matched
        if !cards[index].isMatched {
            // second card is chosen
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                // open up the card and reset the previously opened card
                cards[index].isFaceUp = true
                // this has done in getter
//                indexOfOneAndOnlyFaceUpcard = nil
            } else {
                // this has done in setter
//                // either no cards or 2 cards are face up
//                for flipDownIndex in cards.indices {
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        // countable range: `..<` = exclude last, `...` = include last
        for _ in 0..<numberOfPairsOfCards { // `_` means ignore it
            let card = Card()
//            let matchingCard = card // since struct is pass by value, it creates another Card
//            cards.append(card)
//            cards.append(matchingCard)
            
//            cards.append(card)
//            cards.append(card) // same as set matchingCard
            
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards
    }
}

extension Collection {
    // Element is a type of Generic type in Collection
    var oneAndOnly: Element? {
        // count, first are collection methods (since they are used in var in Collection, just can be called with just their name
        return count == 1 ? first : nil
    }
}
