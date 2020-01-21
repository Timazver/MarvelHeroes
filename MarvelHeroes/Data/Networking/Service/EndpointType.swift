//
//  EndpointType.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

typealias HTTPHeaders = [String:String]
typealias HTTPParameters = [String:Any]

protocol EndpointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeaders { get }
    var httpParameters: HTTPParameters { get }
}
