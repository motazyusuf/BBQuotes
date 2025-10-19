//
//  ContentView.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

import SwiftUI

struct HomeView: View {
    
    
    @StateObject var viewModel = HomeViewModel(repo: BBRepo())
    
    var body: some View {
        TabView {
            Tab("Breaking Bad", systemImage: "tortoise") {
                
                Text("Breaking Bad")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }

            Tab("Better Call Saul", systemImage: "briefcase") {
                Text("Better Call Saul")
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    HomeView()
}
