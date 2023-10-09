//
//  NetworkService.swift
//  Navigation
//
//  Created by Александр Садыков on 09.10.2023.
//

import Foundation

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
}
