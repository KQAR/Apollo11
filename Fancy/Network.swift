//
//  Network.swift
//  FancyExtension
//
//  Created by Jarvis on 2024/5/28.
//

import Foundation

extension URLRequest {
  private static var baseURLStr: String { return "https://v1.hitokoto.cn/" }

  static func quoteFromNet() -> URLRequest {
    .init(url: URL(string: baseURLStr)!)
  }
}

public final class NetworkClient {
  private let session: URLSession = .shared

  enum NetworkError: Error {
    case noData
  }

  func executeRequest(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
    session.dataTask(with: request) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }

      guard let data = data else {
        completion(.failure(NetworkError.noData))
        return
      }

      completion(.success(data))
    }.resume()
  }
}

public struct QuoteService {
  static func getQuote(client: NetworkClient, completion: ((QuoteResItem) -> Void)?) {
    quoteRequest(.quoteFromNet(), on: client, completion: completion)
  }

  private static func quoteRequest(
    _ request: URLRequest,
    on client: NetworkClient,
    completion: ((QuoteResItem) -> Void)?
  ) {
    client.executeRequest(request: request) { result in
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        do {
          let quoteItem = try decoder.decode(QuoteResItem.self, from: data)
          completion?(quoteItem)
        } catch {
          print(error.localizedDescription)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }
}
