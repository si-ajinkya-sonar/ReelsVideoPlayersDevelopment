//
//  ContentViewModel.swift
//  LocalTemplateApp
//
//  Created by Kiran Padhiyar on 18/07/25.
//

import Foundation
import SDUIRenderer

final class ContentViewVM: ObservableObject {
    
    @Published var templates: [[String: Any]] = []
    
    func loadTemplates(filename: String) {
        guard let response = Utilities.loadRawJson(from: filename) as? [String: Any] else {
            return
        }
        // Assuming `json` contains a key "templates"
        if var fetchedTemplates = response["templates"] as? [[String: Any]] {
            // Update the published property
            fetchedTemplates = fetchedTemplates.filter({ (($0["properties"] as? [String: Any])?["presentation_format"] as? String) != "overlay" })
            self.templates = fetchedTemplates
        }
    }
}
