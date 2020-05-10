//
//  BoxIndicatorContainer.swift
//  one hundred pixels
//
//  Created by Anton Shpakovsky on 10.05.2020.
//  Copyright © 2020 Anton Shpakovsky. All rights reserved.
//

import SwiftUI

/// Box indicator container builds a grid of cells to display cuttent weight
struct BoxIndicatorContainer: View {
    @Binding var value:Int
    
    var body: some View {
        VStack {
            ForEach(0..<10) { i in
                HStack {
                    ForEach(1..<11) { j in
                        CellContainer(weight: self.$value, index: i * 10 + j )
                    }
                }
            }
        }
    }
}

struct BoxIndicatorContainer_Previews: PreviewProvider {
    static var previews: some View {
        BoxIndicatorContainer(value: .constant(55))
    }
}
