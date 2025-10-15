//
//  MovieSheetViewModel.swift
//  Megabox
//
//  Created by 권예원 on 10/13/25.
//

import SwiftUI
import Combine

class MovieSheetViewModel : ObservableObject {
    let movies:[Movie]
    
    @Published var query:String = ""
    @Published var results: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var bag = Set<AnyCancellable>()
    
    init(movies:[Movie]){
        self.movies = movies
        $query
            .debounce(for: .milliseconds(400), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: {[weak self] _ in
                self?.errorMessage = nil
            })
            .flatMap { query in
                self.search(query: query)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let err) = completion {
                    self?.errorMessage = "검색 실패: \(err.localizedDescription)"
                    self?.results = []
                }
            } receiveValue: { [weak self] items in
                self?.results = items
            }
            .store(in: &bag)
    }
    
    func search(query:String) -> AnyPublisher<[Movie],Error> {
        return Future<[Movie], Error> { [weak self] promise in
            let delay = Double(Int.random(in: 300...700)) / 1000.0
            guard let self else { return }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                let filtered = self.movies.filter { $0.title.lowercased().contains(query) }
                promise(.success(filtered))
            }
        }
        .handleEvents(
            receiveSubscription: { _ in
                DispatchQueue.main.async {
                    self.isLoading = true
                }
            },
            receiveCompletion: { _ in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        )
        .eraseToAnyPublisher()
    }
}

