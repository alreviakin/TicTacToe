//
//  StandartButton.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 09.05.2023.
//

import UIKit

class StandartButton: UIButton {
    
    convenience init(title: String) {
        self.init()
        self.backgroundColor = .black
        self.setTitleColor(.white, for: .normal)
        self.setTitle(title, for:.normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.titleLabel?.font = .systemFont(ofSize: 20)
    }

}
