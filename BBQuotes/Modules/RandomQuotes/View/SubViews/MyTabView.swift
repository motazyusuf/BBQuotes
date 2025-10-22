//
//  MyTabView.swift
//  BBQuotes
//
//  Created by Moataz on 19/10/2025.
//
import ComposableArchitecture
import SwiftUI

struct QuoteTabView: View {
    let store: StoreOf<RandomQuotesFeature>
    let backgroundImage: Image
    let isBreakingBad: Bool
    let production: String
    let geo: CGSize
    @State var isSheetShown = false

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                backgroundImage
                    .resizable()
                    .frame(
                        width: geo.width * 2.7,
                        height: geo.height * 1.2
                    )
                    
                VStack {
                    Spacer(minLength: 60)
                        
                    VStack {
                        if viewStore.isLoading {
                            Spacer()
                            ProgressView()
                            Spacer()
                        } else if let quote = viewStore.quote,
                                  let character = viewStore.character
                            
                        {
                            Text(" \"\(quote.quote ?? "")\"")
                                .quoteTextModifier()
                                .frame(maxWidth: .infinity)
 
                            ZStack(alignment: .bottom) {
                                AsyncImage(url: character.images?.last) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                }
                                placeholder: {
                                    RoundedRectangle(cornerRadius: 50)
                                        .fill(.gray.opacity(0.3))
                                }
                                .frame(
                                    width: geo.width * 0.9,
                                    height: geo.height * 0.6
                                )
                                .onTapGesture {
                                    isSheetShown.toggle()
                                }
                                    
                                Text("\(character.name ?? "")")
                                    .foregroundStyle(.white)
                                    .padding(6)
                                    .frame(maxWidth: .infinity)
                                    .background(.ultraThinMaterial)
                            }
                            .frame(
                                width: geo.width * 0.9,
                                height: geo.height * 0.6
                            )
                            .clipShape(.rect(cornerRadius: 50))
                        }
                            
                        else if let error = viewStore.error {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()

                    Button {
                        viewStore.send(
                            .getData(production)
                        )
                    }
                    label: {
                        Text("Get Random Quote")
                            .quoteButtonModifier(isBreakingBad: isBreakingBad)
                    }
                        
                    Spacer(minLength: 100)
                }
                .frame(width: geo.width, height:
                    geo.height)
            }
            .frame(
                width: geo.width,
                height: geo.height
            )
            
            .preferredColorScheme(.dark)
            .sheet(isPresented: $isSheetShown) {
                CharacterView(character: store.character, isBreakingBad: isBreakingBad)
            }
        }
    }
}

#Preview {
    QuoteTabView(store: Store(
        initialState: RandomQuotesFeature.State()
    ) {
        RandomQuotesFeature()
    }, backgroundImage: Image(.breakingbad), isBreakingBad: true, production: "Breaking Bad", geo: CGSize(width: 393, height: 852))
}
