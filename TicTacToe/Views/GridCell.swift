//
//  GirdCell.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 07.05.2023.
//

import UIKit

enum Symbol {
    case cross
    case circle
    case none
}

class GridCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() {
        contentView.addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(with symbol: Symbol) {
        switch symbol {
        case .cross:
            imageView.image = UIImage(systemName: "multiply")
            imageView.tintColor = .red
        case .circle:
            imageView.image = UIImage(systemName: "circle")
            imageView.tintColor = .black
        case .none:
            imageView.image = nil
        }
    }
}
