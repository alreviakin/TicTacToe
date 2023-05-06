//
//  LineView.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 06.05.2023.
//

import UIKit

class LineView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        conf()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        conf()
    }
    
    func conf() {
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }

}
