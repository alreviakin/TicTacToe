//
//  MainController.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 06.05.2023.
//

import UIKit
import SnapKit

final class MainController: UIViewController {
    private var grid: [String] = Array(repeating: ".", count: 9)
    private var turn: Bool = true
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.itemSize = CGSize(width: (self.view.bounds.width - 6) / 3 - 10, height: (self.view.bounds.width - 6) / 3 - 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(GridCell.self, forCellWithReuseIdentifier: "cell")
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GridCell
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isFree(num: indexPath.row) else {return}
        let cell = collectionView.cellForItem(at: indexPath) as! GridCell
        if turn {
            cell.configure(with: .circle)
            grid[indexPath.row] = "0"
            turn = !turn
            if isWin() {
                print("Win")
            }
        } else {
            cell.configure(with: .cross)
            grid[indexPath.row] = "x"
            turn = !turn
            if isWin() {
                print("Win")
            }
        }
    }
    
    
}

extension MainController {
    func isFree(num: Int) -> Bool{
        return grid[num] == "."
    }
    
    func isWin() -> Bool{
        if grid[0] == grid[1] && grid[1] == grid[2] && grid[2] != "." {
            return true
        }
        if grid[0] == grid[4] && grid[4] == grid[2] && grid[2] != "." {
            return true
        }
        if grid[0] == grid[3] && grid[3] == grid[6] && grid[6] != "." {
            return true
        }
        if grid[1] == grid[4] && grid[4] == grid[7] && grid[7] != "." {
            return true
        }
        if grid[2] == grid[4] && grid[4] == grid[6] && grid[6] != "." {
            return true
        }
        if grid[2] == grid[5] && grid[5] == grid[8] && grid[8] != "." {
            return true
        }
        if grid[3] == grid[4] && grid[4] == grid[5] && grid[5] != "." {
            return true
        }
        if grid[6] == grid[7] && grid[7] == grid[8] && grid[8] != "." {
            return true
        }
        return false
    }
}

