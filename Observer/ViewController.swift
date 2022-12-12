//
//  ViewController.swift
//  Observer
//
//  Created by Артем Галай on 12.12.22.
//

import UIKit

class ViewController: UIViewController {

    private let outOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Out"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var updateAction: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var subscribeSwitch: UISwitch = {
        let subscribeSwitch = UISwitch()
        subscribeSwitch.tintColor = .green
        subscribeSwitch.translatesAutoresizingMaskIntoConstraints = false
        return subscribeSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(outOneLabel)
        view.addSubview(updateAction)
        view.addSubview(subscribeSwitch)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            outOneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            outOneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),

            updateAction.topAnchor.constraint(equalTo: outOneLabel.bottomAnchor, constant: 100),
            updateAction.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateAction.heightAnchor.constraint(equalToConstant: 40),
            updateAction.widthAnchor.constraint(equalToConstant: 120),

            subscribeSwitch.topAnchor.constraint(equalTo: updateAction.bottomAnchor, constant: 100),
            subscribeSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
