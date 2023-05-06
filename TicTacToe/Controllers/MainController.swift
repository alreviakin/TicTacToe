//
//  MainController.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 06.05.2023.
//

import UIKit
import SnapKit

final class MainController: UIViewController {
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.itemSize = CGSize(width: (self.view.bounds.width - 6) / 3 - 10, height: (self.view.bounds.width - 6) / 3 - 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .cyan
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(collection)
    }
    
    func layout() {
        collection.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(view.bounds.width - 30)
        }
    }

}

extension MainController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    
}

