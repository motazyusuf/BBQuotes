//
//  ContentView.swift
//  BBQuotes
//
//  Created by Moataz on 18/10/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel(repo: BBRepo())
    @State var production: ProductionEnum = .breakingBad
    @State var index: Int = 0

    var body: some View {
        TabView(selection: $index) {
            Tab("Breaking Bad", systemImage: "tortoise", value: 0) {
                MyTabView(viewModel: viewModel, isBreakingBad: true)
            }
            
            Tab("Better Call Saul", systemImage: "briefcase", value: 1) {
                MyTabView(viewModel: viewModel, isBreakingBad: false)
            }
         }
        .onChange(of: index) {
            index == 0 ? (production = .breakingBad) : (production = .betterCallSaul)
            Task {
                await viewModel.getData(of: production.rawValue)
            }
        }
        .preferredColorScheme(.dark)
           }
}

#Preview {
    HomeView()
}
