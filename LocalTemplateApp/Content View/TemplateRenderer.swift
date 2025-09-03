import SwiftUI
import SINetworking
import SDUIRenderer
import ShowcaseModule
import ArticleModule
import ScoreStripModule
import MultiTemplateModule
import PlayerCardModule
import TableModule
import ReelsModule
import SIBoilerPlate

/// A utility struct for rendering SDUI templates in the Lucknow Super Giants app
struct TemplateRenderer {
    
    // MARK: - Template Rendering Functions
    @MainActor @ViewBuilder
    static func renderTemplate(templateData: [String: Any], 
                              templateWidth: CGFloat,
                              actionHandler: SDUIGenericTemplateActionHandler,
                              selectedFilter: [String: String]?,
                              themeManager: SDUIThemeManager,
                              overlayCallback: @escaping ([String: Any]) -> Void,
                              moveToNextPage: @escaping (String) -> Void,
                              onTableFilterChange: ((String, String) -> Void)? = nil) -> some View {
        if let templateType = templateData["content_type"] as? String {
            switch templateType {
            case "showcase":
                let ctx = TemplateContext(
                    templateWidth: templateWidth,
                    actionHandler: actionHandler,
                    hooks: .init(
                        before:  { any in renderBeforeContentView(data: any).erasedToAnyView() },
                        content: { any in renderReplaceContentView(data: any).erasedToAnyView() },
                        after:   { any in renderArticleAfterContentView(data: any, themeManager: themeManager).erasedToAnyView() }
                    ),
                    atomContentView: { pos, id, mol, atom in
                        renderAtomContentView(
                            position: pos,
                            organisamId: id,
                            moleculeName: mol,
                            atomName: atom,
                            themeManager: themeManager
                        ).erasedToAnyView()
                    },
                    filterOption: selectedFilter // optional; used if your reels templates care about filters
                )
                ShowcaseModule.view(data: templateData, context: ctx)
            case "news", "photos", "videos":
                let ctx = TemplateContext(
                    templateWidth: templateWidth,
                    actionHandler: actionHandler,
                    hooks: .init(
                        before:  { any in renderBeforeContentView(data: any).erasedToAnyView() },
                        content: { any in renderReplaceContentView(data: any).erasedToAnyView() },
                        after:   { any in renderArticleAfterContentView(data: any, themeManager: themeManager).erasedToAnyView() }
                    ),
                    atomContentView: { pos, id, mol, atom in
                        renderAtomContentView(
                            position: pos,
                            organisamId: id,
                            moleculeName: mol,
                            atomName: atom,
                            themeManager: themeManager
                        ).erasedToAnyView()
                    },
                    filterOption: selectedFilter // optional; used if your reels templates care about filters
                )
                ArticleModule.view(data: templateData, context: ctx)
            case "fixtures":
                let ctx = TemplateContext(
                    templateWidth: templateWidth,
                    actionHandler: actionHandler,
                    hooks: .init(
                        before:  { any in renderBeforeContentView(data: any).erasedToAnyView() },
                        content: { any in renderReplaceContentView(data: any).erasedToAnyView() },
                        after:   { any in renderArticleAfterContentView(data: any, themeManager: themeManager).erasedToAnyView() }
                    ),
                    atomContentView: { pos, id, mol, atom in
                        renderAtomContentView(
                            position: pos,
                            organisamId: id,
                            moleculeName: mol,
                            atomName: atom,
                            themeManager: themeManager
                        ).erasedToAnyView()
                    },
                    filterOption: selectedFilter // optional; used if your reels templates care about filters
                )
                ScoresStripModule.view(data: templateData, context: ctx)
            case "multi_template":
                let ctx = TemplateContext(
                    templateWidth: templateWidth,
                    actionHandler: actionHandler,
                    hooks: .init(
                        before:  { any in renderBeforeContentView(data: any).erasedToAnyView() },
                        content: { any in renderReplaceContentView(data: any).erasedToAnyView() },
                        after:   { any in renderArticleAfterContentView(data: any, themeManager: themeManager).erasedToAnyView() }
                    ),
                    atomContentView: { pos, id, mol, atom in
                        renderAtomContentView(
                            position: pos,
                            organisamId: id,
                            moleculeName: mol,
                            atomName: atom,
                            themeManager: themeManager
                        ).erasedToAnyView()
                    },
                    filterOption: selectedFilter // optional; used if your reels templates care about filters
                )
                MultiTemplateTabTemplate.view(from: templateData, context: ctx)
            case "webview":
                if let inputUrlValue = getWebviewUrlFromTemplate(templateData: templateData), 
                    let decodedTemplateInformation = SIUtilities.getCodableObject(from: templateData, type: SDUITemplateModel.self) {
                    SIWebView(webViewType: .embeded,
                              webViewUrl: inputUrlValue,
                              contentHeight: .constant(200),
                              isScrollEnabled: false,
                              delegate: nil)
                    .frame(height: 200) // Default height, ContentView will handle actual height calculation
                    .sduiTemplateStyle(style: decodedTemplateInformation.styles)
                }
            case "table":
                VStack(spacing: 0) {
//                    if let templateId = templateData["id"] as? String,
//                       let tags = templateData["tags"] as? [String],
//                       tags.contains("has_player_stats_filter") {
//                        
//                        if let dataDict = templateData["data"] as? [String: Any],
//                           let items = dataDict["items"] as? [[String: Any]] {
//                           
//                            // Extract "name" from each item safely
//                            let filterItemData = items.compactMap { $0["year"] as? String }
//                            
//                            GenericDropDownView(options: filterItemData,
//                                       selectedOption: selectedFilter?[templateId]) { selectedOption in
//                                onTableFilterChange?(templateId, selectedOption)
//                            }
//                                       .id(templateId)
//                        }
//                    }
                    
                    let ctx = TemplateContext(
                        templateWidth: templateWidth,
                        actionHandler: actionHandler,
                        hooks: .init(
                            before:  { any in renderBeforeContentView(data: any).erasedToAnyView() },
                            content: { any in renderReplaceContentView(data: any).erasedToAnyView() },
                            after:   { any in renderArticleAfterContentView(data: any, themeManager: themeManager).erasedToAnyView() }
                        ),
                        atomContentView: { pos, id, mol, atom in
                            renderAtomContentView(
                                position: pos,
                                organisamId: id,
                                moleculeName: mol,
                                atomName: atom,
                                themeManager: themeManager
                            ).erasedToAnyView()
                        },
                        filterOption: selectedFilter // optional; used if your reels templates care about filters
                    )
                    TableModule.view(data: templateData, context: ctx)
                }
                .frame(width: templateWidth)
                
            case "squad", "player_masthead":
                let ctx = TemplateContext(
                    templateWidth: templateWidth,
                    actionHandler: actionHandler,
                    hooks: .init(
                        before:  { any in renderBeforeContentView(data: any).erasedToAnyView() },
                        content: { any in renderReplaceContentView(data: any).erasedToAnyView() },
                        after:   { any in renderArticleAfterContentView(data: any, themeManager: themeManager).erasedToAnyView() }
                    ),
                    atomContentView: { pos, id, mol, atom in
                        renderAtomContentView(
                            position: pos,
                            organisamId: id,
                            moleculeName: mol,
                            atomName: atom,
                            themeManager: themeManager
                        ).erasedToAnyView()
                    },
                    filterOption: selectedFilter // optional; used if your reels templates care about filters
                )
                PlayerCardModule.view(data: templateData, context: ctx)
            case "reels":
//                ReelsModuleTemplateRenderer.getView(data: templateData,
//                                                      templateWidth: templateWidth,
//                                                      actionHandler: actionHandler,
//                                                      beforeContent: { data in
//                    renderBeforeContentView(data: data)
//                },
//                                                      content: { data in
//                    renderReplaceContentView(data: data)
//                },
//                                                      afterContent: { data in
//                    renderArticleAfterContentView(data: data, themeManager: themeManager)
//                },
//                                                      atomContentView: { position, organisamId, moleculeName, atomName in
//                    renderAtomContentView(position: position, organisamId: organisamId, moleculeName: moleculeName, atomName: atomName, themeManager: themeManager)
//                },
//                                                      filterOption: selectedFilter)
                let ctx = TemplateContext(
                    templateWidth: templateWidth,
                    actionHandler: actionHandler,
                    hooks: .init(
                        before:  { any in renderBeforeContentView(data: any).erasedToAnyView() },
                        content: { any in renderReplaceContentView(data: any).erasedToAnyView() },
                        after:   { any in renderArticleAfterContentView(data: any, themeManager: themeManager).erasedToAnyView() }
                    ),
                    atomContentView: { pos, id, mol, atom in
                        renderAtomContentView(
                            position: pos,
                            organisamId: id,
                            moleculeName: mol,
                            atomName: atom,
                            themeManager: themeManager
                        ).erasedToAnyView()
                    },
                    filterOption: selectedFilter // optional; used if your reels templates care about filters
                )
                ReelsModule.view(data: templateData, context: ctx)
            default:
                EmptyView()
            }
        } else {
            EmptyView()
        }
    }
    
    // MARK: - Helper Methods
    static fileprivate func getWebviewUrlFromTemplate(templateData: [String:Any]) -> URL? {
        if let templateData = templateData["data"] as? [String:Any] {
            if let inputTypeValue = templateData["input_value"] as? String {
                guard let url = URL(string: inputTypeValue) else { return nil }
                return url
            }
        }
        return nil
    }
    
    // MARK: - Content View Renderers
    @ViewBuilder
    static func renderAtomContentView(position: ContentViewPosition, organisamId: String, moleculeName: String, atomName: String, themeManager: SDUIThemeManager) -> some View {
        
    }
    
    @ViewBuilder
    static func renderBeforeContentView(data: Any?) -> some View {
        
    }
    
    @ViewBuilder
    static func renderReplaceContentView(data: Any?) -> some View {
        
    }
    
    @ViewBuilder
    static func renderArticleAfterContentView(data: Any?, themeManager: SDUIThemeManager) -> some View {
        
    }
    
    @ViewBuilder
    static func renderAfterContentView(data: Any?, themeManager: SDUIThemeManager) -> some View {
        
    }
    
    @ViewBuilder
    static func renderTableRowAccordionView(data: Any?, themeManager: SDUIThemeManager) -> some View {
        
    }
}
