//
//  Extensions.swift
//  ImpulsivityOhmage
//
//  Created by James Kizer on 2/10/17.
//  Copyright © 2017 Foundry @ Cornell Tech. All rights reserved.
//

import UIKit

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (unshuffledCount, firstUnshuffled) in zip(stride(from: c, to: 1, by: -1), indices) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
    
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
    
    func shuffled(shouldShuffle: Bool) -> [Iterator.Element] {
        if shouldShuffle {
            var result = Array(self)
            result.shuffle()
            return result
        }
        else {
            return Array(self)
        }
        
    }
}
