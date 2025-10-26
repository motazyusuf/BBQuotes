import ComposableArchitecture
import SwiftUI

struct RandomQuotesView: View {
    let store: StoreOf<RandomQuotesFeature>
    @State private var selectedTab: ProductionType = .breakingBad

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            GeometryReader { geo in
                TabView(selection: $selectedTab) {
                    
                    ForEach(ProductionType.allCases)  { item in
                        QuoteTabView(
                            store: store,
                            backgroundImage: item.backgroundImage,
                            production: item,
                            geo: geo.size
                        )
                        .tabItem {
                            Label(item.rawValue, systemImage: item.tabIcon)
                        }
                        .toolbarBackgroundVisibility(.visible, for: .tabBar)
                        .onAppear {
                            viewStore.send(.getData(item.rawValue))
                        }
                        .onChange(of: selectedTab) {
                            viewStore.send(.getData(selectedTab.rawValue))
                        }

                    }

                }
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
