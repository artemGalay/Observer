import UIKit

//
//  Observer MadiSpace.swift
//  Observer
//
//  Created by Артем Галай on 12.12.22.
//

import Foundation

//MARK: - Тип, которому должны соответсвовать все наблюдатели

protocol ObserverSecond {
    func getNew(video: String)
}
//MARK: - Тип, которому соответсвует наблюдаемый субъект

protocol Subject {
    func add(observer: ObserverSecond)
    func remove(observer: ObserverSecond)
    func notification(video: String)
}

//MARK: - Класс субъекта

class Blogger: Subject {

    var observers = NSMutableSet()

    var video: String = "" {
        didSet {
            notification(video: video)
        }
    }

    func add(observer: ObserverSecond) {
        observers.add(observer)
    }

    func remove(observer: ObserverSecond) {
        observers.remove(observer)
    }

    func notification(video: String) {
        observers.forEach({ ($0 as? ObserverSecond)?.getNew(video: video) })
    }
}

//MARK: - Классы наблюдателей

class Subscriber: NSObject, ObserverSecond {

    var nickName: String

    init(nickName: String) {
        self.nickName = nickName
    }

    func getNew(video: String) {
        print("Пользователь \(nickName) получил новое видео \(video)")
    }
}

class Google: NSObject, ObserverSecond {

    func getNew(video: String) {
        print("Видео \(video) обрабатывается")
    }
}

let vasya = Subscriber(nickName: "Vasya")
let fedya = Subscriber(nickName: "Fedya")
let google = Google()

var vlad = Blogger()
vlad.add(observer: vasya)
vlad.add(observer: fedya)
vlad.add(observer: google)

vlad.video = "First video"

vlad.remove(observer: fedya)

vlad.video = "Second video"


