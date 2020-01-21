//
//  HeroProvider.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HeroesManager: HeroesRepository {
    
    var endPoint: EndpointType = FetchHeroesEndpoint()
    private init(){}
    static let shared = HeroesManager()
    
    func getAllHeroes() -> Observable<[Hero]> {
        return Observable.create { observer -> Disposable in
//            if let url = URL(string: BaseApi.BASE_URL+self.endPoint.path) {
            if var urlComponents = URLComponents(string: BaseApi.BASE_URL+self.endPoint.path) {
                let session = URLSession.shared
                var queryItems = [URLQueryItem]()
                urlComponents.percentEncodedQuery = urlComponents.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
                for (key,value) in self.endPoint.httpParameters {
                    queryItems.append(URLQueryItem(name: key, value: value as? String))
                }
                urlComponents.queryItems = queryItems
                var request = URLRequest(url: urlComponents.url!)
                request.httpMethod = self.endPoint.httpMethod.rawValue
                
                for (key,value) in self.endPoint.httpHeaders {
                    request.addValue(value, forHTTPHeaderField: key)
                }
                let task = session.dataTask(with: request) { data, response, error in
                    if let response = response as? HTTPURLResponse {
                        print(response.statusCode)
                        if (200..<300).contains(response.statusCode) {
                            if let data = data {
                                do{
                                    let baseResponse = try JSONDecoder().decode(BaseResponse.self, from: data)
                                    observer.onNext(baseResponse.data.results)
                                } catch let error {
                                    observer.onError(error)
                                }
                                observer.onCompleted()
                            }
                        }
                    }
                }
                task.resume()
            }
            return Disposables.create {
                
            }
        }
    }
    
}
