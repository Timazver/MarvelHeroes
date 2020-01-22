//
//  HeroTableViewCell.swift
//  MarvelHeroes
//
//  Created by tima on 1/15/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
import UIKit

protocol MessageCell: class {
  var message: Message? { get set }
  var showsAvatar: Bool { get set }
}
