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
        fetchNotes()
    }
    
    // Construct the URL for loading mock cards
    private func mockNotesURL() -> URL? {
      return Bundle.main.url(forResource: "NotesMock.json", withExtension: nil)
    }

    ///Fetches notes from server or from mock json file
    func fetchNotes() -> [Note] {
        guard let url = mockNotesURL() else {
            print("mockNotes.json file not found")
            let initialNote = Note(categoryName: "General", textContent: "Your First Note")
            notes.append(initialNote)
            return notes
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
           // decoder.dateDecodingStrategy = .iso8601
            notes = try decoder.decode([Note].self, from: data)
            print(notes)
        } catch {
            print("Failed to load notes: \(error.localizedDescription)")
        }
       // saveNotes()
        return notes
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
    
    func groupedLabels() -> [String: [Note]] {
        Dictionary(grouping: notes, by: { $0.categoryName })
    }
}
