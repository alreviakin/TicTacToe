//
//  PlayerLabel.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 10.05.2023.
//

import UIKit

class PlayerLabel: UILabel {

    convenience init(title: String) {
        self.init()
        self.text = title
        self.font = .systemFont(ofSize: 20)
        self.textAlignment = .center
    }

}
