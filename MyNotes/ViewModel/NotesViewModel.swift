//
//  NotesViewModel.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 27/08/24.
//

import SwiftUI
import Foundation

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private let notesKey = "NotesData"
    private let dateFormatter: DateFormatter
    
    init() {
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateStyle = .medium
        self.dateFormatter.timeStyle = .none
        loadNotes()
    }
    
    private func mockNotesURL() -> URL? {
      return Bundle.main.url(forResource: "mockNotes.json", withExtension: nil)
    }
    // Function to load notes from UserDefaults or mock JSON file
    func loadNotes() {
        if let data = UserDefaults.standard.data(forKey: notesKey) {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let savedNotes = try? decoder.decode([Note].self, from: data) {
                self.notes = savedNotes
                return
            }
        }
        
        // Fallback to mock JSON file if UserDefaults is empty
        if let mockNotesURL = Bundle.main.url(forResource: "mockNotes", withExtension: "json"),
           let data = try? Data(contentsOf: mockNotesURL) {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let mockNotes = try? decoder.decode([Note].self, from: data) {
                self.notes = mockNotes
                saveNotes()
            }
        }
    }
    
    // Function to save notes to UserDefaults
    func saveNotes() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        if let encoded = try? encoder.encode(notes) {
            UserDefaults.standard.set(encoded, forKey: notesKey)
        }
    }
    
    // Function to add a new note
    func addNote(categoryName: String, textContent: String) {
        let newNote = Note(
            id: UUID(),
            categoryName: categoryName,
            textContent: textContent,
            date: dateFormatter.string(from: Date())
        )
        notes.append(newNote)
        saveNotes()
    }

    // Function to delete a note by id
    func deleteNoteById(id: UUID) {
        notes.removeAll { $0.id == id }
        saveNotes()
    }
    
    // Function to delete all notes
    func deleteAllNotes() {
        notes.removeAll()
        saveNotes()
    }
    
    func updateNote(_ updatedNote: Note) {
            if let index = notes.firstIndex(where: { $0.id == updatedNote.id }) {
                notes[index] = updatedNote
                saveNotes()
            }
        }
    
    // Function to get notes for a specific category
    func notesForCategory(_ categoryName: String) -> [Note] {
        return notes.filter { $0.categoryName == categoryName }
    }
    
    // Group notes by category name
    func groupedLabels() -> [String: [Note]] {
        Dictionary(grouping: notes, by: { $0.categoryName })
    }
}
