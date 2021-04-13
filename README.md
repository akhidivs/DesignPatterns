# DesignPatterns

We can categorise design patterns into 3 main categories:

1. **Structural Design Patterns:** describes how objects are composed and combined to form larger structures
Eg: MVC, MVVM, Facade etc

2. **Behavioural Design Patterns:** describes how objects communicate with each other
Eg: Delegation, Strategy, Observer etc

3. **Creational Design Pattern:** describes how to create or instantiate objects.
Eg: Builder, Singleton, Prototype etc.


## MVC (Model-View-Controller)

MVC separates objects into three distinct types i.e models, views, and controllers

**Model** - holds application data, usually structs or simple classes

**Views** - display visual elements or controls on the screen

**Controllers** - coordinate between model and views, usually subclasses of UIViewController.

Controllers can own multiple models or views.
Controllers are allowed to have strong properties for their model and views so that they can be accessed directly.

Model and Views should not hold a strong reference to their owning controller. This can cause a retain cycle.

Models communicate to their controller via property observing and view communicate to their controller via IBActions.

This lets you reuse models and views between several controllers.

Controllers are much harder to reuse since their logic is often very specific to whatever task they are doing.


## MVVM (Model-View-ViewModel)

MVVM separates objects into three distinct types i.e models, views, and viewModel.

**Model** - holds application data, usually structs or simple classes

**Views** - display visual elements or controls on the screen

**View Models** - transform model information into values that can be displayed on a view, usually classes so they can be passed around as references.

The role of view controller here is minimized.

Use this pattern when you need to transform models into another representation for a view.



## Delegation Pattern

The delegation pattern enables an object to use another “helper” object to provide data or perform a task rather than do the task itself. This pattern has three parts:


An **object** needing a delegate (delegating Object) - The object that has a delegate. The delegate is usually held as a weak property to avoid a retain cycle where the delegating object retains the delegate, which retains the delegating object.

A **delegate protocol** - which defines the methods a delegate may or should implement

A **delegate** - which is the helper object which implements the delegate protocol.

By relying on a delegate protocol instead of a concrete object, the implementation is much more flexible.

Use this pattern to break up large classes, or create generic reusable components.

Delegation is a design pattern that enables a class to hand off some of its responsibilities to an instance of another class.

Delegates should be a weak properties in the vast majority of use cases.


## Strategy Pattern

The strategy pattern defines a family of interchangeability objects that can be set or switched at runtime.


This pattern has three parts:

The **object** using a strategy - object (View controller in case of iOS) that needs interchangeable behaviour.

The **Strategy protocol** - defines methods that every strategy must implement.

The **strategies** - objects that confirm to the strategy protocol.


	Use the strategy pattern when you have two or more different behaviours that are interchangeable.


```swift
//Without any behavioural pattern
struct Logger {

    enum LogStyle {
        case lowercased
        case uppercased
        case capitalized
    }

    let style: LogStyle

    func log(_ message: String) {
        switch style {
        case .lowercased:
        print(message.lowercased())
        case .uppercased:
        print(message.uppercased())
        case .capitalized:
        print(message.capitalized)
        default:
        print(message)
        }
    }
}

let logger = Logger(style: .lowercased)
logger.log("Hello Akhilesh Mishra")


//
//Using Strategy Pattern
//

//Strategy Protocol
protocol LoggerStrategy {
    func log(_ message: String)
}


//Object Using a Strategy
struct StrategyLogger {

    let strategy: LoggerStrategy

    func log(_ message: String) {
        strategy.log(message)
    }
}

//Family of Strategy Objects
struct LowercaseStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.lowercased())
    }
}

struct UppercaseStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.uppercased())
    }
}

struct CapitalizedStrategy: LoggerStrategy {
    func log(_ message: String) {
        print(message.capitalized)
    }
}

var strategyLogger = StrategyLogger(strategy: LowercaseStrategy())
strategyLogger.log("Hello Devanshika Mishra")

strategyLogger = StrategyLogger(strategy: UppercaseStrategy())
strategyLogger.log("Devanshika needs Akhilesh some day")
```

## Observer Pattern

The Observer pattern lets one object observe changes on another object. You can implement this pattern by using key value observation (KVO) or using an Observable wrapper.

This pattern involves two main objects:

**Subject** - the object that’s being observed

**Observer** - the object doing the observing


Use the observer pattern when you want to receive changes made on another object.

This pattern is often used with MVC, where the ViewController is the Observer and Model is the Subject. This allows the Model to communicate the changes back to the ViewController without needing to know anything about the ViewController’s type.

### Using KVO

```swift
import Foundation

//KVOUser is the NSObject Subject we'll observe
public class KVOUser: NSObject {

    //dynamic means that the dynamic dispatch system is used to call the getter and setter
    @objc dynamic var name: String

    public init(name: String) {
        self.name = name
    }
}

print("-- KVO Example -- ")

let kvoUser = KVOUser(name: "Akhilesh")

//the Observer object
var kvoObserver: NSKeyValueObservation? = kvoUser.observe(\.name, options: [.initial, .new]) { (user, change) in
    print("User’s name is \(user.name)")
}

kvoUser.name = "Vaibhav"
```

The biggest downside of KVO is that you are required to subclass NSObject and use the Objective-C runtime.

If you’re not okay with this you can create your own Observable wrapper to get around these limitations.


## Singleton Pattern

The singleton pattern restricts a class to only one instance. Every reference to the class refers to the same underlying instance. This pattern is extremely common in iOS as apple makes extensive use of it.


Use Singleton pattern when having more than one instance of a class would cause problems, or when it just wouldn’t be logical.


```swift
public class MySingleton {
    public static let shared = MySingleton()
    private init() { }
}

let mySingleton = MySingleton.shared
```

## Memento Pattern (Behavioural)

The memento pattern allows an object to be saved and restored. Its has three parts:




The **Originator** - the object to be saved or restored

The **Memento** - represents a stored state

The **caretaker** - requests a save from the originator and receives a memento in response. The caretaker is responsible for persisting the memento and, later on, providing the memento back to the Originator to restore the originator’s state.

Use the memento pattern whenever you want to save and later restore an object’s state.
