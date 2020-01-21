//
//  HeroTableViewCell.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import UIKit
import SDWebImage

class HeroTableViewCell: UITableViewCell {
    
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var heroNameLbl: UILabel!
    
    func configure(hero: Hero?) {
        changeImageViewStyle()
        guard let hero = hero else { return }
        self.heroNameLbl.text! = hero.name
        guard let thumbnail = hero.thumbnail else { return }
        guard let url = URL(string: thumbnail.fileUrl) else { return }
        print(url)
        heroImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "default_hero_image"))
    }
    
    private func changeImageViewStyle() {
        self.heroImageView.layer.cornerRadius = self.heroImageView.frame.width / 2
        self.heroImageView.clipsToBounds = true
    }
}
