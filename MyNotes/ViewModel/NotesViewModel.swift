//
//  NotesViewModel.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 27/08/24.
//

import SwiftUI

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    private let notesKey = "NotesData"

    init() {
        loadNotes()
    }

    func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: notesKey),
           let savedNotes = try? JSONDecoder().decode([Note].self, from: data) {
            self.notes = savedNotes
        } else {
            let initialNote = Note(categoryName: "General", textContent: "Your First Note")
            notes.append(initialNote)
            saveNotes()
        }
    }

    func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
    }

    func addNote(categoryName: String) {
        let newNote = Note(categoryName: categoryName, textContent: "")
        notes.append(newNote)
        saveNotes()
    }

    func deleteNoteById(id: UUID) {
        if let index = notes.firstIndex(where: { $0.id == id }) {
            notes.remove(at: index)
            saveNotes()
        }
    }

    func deleteAllNotes() {
        notes.removeAll()
        saveNotes()
    }
}
