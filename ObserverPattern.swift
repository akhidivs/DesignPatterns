import UIKit

struct TrafficColors {
    static let red = "red"
    static let green = "green"
    static let yellow = "yellow"
}

protocol ObserverProtocol {
    var id: Int {get set}
    func onTrafficColorChange(_ color: String)
}

class VehicleObserver: ObserverProtocol {
    var id: Int
    
    init(_ id: Int) {
        self.id = id
    }
    
    func onTrafficColorChange(_ color: String) {
        switch color {
        case TrafficColors.red:
            debugPrint("Traveller: stop vehicle")
        case TrafficColors.green:
            debugPrint("Traveller: start vehicle")
        default:
            debugPrint("Traveller: slow down vehicle")
        }
    }
}

class VendorObserver: ObserverProtocol {
    var id: Int
    
    init(_ id: Int) {
        self.id = id
    }
    
    func onTrafficColorChange(_ color: String) {
        switch color {
        case TrafficColors.red:
            debugPrint("Vendor: Start selling products")
        case TrafficColors.green:
            debugPrint("Vendor: Move aside and wait for red signal")
        default:
            debugPrint("Vendor: Do nothing")
        }
    }
}

class TrafficLightSubject {
    
    private var color = String()
    
    var trafficLightColor: String {
        get {
            return color
        }
        set {
            color = newValue
            notifyObserver()
        }
    }
    
    private var trafficLightObserver = [ObserverProtocol]()
    
    func addObserver(_ observer: ObserverProtocol) {
        guard trafficLightObserver.contains(where: {$0.id == observer.id}) == false else { return }
        trafficLightObserver.append(observer)
    }
    
    func notifyObserver() {
        trafficLightObserver.forEach({$0.onTrafficColorChange(color)})
    }
    
    func removeObserver(_ observer: ObserverProtocol) {
        trafficLightObserver = trafficLightObserver.filter({$0.id != observer.id})
    }
    
    deinit {
        trafficLightObserver.removeAll()
    }
}

var trafficLightSubject = TrafficLightSubject()
var vehicleObserver1 = VehicleObserver(1)
var vendorObserver1 = VendorObserver(2)

trafficLightSubject.addObserver(vehicleObserver1)
trafficLightSubject.addObserver(vendorObserver1)

trafficLightSubject.trafficLightColor = TrafficColors.red

trafficLightSubject.removeObserver(vendorObserver1)

trafficLightSubject.trafficLightColor = TrafficColors.green


