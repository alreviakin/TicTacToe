//
//  MainController.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 07.05.2023.
//

import UIKit

final class MainController: UIViewController {
    private let labelView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "ticTacToe")
        return imageView
    }()
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Tic Tac Toe"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var playersGameBtn: UIButton = {
        let btn = StandartButton(title: "Игрок")
        btn.addTarget(self, action: #selector(startWithPlayer), for: .touchUpInside)
        return btn
    }()
    private lazy var computerGameBtn: UIButton = {
       let btn = StandartButton(title: "Компьютер")
        btn.addTarget(self, action: #selector(startWithComputer), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    func configure() {
        view.backgroundColor = .white
        
        view.addSubview(labelView)
        view.addSubview(nameLabel)
        view.addSubview(playersGameBtn)
        view.addSubview(computerGameBtn)
    }
    
    func layout() {
        labelView.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.right.equalToSuperview().offset(-100)
            make.height.equalTo(view.bounds.width - 200)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(labelView.snp.bottom).offset(10)

            make.centerX.equalToSuperview()
        }
        playersGameBtn.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        computerGameBtn.snp.makeConstraints { make in
            make.top.equalTo(playersGameBtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
    }
}

@objc extension MainController {
    func startWithPlayer() {
        let vc = GameController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func startWithComputer() {
        let vc = ComplexityController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
