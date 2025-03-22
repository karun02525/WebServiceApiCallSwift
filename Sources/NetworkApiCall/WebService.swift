//
//  WebService.swift
//  PetAdoption
//
//  Created by Kumar, Karun (893) (EXT) on 22/03/25.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
        case invalidResponse
        case decodingError
        case unknownError
}

public class WebService {
    
    public init() {}
    
    public func fetch<T: Codable>(
        url: URL,
        parse: @escaping (Data) throws -> T,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for network errors
            if let error = error {
                completion(.failure(.unknownError))
                return
            }
            
            // Check for valid HTTP response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Check for valid data
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // Parse the data
            do {
                let result = try parse(data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
