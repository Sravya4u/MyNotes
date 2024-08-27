//
//  NoLabelsView.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 27/08/24.
//

import SwiftUI

struct NoLabelsView: View {
    var body: some View {
        VStack {
            Image("no_labels_icon") // Replace with your FlatIcon image name
                .resizable()
                .frame(width: 100, height: 100)
            Text("No Labels Available")
                .font(.headline)
                .padding()
            Text("Please create a new label to get started.")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

struct NoLabelsView_Previews: PreviewProvider {
    static var previews: some View {
        NoLabelsView()
    }
}

