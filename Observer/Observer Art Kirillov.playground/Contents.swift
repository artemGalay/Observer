import UIKit

protocol Observable {
    func add(observer: Observer)
    func remove(observer: Observer)
    func notifyObservers()
}

protocol Observer {

    var id: String { get set }
    func update(value: Int?)
}

final class NewsResources: Observable {

    var value: Int? {
        didSet {
            notifyObservers()
        }
    }

    private var observers = [Observer]()

    func add(observer: Observer) {
        observers.append(observer)
    }

    func remove(observer: Observer) {
        guard let index = observers.enumerated().first(where: { $0.element.id == observer.id })?.offset else { return }
        observers.remove(at: index)
    }

    func notifyObservers() {
        observers.forEach { $0.update(value: value) }
    }
}

final class NewAgency: Observer {

    var id = "newsAgency"

    func update(value: Int?) {
        guard let value = value else { return }
        print("News Agency handle updated value: \(value)")
    }
}

final class Reporter: Observer {

    var id = "reporter"

    func update(value: Int?) {
        guard let value = value else { return }
        print("Reporter updated value: \(value)")
    }
}

final class Blogger: Observer {

    var id = "blogger"

    func update(value: Int?) {
        guard let value = value else { return }
        print("Blogger value: \(value)")
    }
}

let resource = NewsResources()
let newAgency = NewAgency()
let reporter = Reporter()
let blogger = Blogger()

resource.add(observer: newAgency)
resource.add(observer: reporter)

resource.value = 5

resource.add(observer: blogger)

resource.value = 7

resource.remove(observer: reporter)

resource.value = 11
resource.value = 15











