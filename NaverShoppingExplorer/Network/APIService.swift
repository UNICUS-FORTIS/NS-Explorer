//
//  APIService.swift
//  NaverShoppingExplorer
//
//  Created by LOUIE MAC on 2023/09/07.
//

import Foundation

enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    
    func requestData(query: String,
                     start: Int,
                     sort: String,
                     completion: @escaping (Result<Shopping, NetworkError>) -> Void) {
        
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL.naverURL(query: encodedQuery, start: start, sort: sort) else { return }
        var request = URLRequest(url: url)
        
        request.addValue(APIKey.Headers.idKey, forHTTPHeaderField: APIKey.Headers.id)
        request.addValue(APIKey.Headers.secretKey, forHTTPHeaderField: APIKey.Headers.secret)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
                        
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }

            do {
                
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(Shopping.self, from: safeData)
                completion(.success(searchResult))

            } catch {
                
                completion(.failure(.parseError))
                
            }
        }.resume()
    }
}

