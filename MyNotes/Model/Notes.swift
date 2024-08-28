//
//  Notes.swift
//  MyNotes
//
//  Created by Sravya Chandrapati on 26/08/24.
//

import Foundation

struct Note: Identifiable, Codable {
    var id: UUID
    var categoryName: String
    var textContent: String
    var date: String

    init(id: UUID = UUID(), categoryName: String, textContent: String, date: String) {
        self.id = id
        self.categoryName = categoryName
        self.textContent = textContent
        self.date = date
    }
}


