//
//  AudioPlayer.swift
//  one hundred pixels
//
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//

import Foundation
import AVFoundation

class AudioPlayer:ObservableObject {
    
    private let muteKey = "mute"
    private let backgroundMusic = URL(fileURLWithPath: Bundle.main.path(forResource: "background", ofType:"mp3")!)
    private let gameOverSound = URL(fileURLWithPath: Bundle.main.path(forResource: "gameOver", ofType:"mp3")!)
    private let tapSound = URL(fileURLWithPath: Bundle.main.path(forResource: "tap", ofType:"mp3")!)
    private let victorySound = URL(fileURLWithPath: Bundle.main.path(forResource: "victory", ofType:"mp3")!)
    private var backgroundPlayer:AVAudioPlayer?
    private var gameOverPlayer:AVAudioPlayer?
    private var tapPlayer:AVAudioPlayer?
    private var victoryPlayer:AVAudioPlayer?
    
    @Published var muted = false
    
    init() {
        do {
            self.backgroundPlayer = try AVAudioPlayer(contentsOf: self.backgroundMusic)
            self.gameOverPlayer = try AVAudioPlayer(contentsOf: self.gameOverSound)
            self.tapPlayer = try AVAudioPlayer(contentsOf: self.tapSound)
            self.victoryPlayer = try AVAudioPlayer(contentsOf: self.victorySound)
            self.backgroundPlayer?.numberOfLoops = -1
            self.loadSettings()
        } catch {
            print (error)
        }
    }
    
    func mute() {
        self.muted = true
        self.stopBackground()
        self.saveSettings()
    }
    
    func unmute() {
        self.muted = false
        self.saveSettings()
        self.playBackground()
    }
    
    func toggle() {
        if self.muted {
            self.unmute()
        } else {
            self.mute()
        }
    }
    
    func playBackground() {
        if let player = self.backgroundPlayer {
            if !muted { player.play() }
        }
    }
    
    func playTap()  {
        if let player = self.tapPlayer {
            if !muted { player.play() }
        }
    }
    
    func playGameOver()  {
        if let player = self.gameOverPlayer {
            if !muted { player.play() }
        }
    }
    
    func playVictory()  {
        if let player = self.victoryPlayer {
            if !muted { player.play() }
        }
    }
    
    func stopBackground() {
        if let player = self.backgroundPlayer {
            player.stop()
        }
    }
    
    func stopTap()  {
        if let player = self.tapPlayer {
            player.stop()
        }
    }
    
    func stopGameOver()  {
        if let player = self.gameOverPlayer {
            player.stop()
        }
    }
    
    func stopVictory()  {
        if let player = self.victoryPlayer {
            player.stop()
        }
    }
    
    /// Read default settings from `UserDefaults.standard`
    func loadSettings() {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: muteKey) == nil {
            defaults.set(self.muted, forKey: muteKey)
        } else {
            if defaults.bool(forKey: muteKey) {
                self.mute()
            } else {
                unmute()
            }
        }
    }
    
    func saveSettings()  {
        let defaults = UserDefaults.standard
        defaults.set(self.muted, forKey: self.muteKey)
    }
}
