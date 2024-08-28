//
//  NoNotesView.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 28/08/24.
//

import SwiftUI

struct NoNotesView: View {
    var categoryName: String

    var body: some View {
        VStack(alignment: .leading) {
            // Display the category name at the top left
            Text(categoryName)
                .font(.title)
                .padding(.leading, 20)
                .padding(.top, 20)

            Spacer()

            // Message indicating no notes are available
            Text("No Notes Available")
                .font(.headline)
                .foregroundColor(.gray)
                .padding(.leading, 20)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct NoNotesView_Previews: PreviewProvider {
    static var previews: some View {
        NoNotesView(categoryName: "Shopping")
            .previewLayout(.sizeThatFits)
    }
}

