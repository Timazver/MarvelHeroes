//
//  HeroListViewController.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

class HeroListViewController: UIViewController {
    
    var chatName: String = ""
    
    @IBOutlet weak  var tableView: UITableView!
    
    var viewModel = HeroListViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getAllHeroes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupBindings()
    }
    
    
    func setupBindings() {
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    //TODO: Logging
                    print(message)
                case .serverMessage(let message):
                    //TODO: Logging
                    print(message)
                }
            }, onError: nil, onCompleted: nil, onDisposed:  nil)
        
        viewModel.heroes.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: HeroTableViewCell.self)) {(row, hero, cell) in
            cell.configure(hero: hero)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let cell = self?.tableView.cellForRow(at: indexPath) as? HeroTableViewCell
                self?.chatName = cell?.heroNameLbl.text ?? ""
                self?.forwardToChatVC()
            }).disposed(by:disposeBag)
    }
    
    func forwardToChatVC() {
        guard let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as? ChatViewController else { return }
        vc.chat.name = chatName
        self.present(vc, animated: true, completion: nil)
    }
    
}



