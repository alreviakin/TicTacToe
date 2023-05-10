//
//  PointLabel.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 10.05.2023.
//

import UIKit

class PointLabel: UILabel {

    convenience init(title: String) {
        self.init()
        self.text = title
        self.font = .boldSystemFont(ofSize: 30)
        self.textAlignment = .center
    }

}
