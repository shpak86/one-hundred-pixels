//
//  SettingsView.swift
//  one hundred pixels
//
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    @EnvironmentObject var audioPlayer:AudioPlayer
    @EnvironmentObject var schemeManager:SchemeManager
    @State var muted:Bool = false
    
    private let themes:[ColorSchemeNames] = [.dark, .light, .mint, .summer, .spring]
    private let themeCaptions:[ColorSchemeNames: String] = [
        .dark: "Moonlight", .light: "Ocean", .mint: "Mint lolipop", .summer: "Summer rain", .spring: "Spring flower"
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Sound")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(schemeManager.scheme.secondaryTextColor)
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    Text("Mute sounds")
                        .foregroundColor(schemeManager.scheme.secondaryTextColor)
                    Spacer()
                    Button(action: {
                        self.audioPlayer.toggle()
                    }) {
                        Text(self.audioPlayer.muted ? "ON" : "OFF")
                            .bold()
                            .padding()
                            .frame(width: 80)
                            .background(self.audioPlayer.muted ? schemeManager.scheme.primaryColor : .clear)
                            .foregroundColor(self.audioPlayer.muted ? schemeManager.scheme.primaryTextColor : schemeManager.scheme.secondaryTextColor)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                }
                .padding()
                HStack {
                    Text("Themes")
                        .padding(.horizontal)
                        .font(.headline)
                        .foregroundColor(schemeManager.scheme.secondaryTextColor)
                    Spacer()
                }
                .padding(.horizontal)
                VStack {
                    ForEach(self.themes, id:\.self) { theme in
                        Button(action: {
                            self.schemeManager.useScheme(theme)
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                            gradient: self.schemeManager.schemes[theme]!.backgroundGradient,
                                            startPoint: .bottomLeading,
                                            endPoint: .topTrailing))
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                Text(self.themeCaptions[theme] ?? "Unknown")
                                    .padding()
                                    .font(.title)
                                    .foregroundColor(self.schemeManager.schemes[theme]!.secondaryTextColor)
                            }
                            
                        }
                        .shadow(radius: self.schemeManager.schemeName == theme ? 5 : 0)
                    }
                }
                
            }
            .padding(.top, 100)
            .onAppear() {
                self.muted = self.audioPlayer.muted
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity )
        .background(LinearGradient(gradient: schemeManager.scheme.backgroundGradient, startPoint: .bottomLeading, endPoint: .topTrailing))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(AudioPlayer())
    }
}
