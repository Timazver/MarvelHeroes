//
//  BaseApi.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

struct BaseApi {
    static let BASE_URL = "https://gateway.marvel.com"
    static var httpHeaders:HTTPHeaders = ["Content-Type":"application/json"]
    static var httpParameters:HTTPParameters = ["apikey":"b039053a00cf9ab18fbbbda4a77606cb", "ts":"1", "hash":"75b8618d3fb646a98ee37ba47297a45f"]
}
