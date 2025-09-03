//
//  HomeView.swift
//  LocalTemplateApp
//
//  Created by Kiran Padhiyar on 25/07/25.
//

import SwiftUI
import ArticleModule

struct HomeView: View {
    var body: some View {
        List {
            NavigationLink {
                ContentView(filename: "NewsListing")
            } label: {
                Text("News Listing")
                    .padding(.all, 8)
            }
            
            NavigationLink {
                ContentView(filename: "NewsDetails")
            } label: {
                Text("News Details")
                    .padding(.all, 8)
            }
            
            NavigationLink {
                ContentView(filename: "PhotosListingGrid")
            } label: {
                Text("Photos Grid Listing")
                    .padding(.all, 8)
            }
            
            NavigationLink {
                ContentView(filename: "PhotosListing")
            } label: {
                Text("Photos Listing")
                    .padding(.all, 8)
            }
            
            NavigationLink {
                ContentView(filename: "PhotosDetails")
            } label: {
                Text("Photos Details")
                    .padding(.all, 8)
            }
            
            NavigationLink {
                ContentView(filename: "VideosListing")
            } label: {
                Text("Videos Listing")
                    .padding(.all, 8)
            }
            
            NavigationLink {
                ReelsContentView(filename: "homepage-vertical")
            } label: {
                Text("Reels-Verical")
                    .padding(.all, 8)
            }
            
            NavigationLink {
                ReelsContentView(filename: "homepage-horizontal")
            } label: {
                Text("Reels-Horizontal")
                    .padding(.all, 8)
            }
        }
        .onAppear {
            PaginationCacheManager.shared.clear()
        }
        .navigationTitle("Home")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HomeView()
}
