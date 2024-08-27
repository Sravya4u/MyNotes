//
//  LabelSheet.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 26/08/24.
//

import SwiftUI

struct LabelSheet: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: NotesViewModel
    @State private var customLabelName: String = ""
    let categories = ["Recipes", "ToDos", "Household", "Shopping"]

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            viewModel.addNote(categoryName: category)
                            isPresented = false
                        }) {
                            Text(category)
                        }
                    }
                    TextField("Custom", text: $customLabelName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                Button("Add Custom Label") {
                    if !customLabelName.isEmpty {
                        viewModel.addNote(categoryName: customLabelName)
                        customLabelName = ""
                        isPresented = false
                    }
                }
                .disabled(customLabelName.isEmpty)
                .padding()
            }
            .navigationTitle("New Label")
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            })
        }
    }
}

struct LabelSheet_Previews: PreviewProvider {
    static var previews: some View {
        LabelSheet(isPresented: .constant(true), viewModel: NotesViewModel())
    }
}
