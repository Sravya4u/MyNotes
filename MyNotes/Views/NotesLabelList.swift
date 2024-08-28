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

                if viewModel.groupedLabels().isEmpty {
                    NoLabelsView()
                } else {
                    List(selection: $selectedLabels) {
                        ForEach(viewModel.groupedLabels().keys.sorted(), id: \.self) { categoryName in
                            NavigationLink(destination: NotesList(categoryName: categoryName)
                                .environmentObject(viewModel)) {
                                NotesLabelItem(label: categoryName, noteCount: (viewModel.groupedLabels()[categoryName]?.count ?? 0))
                            }
                            .tag(categoryName) // Ensure correct tagging
                        }
                    }
                    .environment(\.editMode, isEditing ? .constant(.active) : .constant(.inactive))
                }

                Spacer()

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
            .background(Color.blue.opacity(0.1))
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

    private func deleteAllLabels() {
        viewModel.deleteAllNotes()
        selectedLabels.removeAll()
    }

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
            .environmentObject(NotesViewModel())
    }
}
