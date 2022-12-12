//
//  ViewController.swift
//  Observer
//
//  Created by Артем Галай on 12.12.22.
//

import UIKit

protocol Observer: AnyObject {
    func update(subject: NotificationCenters)
}

class NotificationCenters {
    var state: Int = {
        return Int(arc4random_uniform(10))
    }()

    private lazy var observers = [Observer]()

    func subscribe(_ observer: Observer) {
        print(#function)
        observers.append(observer)
    }

    func unsubscribe(_ observer: Observer) {
        guard let index = observers.firstIndex(where: { $0 === observer } ) else { return }
        observers.remove(at: index)
        print(#function)
    }

    func notify() {
        print(#function)
        observers.forEach({ $0.update(subject: self) })
    }

    func someBusinessLogic() {
        print(#function)
        state = Int(arc4random_uniform(10))
        notify()
    }
}

class ConreteObserverA: Observer {
    func update(subject: NotificationCenters) {
        print("ConreteObserverA \(subject.state)")
    }
}

class ViewController: UIViewController, Observer {

    let notificationCenter = NotificationCenters()
    let observer1 = ConreteObserverA()

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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var subscribeSwitch: UISwitch = {
        let subscribeSwitch = UISwitch()
        subscribeSwitch.tintColor = .green
        subscribeSwitch.addTarget(self, action: #selector(togle), for: .touchUpInside)
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

    func update(subject: NotificationCenters) {
        outOneLabel.text = "State subject: \(subject.state)"
    }

    @objc func buttonTapped() {
        notificationCenter.someBusinessLogic()
    }

    @objc func togle() {
        if subscribeSwitch.isOn {
            notificationCenter.subscribe(self)
            notificationCenter.subscribe(observer1)
        } else {
            notificationCenter.unsubscribe(self)
            notificationCenter.unsubscribe(observer1)
        }
    }
}
