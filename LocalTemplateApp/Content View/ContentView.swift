//
//  ContentView.swift
//  LocalTemplateApp
//
//  Created by Kiran Padhiyar on 18/07/25.
//

import SwiftUI
import SDUIRenderer

struct ContentView: View {
    
    @EnvironmentObject var themeManager: SDUIThemeManager
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject private var viewModel: ContentViewVM = ContentViewVM()
    
    var filename: String
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center, spacing: .zero) {
                    // Check if templates exist in the response and render them
                    if !viewModel.templates.isEmpty {
                        ForEach(viewModel.templates.indices, id: \.self) { index in
                            let templateData = viewModel.templates[index]
                            TemplateRenderer.renderTemplate(
                                templateData: templateData,
                                templateWidth: UIScreen.main.bounds.width,
                                actionHandler: self,
                                selectedFilter: nil,
                                themeManager: themeManager,
                                overlayCallback: { template in
                                    
                                },
                                moveToNextPage: { url in
                                    
                                },
                                onTableFilterChange: { templateId, selectedOption in
                                    
                                }
                            )
                        }
                    }
                }
            }
        }
        .background(UITraitCollection.current.userInterfaceStyle == .dark ? Color(hex: "1A1A1A") : Color.white)
        .onChange(of: colorScheme) { newScheme in
            themeManager.updateColorScheme(newScheme)
        }
        .onAppear {
            viewModel.loadTemplates(filename: filename)
        }
    }
}

extension ContentView: SDUIGenericTemplateActionHandler {
    func handleAction(_ action: SDUIRenderer.SDUITemplateAction) {
        
    }
}
