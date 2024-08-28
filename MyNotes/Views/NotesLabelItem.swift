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
    var isSelected: Bool = false

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
            
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .padding(.trailing, 10)
            }
        }
        .padding(.vertical, 10)
        .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
        .cornerRadius(10)
    }
}

struct NotesLabelItem_Previews: PreviewProvider {
    static var previews: some View {
        NotesLabelItem(label: "Sample Label", noteCount: 5)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
