//
//  MyTabView.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//
import SwiftUI

struct MyTabView: View {
    @StateObject var viewModel: HomeViewModel
    let isBreakingBad: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image(isBreakingBad ?.breakingbad : .bettercallsaul)
                    .resizable()
                    .frame(
                        width: geo.size.width * 2.7,
                        height: geo.size.height * 1.2
                    )
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)
                
                VStack {
                    Spacer(minLength: 60)
                    
                    VStack{
                        switch viewModel.state {
                            
                        case .initial, .loading:
                            Spacer()
                            ProgressView()
                            Spacer()
                            
                        case .success:
                            
                            Text(" \"\(viewModel.quote?.quote ?? "")\"")
                                .quoteTextModifier()
                            
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: viewModel.character?.images?.last) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    
                                }
                                placeholder: {
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(.gray.opacity(0.3))
                                }
                                .frame(
                                    width: geo.size.width * 0.9,
                                    height: geo.size.height * 0.55
                                )
                                
                                Text("\(viewModel.character?.name ?? "")")
                                    .foregroundStyle(.white)
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(
                                width: geo.size.width * 0.9,
                                height: geo.size.height * 0.55
                            )
                            .clipShape(.rect(cornerRadius: 50))
                            
                                                   Spacer()

                            
                        case .failure:
                            Text("Error")
                            
                        }
                    }
                    
                            
                    Button {
                        Task {
                            await viewModel.getData(of: isBreakingBad ? "Breaking Bad" : "Better Call Saul")
                        }
                    }
                    label: {
                        Text("Get Random Quote")
                            .quoteButtonModifier(isBreakingBad: isBreakingBad)
                    }
                        
                    Spacer(minLength: 100)
                }.frame(width: geo.size.width, height:
                    geo.size.height)
            }
            .frame(
                width: geo.size.width,
                height: geo.size.height
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MyTabView(viewModel: HomeViewModel(repo: BBRepo()), isBreakingBad: false)
        .preferredColorScheme(.dark)
}
