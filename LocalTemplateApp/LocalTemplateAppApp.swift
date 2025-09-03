//
//  LocalTemplateAppApp.swift
//  LocalTemplateApp
//
//  Created by Kiran Padhiyar on 18/07/25.
//

import SwiftUI
import ArticleModule
import ShowcaseModule
import ScoreStripModule
import PlayerCardModule
import TableModule
import ReelsModule

@main
struct LocalTemplateAppApp: App {
    
    init() {
        ShowcaseModule.initialize()
        ScoresStripModule.initialize()
        PlayerCardModule.initialize()
        ArticleModule.initialize()
        TableModule.initialize()
        ReelsModule.initialize()
        
        // Check if the font is available
//        for family in UIFont.familyNames {
//            if family == "Inter" {
//                print(family)
//                for name in UIFont.fontNames(forFamilyName: family) {
//                    print(name)
//                }
//            }
//        }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
