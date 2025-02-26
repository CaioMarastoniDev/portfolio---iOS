//
//  DummyViewController.swift
//  Bankey
//
//  Created by Caio Marastoni on 26/02/25.
//

import UIKit

class DummyViewController: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let logoutButtom = UIButton(type: .system)
    
    weak var logouDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
}

extension DummyViewController {
    
    func style() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello!"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        logoutButtom.translatesAutoresizingMaskIntoConstraints = false
        logoutButtom.configuration = .filled()
        logoutButtom.setTitle("Logout", for: [])
        logoutButtom.addTarget(self, action: #selector(logoutTapped), for: .primaryActionTriggered)
    }
    
    func layout() {
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(logoutButtom)
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func logoutTapped(sender: UIButton) {
        logouDelegate?.didLogout()
    }
    
}
