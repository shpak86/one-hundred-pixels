//
//  WeightContainer.swift
//  one hundred pixels
//
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//

import SwiftUI

/// Container for display weight value
struct WeightContainer: View {
    @EnvironmentObject var schemeManager: SchemeManager
    var weight:Int
    var blur = false
    var disabled = false
    var selected = false
    
    var body: some View {
        ZStack {
            RoundedRectangle (cornerRadius: selected ? 10 : 40)
                .frame(width:80, height: 80)
                .foregroundColor(schemeManager.scheme.primaryColor)
                .opacity(disabled && !selected ? 0.3 : 1.0)
                .shadow(radius: 5)
                
            Text("\(weight)")
                .font(.system(size: 40))
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .frame(width:80, height: 80)
                .foregroundColor(schemeManager.scheme.primaryTextColor)
        }
    }
}

struct WeightContainer_Previews: PreviewProvider {
    static var previews: some View {
        WeightContainer(weight: 100, disabled: true, selected: true)
    }
}
