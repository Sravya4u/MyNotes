//
//  Notes.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 26/08/24.
//

import SwiftUI

struct NotesItem: View {
    var note: Note
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(note.textContent.split(separator: "\n").first ?? "")
                    .font(.headline)
                Text(note.categoryName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(note.date)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
}
