//
//  NetworkService.swift
//  Navigation
//
//  Created by Александр Садыков on 09.10.2023.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case unowned
    case decodeError
}

struct NetworkService {
    static func request(for configuration: AppConfiguration) {
        let url = URL(string: configuration.rawValue)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) {data, response, error in
            
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Код ответа: \(httpResponse.statusCode)")
                print("Заголовки: \(httpResponse.allHeaderFields)")
            }
            
            guard let data else {
                print("Нет данных!")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print("Данные получены: \(json)")
            } catch {
                print("Ошибка обработки JSON: \(error.localizedDescription)")
                
            }
        }
        task.resume()
    }
    
    static func request(for urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        let url = URL(string: urlString)!
        let session = URLSession.shared
        let task = session.dataTask(with: url) {data, response, error in
            
            if let error {
                print("Ошибка: \(error.localizedDescription)")
                completion(.failure(.unowned))
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("Код ошибки: \(httpResponse.statusCode)")
                completion(.failure(.unowned))
            }
            
            guard let data else {
                 print("Нет данных!")
                completion(.failure(.unowned))
                return
            }
            do {
                guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
                guard let title = jsonDictionary["title"] as? String else { return }
                completion(.success(title))
            } catch {
                print("Ошибка обработки JSON: \(error.localizedDescription)")
                completion(.failure(.unowned))
            }
        }
        task.resume()
 
    }
    
    static func fetch<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(.unowned))
            }
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    if let data = data {
                        let decoder = JSONDecoder()
                        do {
                            let value = try decoder.decode(T.self, from: data)
                            completion(.success(value))
                        } catch {
                            completion(.failure(.decodeError))
                        }
                    }
                    
                case 404:
                    completion(.failure(.notFound))
                case 505:
                    completion(.failure(.serverError))
                    
                default:
                    assertionFailure("unowned status code = \(response.statusCode)")
                    completion(.failure(.unowned))
                }
            }
        }
        dataTask.resume()
    }

    
}
