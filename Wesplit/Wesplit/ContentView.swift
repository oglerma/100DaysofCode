//
//  ContentView.swift
//  Wesplit
//
//  Created by og lerma1 on 11/5/19.
//  Copyright © 2019 ociellerma. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var tapCount = 0
    var body: some View {
        Button("Tap count \(tapCount)") {
            self.tapCount += 1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
