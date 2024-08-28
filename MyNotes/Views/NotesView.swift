//
//  NotesView.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 28/08/24.
//
import SwiftUI

struct NotesView: View {
    @EnvironmentObject var viewModel: NotesViewModel
    @State private var note: Note
    @State private var textContent: String
    
    init(note: Note) {
        _note = State(initialValue: note)
        _textContent = State(initialValue: note.textContent)
    }
    
    var body: some View {
        VStack {
            TextEditor(text: $textContent)
                .padding()
                .navigationTitle(note.categoryName)
        }
        .onDisappear {
            saveNote()
        }
    }
    
    private func saveNote() {
        let updatedNote = Note(id: note.id, categoryName: note.categoryName, textContent: textContent, date: note.date)
        viewModel.updateNote(updatedNote)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView(note: Note(id: UUID(), categoryName: "Sample", textContent: "Sample Content", date: "2044-04-4"))
            .environmentObject(NotesViewModel())
    }
}
