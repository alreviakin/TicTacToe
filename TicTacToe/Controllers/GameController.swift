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
    private var firstPlayer: String = "0"
    private var secondPlayer: String = "x"
    private var countTurn: Int = 0
    private var isFirstTurn = true
    private var isAIMove = true
    private var isFinish = false
    private var goodFirstTurn = [0, 2, 4, 6, 8]
    private var aiPlayer = AIPlayer(aiPlayer: "0", humPlayer: "x")
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Tic Tac Toe"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.itemSize = CGSize(width: (self.view.bounds.width - 6) / 3 - 10, height: (self.view.bounds.width - 6) / 3 - 10)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(GridCell.self, forCellWithReuseIdentifier: "cell")
        collection.backgroundColor = .black
        return collection
    }()
    private lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrowshape.left"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return btn
    }()
    private var complexity: Complexity?
    private lazy var countPointFirstPlayer = 0
    private lazy var countPointSecondPlayer = 0
    private lazy var firstCountPlaerLabel:UILabel = {
        let label = PointLabel(title: "\(countPointFirstPlayer)")
        return label
    }()
    private lazy var secondCountPlaerLabel:UILabel = {
        let label = PointLabel(title: "\(countPointSecondPlayer)")
        return label
    }()
    private var firstImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(systemName: "circle")
        imageView.tintColor = .black
        return imageView
    }()
    private lazy var firstNamePlayerLabel: UILabel = {
        let label = PlayerLabel(title: "Player1")
        return label
    }()
    private lazy var firstNameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstImageView, firstNamePlayerLabel])
        stack.axis = .horizontal
        stack.alignment =  .leading
        stack.spacing = 3
        stack.distribution = .fill
        return stack
    }()
    private lazy var secondNamePlayerLabel: UILabel = {
        let label = PlayerLabel(title: "Player2")
        label.addSubview(secondImageView)
        return label
    }()
    private var secondImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        imageView.image = UIImage(systemName: "multiply")
        imageView.tintColor = .red
        return imageView
    }()
    private lazy var secondNameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secondImageView, secondNamePlayerLabel])
        stack.axis = .horizontal
        stack.alignment =  .leading
        stack.spacing = 3
        stack.distribution = .fill
        return stack
    }()
    private lazy var verticalFirstStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstNameStack, firstCountPlaerLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 40
        return stack
    }()
    private lazy var verticalSecondStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [secondNameStack, secondCountPlaerLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        return stack
    }()
    private lazy var pointsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [verticalFirstStack, verticalSecondStack])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if complexity != nil {
            firstTurn()
        }
    }
    
    private func firstTurn() {
        let firstTurn = goodFirstTurn.randomElement()!
        let indexPath = IndexPath(row: firstTurn, section: 0)
        let cell = collection.cellForItem(at: indexPath) as? GridCell
        cell?.configure(with: .circle)
        turn = !turn
        grid[firstTurn] = "0"
        countTurn += 1
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(collection)
        view.addSubview(cancelBtn)
        view.addSubview(pointsStack)
    }
    
    private func layout() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.width.equalTo(30)
        }
        cancelBtn.imageView!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        pointsStack.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(100)
        }
        collection.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(pointsStack.snp.bottom).offset(20)
            make.height.width.equalTo(view.bounds.width - 30)
        }
    }
    
    func setComplexity(complexity: Complexity, name: String) {
        self.complexity = complexity
        self.firstNamePlayerLabel.text = name
        self.secondNamePlayerLabel.text = "Player"
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
        guard isAIMove else {return}
        let cell = collectionView.cellForItem(at: indexPath) as! GridCell
        if turn {
            cell.configure(with: .circle)
            grid[indexPath.row] = "0"
            turn = !turn
            countTurn += 1
            if isWin() {
                winning(currentTurn: "0")
                isFinish = false
                return
            }
        } else {
            cell.configure(with: .cross)
            grid[indexPath.row] = "x"
            turn = !turn
            countTurn += 1
            if isWin() {
                winning(currentTurn: "x")
                isFinish = false
                return
            }
        }
        
        guard grid.contains(".") else {
            replace()
            return
            
        }
        guard complexity != nil else {return}
        isAIMove = false
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.aiMove()
        }
        
    }
    
    func winning(currentTurn: String) {
        if currentTurn == firstPlayer {
            countPointFirstPlayer += 1
            firstCountPlaerLabel.text = "\(countPointFirstPlayer)"
        } else {
            countPointSecondPlayer += 1
            secondCountPlaerLabel.text = "\(countPointSecondPlayer)"
        }
        replace()
    }
    
    private func aiMove() {
        let remains = isFirstTurn ? 0 : 1
        if countTurn % 2 == remains  && complexity != nil && !isFinish{
            var result = 0
            switch complexity {
            case .easy:
                result = aiPlayer.easyMove(grid: grid)
            case .normal:
                result = aiPlayer.normalMove(grid: grid)
            case .impossible:
                result = aiPlayer.impossibleMove(grid: grid, player: isFirstTurn ? "0" : "x")
            case .none:
                break
            }
            let indPath = IndexPath(row: result, section: 0)
            let cellAI = collection.cellForItem(at: indPath) as! GridCell
            cellAI.configure(with: isFirstTurn ? .circle : .cross)
            grid[indPath.row] = isFirstTurn ? "0" : "x"
            turn = !turn
            countTurn += 1
            if isWin() {
                winning(currentTurn: isFirstTurn ? "0" : "x")
            }
        }
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            guard self.grid.contains(".") else {
                self.replace()
                return
            }
        }
        isAIMove = true
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
        turn = true
        countTurn = 0
        isFirstTurn = !isFirstTurn
        isFinish = false
        isAIMove = true
        (firstPlayer, secondPlayer) = (secondPlayer, firstPlayer)
        if firstPlayer == "0" {
            firstImageView.image = UIImage(systemName: "circle")
            firstImageView.tintColor = .black
            secondImageView.image = UIImage(systemName: "multiply")
            secondImageView.tintColor = .red
        } else {
            firstImageView.image = UIImage(systemName: "multiply")
            firstImageView.tintColor = .red
            secondImageView.image = UIImage(systemName: "circle")
            secondImageView.tintColor = .black
        }
        aiPlayer = AIPlayer(aiPlayer: isFirstTurn ? "0" : "x", humPlayer: isFirstTurn ? "x" : "0")
        for index in 0..<9 {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = collection.cellForItem(at: indexPath) as! GridCell
            cell.configure(with: .none)
        }
        if complexity != nil && isFirstTurn{
            firstTurn()
        }
    }
    
    @objc func cancel() {
        dismiss(animated: true)
    }
    
    func returnMainController() {
        dismiss(animated: true)
    }
}

