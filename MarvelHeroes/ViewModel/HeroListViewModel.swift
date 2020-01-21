//
//  HeroListViewModel.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation
import RxSwift

class HeroListViewModel {
    public var heroes = PublishSubject<[Hero]>()
    public let loading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<NetworkError> = PublishSubject()
    
    private let disposable = DisposeBag()
    
    func getAllHeroes() {
        HeroesManager.shared.getAllHeroes().subscribe(onNext: { heroesArray in
//            print(heroesArray)
            self.heroes.onNext(heroesArray)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
    }
}
