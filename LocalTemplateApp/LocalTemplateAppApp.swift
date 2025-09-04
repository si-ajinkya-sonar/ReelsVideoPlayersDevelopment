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
        
        ReelsModuleConfig.configure(brightcove: ReelsBrightcoveCredentials(accountId: "5420904993001",
                                                                           policyKey: "BCpkADawqM3DwCTPGyMMiG0loem8lXox3utO1lFEP1i-_l1MpjRSVXMTSsa2ToslC129_W6YzwJpXbpbIVRFwf35qYM0pxo2HJK-_SotgmgrkmJTQ-024GkXIelVSY8LOHZzRBtcBU57M6Is"))
        
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
