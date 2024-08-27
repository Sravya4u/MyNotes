//
//  NotesLabelItem.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 26/08/24.
//

import SwiftUI

struct NotesLabelItem: View {
    var label: String
    var noteCount: Int

    var body: some View {
        HStack {
            Image(systemName: "folder")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.leading, 10)

            Spacer()

            Text(label)
                .font(.headline)

            Spacer()

            Text("\(noteCount)")
                .padding(.trailing, 10)
        }
        .padding(.vertical, 10)
    }
}

struct NotesLabelItem_Previews: PreviewProvider {
    static var previews: some View {
        NotesLabelItem(label: "Sample Label", noteCount: 5)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
