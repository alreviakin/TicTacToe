//
//  ComplexityController.swift
//  TicTacToe
//
//  Created by Алексей Ревякин on 09.05.2023.
//

import UIKit
enum Complexity {
    case easy
    case normal
    case impossible
}

final class ComplexityController: UIViewController {
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Tic Tac Toe"
        label.font = .systemFont(ofSize: 40)
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    private lazy var easyBtn: UIButton = {
       let btn = StandartButton(title: "EASY")
        btn.addTarget(self, action: #selector(chooseComplexity), for: .touchUpInside)
        return btn
    }()
    private lazy var normalBtn: UIButton = {
       let btn = StandartButton(title: "NORMAL")
        btn.addTarget(self, action: #selector(chooseComplexity), for: .touchUpInside)
        return btn
    }()
    private lazy var impossibleBtn: UIButton = {
       let btn = StandartButton(title: "IMPOSSIBLE")
        btn.addTarget(self, action: #selector(chooseComplexity), for: .touchUpInside)
        return btn
    }()
    private lazy var btns = [easyBtn, normalBtn, impossibleBtn]
    private var stack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        return stack
    }()
    private lazy var cancelBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrowshape.left"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        view.addSubview(nameLabel)
        view.addSubview(stack)
        for btn in btns {
            stack.addArrangedSubview(btn)
        }
        view.addSubview(cancelBtn)
    }
    
    private func layout() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.centerX.equalToSuperview()
        }
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        for btn in btns {
            btn.snp.makeConstraints { make in
                make.width.equalTo(200)
            }
        }
        cancelBtn.snp.makeConstraints { make in
            make.left.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.width.equalTo(30)
        }
        cancelBtn.imageView!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

@objc extension ComplexityController {
    private func chooseComplexity(sender: UIButton) {
        let vc = GameController()
        if sender == easyBtn {
            vc.setComplexity(complexity: .easy, name: "Easy")
        } else if sender == normalBtn {
            vc.setComplexity(complexity: .normal, name: "Normal")
        } else if sender == impossibleBtn {
            vc.setComplexity(complexity: .impossible, name: "Impossible")
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func cancel() {
        dismiss(animated: true)
    }
}
