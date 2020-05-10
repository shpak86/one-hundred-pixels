//
//  GameEngine.swift
//  one hundred pixels
//
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//

import Foundation

class GameEngine : ObservableObject {
    @Published var total = 100
    @Published var free = 0
    @Published var weights:[Int] = []
    @Published var selectedWeights:[Int] = []
    @Published var availableWeights:[Int] = []
    @Published var gameOver = true
    @Published var gameWon = true
    @Published var newGame = false
    var terms:[Int] = []
    
    init() {
        
    }
    
    /// Update free weight value and selected and available weights lists. If there are no available weights finish game.
    func selectWeight(weight:Int) {
        if let weightIndex = self.availableWeights.firstIndex(of: weight) {
            if weight <= self.free {
                self.free = self.free - weight
                self.availableWeights.remove(at: weightIndex)
                self.selectedWeights.append(weight)
            }
        }
        self.availableWeights = self.availableWeights.filter({ (weight) -> Bool in
            return weight <= self.free
        })
        self.gameOver = self.availableWeights.isEmpty || (self.free < self.availableWeights.min() ?? 100)
        self.newGame = false
    }
    
    /// Refresh all values and counters.
    func refresh() {
        var remainder = self.total
        var weights:[Int] = []
        var uniqueValues = false
        // Decomposite total on terms
        while !uniqueValues {
            remainder = self.total
            weights.removeAll()
            for _ in 1...3 {
                var weight = Int.random(in: 1..<(self.total / 2))
                while weights.contains(weight) {
                    weight = Int.random(in: 1..<(self.total / 2))
                }
                if weight <= remainder {
                    weights.append(weight)
                    remainder = remainder - weight
                }
            }
            if remainder > 0 {
                if !weights.contains(remainder) {
                    weights.append(remainder)
                    uniqueValues = true
                }
            }
        }
        self.terms.removeAll()
        self.terms.append(contentsOf: weights)
        // Generate random values.
        while weights.count != 8 {
            var weight = Int.random(in: 1..<(self.total / 2))
            while weights.contains(weight) {
                weight = Int.random(in: 1..<(self.total / 2))
            }
            weights.append(weight)
        }
        
        self.weights = weights.shuffled()
        self.availableWeights.removeAll()
        self.availableWeights.append(contentsOf: self.weights)
        self.selectedWeights.removeAll()
        self.free = 100
        self.gameOver = false
        self.newGame = true
    }
    
    func help() {
        if newGame {
            self.selectWeight(weight: self.terms.max()!)
        }
    }
}
