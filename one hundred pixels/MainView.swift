//
//  MainView.swift
//  
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//


import SwiftUI
import AVFoundation

struct MainView: View {
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var schemeManager:SchemeManager
    @ObservedObject var gameEngine = GameEngine()
    
    private let victoryCaptions = ["Excellent!", "Congratulations!", "You win!"]
    private let defeatCaptions = ["Try again", "You can better", "Let's try again!"]
    @State var justStarted = true
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack{
                    VStack {
                        Spacer()
                        if self.justStarted {
                            Text("Tap to start").padding(.bottom).foregroundColor(schemeManager.scheme.secondaryTextColor).font(.title)
                        } else if self.gameEngine.gameOver {
                            if self.gameEngine.free == 0 {
                                Text(victoryCaptions[Int.random(in: 0..<3)]).padding(.bottom).foregroundColor(schemeManager.scheme.secondaryTextColor).font(.largeTitle)
                            } else {
                                Text(defeatCaptions[Int.random(in: 0..<3)]).padding(.bottom).foregroundColor(schemeManager.scheme.secondaryTextColor).font(.title)
                            }
                        }
                        
                        Button(action: {
                            if self.gameEngine.gameOver {
                                self.gameEngine.refresh()
                                self.justStarted = false
                            } else {
                                self.gameEngine.help()
                            }
                            self.audioPlayer.playTap()
                        }) {
                            ZStack {
                                BoxIndicatorContainer(value: self.$gameEngine.free)
                                    .padding(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(schemeManager.scheme.secondaryColor, lineWidth: self.gameEngine.gameOver && self.gameEngine.free == 0 ? 4 : 0)
                                )
                                if self.gameEngine.newGame {
                                    Image(systemName: "lightbulb.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(schemeManager.scheme.primaryColor)
                                        .padding(100)
                                        .shadow(radius: 5)
                                    
                                }
                            }
                        }
                        .disabled(!gameEngine.gameOver && !gameEngine.newGame)
                        
                        Spacer()
                        if !gameEngine.gameOver {
                            VStack {
                                HStack(spacing: 6) {
                                    ForEach(0..<4) { index in
                                        Button (action: { self.selectWeight(weight: self.gameEngine.weights[index]) }) {
                                            WeightContainer(
                                                weight: self.gameEngine.weights[index],
                                                disabled: !self.gameEngine.availableWeights.contains(self.gameEngine.weights[index]),
                                                selected: self.gameEngine.selectedWeights.contains(self.gameEngine.weights[index]))
                                        }
                                    }
                                }
                                .padding(.vertical)
                                HStack(spacing: 6) {
                                    ForEach(4..<8) { index in
                                        Button (action: { self.selectWeight(weight: self.gameEngine.weights[index]) }) {
                                            WeightContainer(
                                                weight: self.gameEngine.weights[index],
                                                disabled: !self.gameEngine.availableWeights.contains(self.gameEngine.weights[index]),
                                                selected: self.gameEngine.selectedWeights.contains(self.gameEngine.weights[index]))
                                        }
                                    }
                                }
                                
                            }
                            Spacer()
                        }
                    }
                }
                .navigationBarItems(trailing:
                    NavigationLink(destination: SettingsView().environmentObject(self.schemeManager)) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .foregroundColor(schemeManager.scheme.secondaryTextColor)
                            .padding(4)
                    }
                )
                    .frame(maxWidth:.infinity, maxHeight: .infinity )
                    .background(
                        LinearGradient(
                            gradient: schemeManager.scheme.backgroundGradient,
                            startPoint: .bottomLeading,
                            endPoint: .topTrailing))
                    .edgesIgnoringSafeArea(.all)
            }
                
            .onAppear() {
                self.audioPlayer.playBackground()
            }
            .animation(.easeInOut)
        }
    }
    
    /// Update free weight value and selected and available weights lists. If there are no available weights finish game.
    func selectWeight(weight:Int) {
        self.gameEngine.selectWeight(weight: weight)
        self.audioPlayer.playTap()
        if self.gameEngine.gameOver {
            if self.gameEngine.free == 0 {
                self.audioPlayer.playVictory()
            } else {
                self.audioPlayer.playGameOver()
            }
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
