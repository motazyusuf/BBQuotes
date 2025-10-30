//
//  CharacterView.swift
//  BBQuotes
//
//  Created by Moataz on 22/10/2025.
//

import ComposableArchitecture
import SwiftUI

struct CharacterView: View {
    let character: CharacterModel?
    let production: ProductionType?

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                production?.backgroundImage
                    .resizable()
                    .scaledToFit()

                ScrollView {
                    TabView {
                        ForEach(character?.images ?? [], id: \.self) { imageUrl in
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                            }
                            placeholder: {
                                ZStack{
                                    RoundedRectangle(cornerRadius: 0)
                                        .fill(.gray.opacity(0.3))
                                    
                                    ProgressView()
                                }
                              
                            }
                           
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(
                        width: geo.size.width * 0.9,
                        height: geo.size.height * 0.6
                    )
                    .clipShape(.rect(cornerRadius: 50))
                    .padding(.top, 60)

                    VStack(alignment: .leading) {
                        Text("\(character?.name ?? "")")
                            .padding(.top)
                            .font(.largeTitle)

                        Text("Portrayed By: \(character?.portrayedBy ?? "")")
                            .font(.subheadline)

                        Divider()
                    }
                    .frame(width: geo.size.width * 0.8, alignment: .leading)
                }
            }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
}

#Preview {
    CharacterView(
        character: CharacterModel(
            name: "Walter White",
            images: [URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!],
            portrayedBy: "Bryan Cranston"
        ), production: .breakingBad
    )
}
