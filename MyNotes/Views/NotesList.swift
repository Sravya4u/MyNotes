//
//  NotesList.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 26/08/24.
//
import SwiftUI

struct NotesList: View {
    @EnvironmentObject var viewModel: NotesViewModel
    @State private var isEditing = false
    @State private var selectedNotes = Set<UUID>()
    @State private var isPresentingAddNote = false
    let categoryName: String

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if isEditing {
                        Button("Done") {
                            isEditing = false
                            selectedNotes.removeAll()
                        }
                        .padding(.leading)
                    } else {
                        Spacer()
                    }

                    Text(categoryName)
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer()

                    // Top right menu with "..." for selecting notes
                    if !isEditing {
                        Menu {
                            Button("Select Notes") {
                                isEditing.toggle()
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .font(.title)
                                .padding(.trailing)
                        }
                    } else {
                        Spacer()
                            .frame(width: 50) // Maintain balance with the "Done" button
                    }
                }

                if viewModel.notesForCategory(categoryName).isEmpty {
                    NoNotesView(categoryName: categoryName)
                } else {
                    List(selection: $selectedNotes) {
                        ForEach(viewModel.notesForCategory(categoryName)) { note in
                            NavigationLink(destination: NotesView(note: note)) {
                                NotesItem(note: note)
                            }
                            .tag(note.id)
                        }
                    }
                    .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
                    .background(Color.green.opacity(0.1)) // Set the list background color to light green
                }

                Spacer()

                // Buttons at the bottom
                HStack {
                    Spacer()

                    if isEditing {
                        if !selectedNotes.isEmpty {
                            Button(action: {
                                deleteSelectedNotes()
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                            }
                            .padding(.trailing, 20)
                        } else {
                            Button(action: {
                                deleteAllNotes()
                            }) {
                                Text("Delete All")
                                    .foregroundColor(.red)
                            }
                            .padding(.trailing, 20)
                            .opacity(isEditing ? 1 : 0.5)
                            .disabled(!isEditing)
                        }
                    } else {
                        NavigationLink(destination: NotesView(note: Note(id: UUID(), categoryName: categoryName, textContent: "", date: DateFormatter().string(from: Date())))) {
                            Text("Add New Note")
                        }
                        .padding(.trailing, 20)
                    }
                }
                .padding(.bottom, 20)
            }
            .background(Color.blue.opacity(0.1))
        }
    }

    // Function to delete all notes
    private func deleteAllNotes() {
        viewModel.deleteAllNotes()
        selectedNotes.removeAll()
    }

    // Function to delete selected notes
    private func deleteSelectedNotes() {
        for id in selectedNotes {
            viewModel.deleteNoteById(id: id)
        }
        selectedNotes.removeAll()
        isEditing = false
    }
}

struct NotesList_Previews: PreviewProvider {
    static var previews: some View {
        NotesList(categoryName: "Sample Category")
            .environmentObject(NotesViewModel())
    }
}
