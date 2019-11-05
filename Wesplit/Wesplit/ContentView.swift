//
//  ContentView.swift
//  Wesplit
//
//  Created by og lerma1 on 11/5/19.
//  Copyright © 2019 ociellerma. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = 0

    var body: some View {
        VStack{
            Picker("Select a person", selection: $selectedStudent){
                ForEach(0..<students.count){ name in
                    Text("\(self.students[name])")
                }
            }
            Text("You chose: \(students[selectedStudent])")
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
