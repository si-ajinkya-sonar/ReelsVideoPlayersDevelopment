//
//  SplashViewModel.swift
//  LocalTemplateApp
//
//  Created by Kiran Padhiyar on 18/07/25.
//

import Foundation
import SDUIRenderer

class SplashViewModel: ObservableObject {
    
    func updateSchema() async -> Bool {
        guard let response = Utilities.loadJson(from: "sduischema", as: SDUIGenericComposition.self) else {
            return false
        }
        let resetSuccess = await withCheckedContinuation { continuation in
            SIDataBaseManager.shared.resetDatabase(excluding: [
                "SDUIAppMenuRealm", "SDUIAppMenuDetailsRealm", "SDUIAppMenuDataRealm", "SDUIAppMenuModelRealm",
                "SDUITranslationTextRealm", "SDUITranslationDetailsRealm", "SDUITranslationsDataRealm", "SDUITranslationsRealm"
            ]) { success in
                continuation.resume(returning: success)
            }
        }
        
        guard resetSuccess else {
            return false
        }
        
        SIDataBaseManager.shared.saveUpdate(SDUIRendererDataManager.shared.mapToRealm(from: response))
        
        return true
    }
}
