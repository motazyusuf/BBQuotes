import ComposableArchitecture
import SwiftUI

struct TestView: View {
    let store: StoreOf<TestFeature>
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if store.isLoading {
                    ProgressView("Loading...")
                } else {
                    Text("Counter: \(store.counter)")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 15) {
                        Button {
                            store.send(.decrementButtonTapped)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .font(.title)
                        }
                        
                        Button {
                            store.send(.incrementButtonTapped)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                        }
                    }
                    
                    Button("Reset") {
                        store.send(.resetButtonTapped)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle(store.title)
            .onAppear {
                store.send(.onAppear)
            }
        }
    }
}

#Preview {
    TestView(
        store: Store(initialState: TestFeature.State()) {
            TestFeature()
        }
    )
}
