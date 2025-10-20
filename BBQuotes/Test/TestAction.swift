import ComposableArchitecture

extension TestFeature {
    
    enum Action: Equatable {
        case onAppear
        case incrementButtonTapped
        case decrementButtonTapped
        case resetButtonTapped
        case loadData
        case dataLoaded
    }
}
