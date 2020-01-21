//
//  FetchHeroesEndpoint.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

class FetchHeroesEndpoint: EndpointType {
    var path: String = "/v1/public/characters"
    var httpMethod: HTTPMethod = .get
    var httpHeaders: HTTPHeaders = BaseApi.httpHeaders
    var httpParameters: HTTPParameters =  BaseApi.httpParameters
}
