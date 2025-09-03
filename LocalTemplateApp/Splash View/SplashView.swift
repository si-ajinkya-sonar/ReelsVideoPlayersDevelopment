//
//  SplashView.swift
//  LocalTemplateApp
//
//  Created by Kiran Padhiyar on 18/07/25.
//

import SwiftUI
import SINetworking
import SDUIRenderer

struct RemoteImageView: View {
    let imageURL: URL?

    var body: some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView() // Loading indicator
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
//                    .aspectRatio(1, contentMode: .fill)
            case .failure:
                Image(systemName: "photo") // Fallback image
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct SplashView: View {
    @StateObject private var networkManager = SINetworkManager()
    @StateObject private var themeManager = SDUIThemeManager.shared
    @StateObject private var translationManager = SDUITranslationManager.shared
    
    private let animationDuration: Double = 2.0
    @State private var isLoading = true
    @State private var isAnimationComplete = false
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.0
    
    @StateObject private var viewModel = SplashViewModel()
    
    var body: some View {
        getInitialScreen()
//        VStack {
//            Text("Inter_Bold")
//                .font(.custom("Inter24pt-Bold", size: 24))
//            
//            Text("Inter-Regular_Bold")
//                .font(.custom("Inter-Regular_Bold", size: 24))
//            
//            Text("Inter-Bold")
////                .font(.custom("Inter-Bold", size: 24))
//                .fontWeight(.bold)
//        }
//        VStack {
//            RemoteImageView(imageURL: URL(string: "https://stg-lsg.sportz.io/static-assets/waf-images/da/39/f8/16-9/54T3FrTN0L.jpg"))
//                .frame(width: 343, height: 343)
//        }
        .background(.red)
        .task {
            let success = await viewModel.updateSchema()
            isLoading = !success
            SDUIThemeManager.shared.configureIconography(with: "LSG_Fontello", fontelloFontName: "fontello")
            SDUIThemeManager.shared.initialiseTokens("40b949f1-5800-4025-8395-ed22bd52ccc6")
        }
        .onAppear {
            print("Realm Path: \(SIDataBaseManager.shared.getRealmDBUrlPath() ?? .blank)")
            
            // Start the animation
            withAnimation(.easeOut(duration: animationDuration)) {
                logoScale = 1.0
                logoOpacity = 1.0
            }
            
            // Set animation complete after delay
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
                isAnimationComplete = true
            }
        }
        .environmentObject(networkManager)
        .environmentObject(themeManager)
        .environmentObject(translationManager)
    }
    
    @ViewBuilder
    private func getInitialScreen() -> some View {
        if isLoading && !isAnimationComplete {
            getLoadingView()
        }
        else {
            NavigationStack {
                HomeView()
            }
        }
    }
    
    @ViewBuilder
    private func getLoadingView() -> some View {
        ZStack {
            Color.black.opacity(0.1)
                .edgesIgnoringSafeArea(.all)
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
        }
    }
}

#Preview {
    SplashView()
}
