![Supports iOS](https://img.shields.io/badge/iOS-Supported-blue.svg)
![Supports macOS](https://img.shields.io/badge/macOS-Supported-blue.svg)

# The Modern Swift Template

## Welcome

What do projects from inspiring tech-companies such as Spotify, Snapchat, Block (Square) etc. have in common?

They don't just follow "known best practises". Instead, they come up with their own architecture and frameworks to better support their needs.

This requires a deep understanding of both the requirements of the project and the core principles of building high-quality software. 

The true value lies in the latter:

By truly understanding those engineering principles, you will be able to more acurately evaluate both new and existing paradigms, resulting in improved decision making, 
innovate effectively in your field, ...,
address issues at their root cause, ... and outlast any technology change. 

In this project, we will explore these principles, encouraging you to think critically about conventional best practices and how they can be adapted or even completely rethought to get closer to our global maximum.

## Triangle of Trade-offs / The Challange
## Balancing the Trade-offs
## Maximising xxx
## Pyramid yyy

The aim is to build up as many of those attributes, 
The aim is to build a system that encompasses attributes,

"Priorities" are choosen

#### 1. Simplicity

Personally, if there is one thing I value the most, it's  simplicity.

Simple means less mistakes, more joy, easier to maintain, 

All together providing the foundation for a efficient and enjoyable development experience ...

**Thread/Risk**

it starts simple and grows in complexity over time

#### 2. Modularity (Independent/Loosely coupled)

If something is modular, it's usually more flexible and expands more easily (Adaptability)

More granular increases the chances for reusabilty.

**thread/risk:**

 threatening simplicity, by ... This can be avoid by ...


#### 3. Cohesivness / Consistency
 
Change is pain.

..

#### 4. Testability

Based on all the previous attributes, chancer are good we have build a system that is easily testable.
However to imphasis on the importance of testable code, it's listed as it's own point.

#### 5. Scalability (vertically and horizontally)

...

// Summary

Any project that lifes up to those attributes, 

So it's not about the architecture you choose, but the attributes it will provide.

## Use case: Todo App

**Glosary**
- View
- Loop
- 

Leverages the power of the following frameworks

- [SwiftDependencyContainer](https://github.com/davidscheutz/SwiftDependencyContainer) Code generation powered depdency management
- [SwiftCopy](https://github.com/davidscheutz/SwiftCopy) Convenient copy functionality for immutable structs to ensure thread safety
- [SwiftUDF](https://github.com/davidscheutz/SwiftUDF) Binding SwiftUI views with a uni-directional data flow architecture
- [SwiftEvolution](https://github.com/davidscheutz/SwiftEvolution) Set of useful Swift extensions

...

```swift
struct LoginView: View, BindableView {
    
    let state: State
    let handler: (Event) -> Void

    var body: some View { ... }
}
```

```swift
/// @State(LoginView)
struct LoginState: Inputable, Copyable {
    let inputs: [Input]
    let isLoading: Bool
    let error: String?
}

/// @Event(LoginView)
enum LoginEvent {
    case inputChanged(field: Input.Field, value: String)
    case login
}
```

```swift
/// @Factory
/// @Loop(LoginState, LoginEvent)
final class LoginLoop: GeneratedBaseLoginLoop {
    override func inputChanged(field: Input.Field, value: String) { ... }

    override func login() {}
}
```

```swift
public final class Onboarding {
    public static func start(_ resolver: Resolver) -> some View {
        LoginView.create(using: LoginLoop.create(using: resolver))
    }
}
```

```swift
struct Dependencies: AutoSetup {
    let container = DependencyContainer()
}
```

```swift
@main
struct TemplateApp: App {

    init() {
        Dependencies.setup()
        Appearance.setup()
    }

    var body: some Scene {
        Dependencies.apply {
            switch coordinator.state {
            case .loggedIn: Todos.start($0)
            case .loggedOut: Onboarding.start($0)
            }
       }
    }
}
```

## Installation

Feel free to take a look at the `Template.xcodeproj` to see the library in action. The usage is demonstrated using tests, which can be found in `SwiftCopyDemoTests.swift` file.

## Discussion

TBD

## Inspiration



## License

SwiftCopy is available under the MIT license. See [LICENSE](https://github.com/davidscheutz/SwiftCopy/blob/master/LICENSE) for more information.

## Credit

This project is a 
