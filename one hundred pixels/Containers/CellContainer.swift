//
//  CellContainer.swift
//  one hundred pixels
//
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//

import SwiftUI

/// Indicator cell container
/// If cell's index is lower than the weight it showing as transparent. This is because the box is filling from the top and `weight` means free weight
struct CellContainer: View {
    @Binding var weight:Int
    @EnvironmentObject var schemeManager:SchemeManager
    var index:Int = 1
    
    var body: some View {
        Rectangle()
            .fill(schemeManager.scheme.secondaryColor)
            .opacity(self.index > self.weight ? 1.0 : 0.3)
            .frame(width: 20, height: 20)
            .cornerRadius(2)
    }
}

struct CellContainer_Previews: PreviewProvider {
    static var previews: some View {
        CellContainer(weight: .constant(5), index: 18)
    }
}

