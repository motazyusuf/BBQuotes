import ComposableArchitecture
import Foundation

@Reducer
struct TestFeature {
    
    // MARK: - Dependencies
    @Dependency(\.continuousClock) var clock
    
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.loadData)
                
            case .incrementButtonTapped:
                state.counter += 1
                return .none
                
            case .decrementButtonTapped:
                state.counter -= 1
                return .none
                
            case .resetButtonTapped:
                state.counter = 0
                return .none
                
            case .loadData:
                state.isLoading = true
                return .run { send in
                    try await clock.sleep(for: .seconds(1))
                    await send(.dataLoaded)
                }
                
            case .dataLoaded:
                state.isLoading = false
                return .none
            }
        }
    }
}
