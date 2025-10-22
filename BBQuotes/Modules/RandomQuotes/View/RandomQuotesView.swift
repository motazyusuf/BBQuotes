import ComposableArchitecture
import SwiftUI

struct RandomQuotesView: View {
    let store: StoreOf<RandomQuotesFeature>
    @State var index = 0
    @State var production: ProductionEnum = .breakingBad
    
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { geo in
                TabView(selection: $index) {
                    QuoteTabView(
                        store: store,
                        backgroundImage: Image(.breakingbad),
                        isBreakingBad: true,
                        production: ProductionEnum.breakingBad.rawValue,
                        geo: geo.size
                    )
                    .tabItem { Label("Breaking Bad", systemImage: "tortoise") }
                    .tag(0)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)

                    
                    QuoteTabView(
                        store: store,
                        backgroundImage: Image(.bettercallsaul),
                        isBreakingBad: false,
                        production: ProductionEnum.betterCallSaul.rawValue,
                        geo: geo.size

                    )
                    .tabItem { Label("Better Call Saul", systemImage: "briefcase") }
                    .tag(1)
                    .toolbarBackgroundVisibility(.visible, for: .tabBar)

                }
            }
            .onAppear {
                viewStore.send(.getData(production.rawValue))

            }
            .onChange(of: index) {
                production = index == 0 ? .breakingBad : .betterCallSaul
                viewStore.send(.getData(production.rawValue))
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    RandomQuotesView(
        store: Store(initialState: RandomQuotesFeature.State()) {
            RandomQuotesFeature()
        }
        
    )
}

