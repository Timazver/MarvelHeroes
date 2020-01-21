//
//  HeroRepository.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation
import RxSwift

protocol HeroesRepository {
    func getAllHeroes() -> Observable<[Hero]> 
}
