//
//  MainController.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 06.05.2023.
//

import UIKit
import SnapKit

final class GameController: UIViewController {
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
    private lazy var replaceBtn: UIButton = {
       let btn = UIButton()
        btn.setTitle("Replace", for: .normal)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.backgroundColor = .blue
        btn.addTarget(self, action: #selector(replace), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(collection)
        view.addSubview(replaceBtn)
    }
    
    func layout() {
        collection.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(view.bounds.width - 30)
        }
        replaceBtn.snp.makeConstraints { make in
            make.top.equalTo(collection.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.centerX.equalToSuperview()
        }
    }

}

extension GameController: UICollectionViewDataSource, UICollectionViewDelegate {
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
                let alert = getAlert(win: "Нолик")
                present(alert, animated: true)
            }
        } else {
            cell.configure(with: .cross)
            grid[indexPath.row] = "x"
            turn = !turn
            if isWin() {
                let alert = getAlert(win: "Крестик")
                present(alert, animated: true)
            }
        }
    }
    
    
}

extension GameController {
    func isFree(num: Int) -> Bool{
        return grid[num] == "."
    }
    
    func isWin() -> Bool{
        if grid[0] == grid[1] && grid[1] == grid[2] && grid[2] != "." {
            return true
        }
        if grid[0] == grid[4] && grid[4] == grid[8] && grid[8] != "." {
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
    
    @objc func replace() {
        grid = Array(repeating: ".", count: 9)
        for index in 0..<9 {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = collection.cellForItem(at: indexPath) as! GridCell
            cell.configure(with: .none)
        }
    }
    
    func getAlert(win: String) -> UIAlertController{
        let alert = UIAlertController(title: "Победил \(win)", message: "Еще партию?", preferredStyle: .alert)
        let action = UIAlertAction(title: "Да", style: .default) { _ in
            self.replace()
        }
        alert.addAction(action)
        return alert
    }
}

