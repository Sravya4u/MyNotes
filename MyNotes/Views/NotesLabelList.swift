//
//  NotesLabelList.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 26/08/24.
//

import SwiftUI

struct NotesLabelList: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var isPresentingLabelSheet = false
    @State private var isEditing = false
    @State private var selectedLabels = Set<UUID>()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    if isEditing {
                        Button("Done") {
                            isEditing = false
                            selectedLabels.removeAll()
                        }
                        .padding(.leading)
                    } else {
                        Spacer()
                    }

                    Text("Labels")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Spacer()
                    
                    // Top right menu with "..." for selecting labels
                    if !isEditing {
                        Menu {
                            Button("Select Labels") {
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

                if viewModel.notes.isEmpty {
                    NoLabelsView()
                } else {
                    List(selection: $selectedLabels) {
                        ForEach(viewModel.notes) { note in
                            NotesLabelItem(label: note.categoryName, noteCount: 1)
                                .tag(note.id)
                        }
                    }
                    .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
                    .background(Color.yellow.opacity(0.01)) // Set the list background color to light green
                    .scrollContentBackground(.hidden) // Ensure the background color is applied
                                    
                }

                Spacer()

                // Buttons at the bottom
                HStack {
                    Spacer()

                    if selectedLabels.isEmpty {
                        Button(action: {
                            deleteAllLabels()
                        }) {
                            Text("Delete All")
                                .foregroundColor(.red)
                        }
                        .padding(.trailing, 20)
                        .opacity(isEditing ? 1 : 0.5)
                        .disabled(!isEditing)
                    } else {
                        Button(action: {
                            deleteSelectedLabels()
                        }) {
                            Text("Delete")
                                .foregroundColor(.red)
                        }
                        .padding(.trailing, 20)
                    }
                }
                .padding(.bottom, 20)
            }
            .background(Color.yellow.opacity(0.1))
            .sheet(isPresented: $isPresentingLabelSheet) {
                LabelSheet(isPresented: $isPresentingLabelSheet, viewModel: viewModel)
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        isPresentingLabelSheet = true
                    }) {
                        Text("Create New Label")
                    }
                    .padding(.leading, 20)
                }
            }
        }
    }

    // Function to delete all labels
    private func deleteAllLabels() {
        viewModel.deleteAllNotes()
        selectedLabels.removeAll()
    }

    // Function to delete selected labels
    private func deleteSelectedLabels() {
        for id in selectedLabels {
            viewModel.deleteNoteById(id: id)
        }
        selectedLabels.removeAll()
        isEditing = false
    }
}

struct NotesLabelList_Previews: PreviewProvider {
    static var previews: some View {
        NotesLabelList()
    }
}
