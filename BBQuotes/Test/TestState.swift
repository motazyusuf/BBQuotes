import ComposableArchitecture

extension TestFeature {
    
    @ObservableState
    struct State: Equatable {
        var isLoading = false
        var counter = 0
        var title = "Test"
    }
}
