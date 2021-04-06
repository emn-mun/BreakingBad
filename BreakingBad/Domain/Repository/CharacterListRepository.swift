//
//  CharacterListRepository.swift
//  BreakingBad
//
//  Created by Emanuel Munteanu on 17/11/2020.
//

import Foundation

protocol CharacterListRepositoryProtocol {
    func fetchCharacters(completion: @escaping (Result<[CharacterModel], Error>) -> Void)
}

final class CharacterListRepository: CharacterListRepositoryProtocol {
    func fetchCharacters(completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        do {
          let request = Request<[CharacterModel]>.get(at: "/api/characters", output: Request.Output.json)
          let api = API(scheme: "https", host: "breakingbadapi.com")
            try api.result(for: request, completion: completion)
        } catch {
            return completion(.failure(NetworkError.apiRequestFailed))
        }
    }
}

enum NetworkError: Error {
  case apiRequestFailed
  
  var localizedDescription: String {
    switch self {
    case .apiRequestFailed:
      return "Request Failed"
    }
  }
}

