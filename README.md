# The Modern Swift Template

What do engineering-driven companies like Spotify, Snapchat, and Block (formerly Square) have in common?

They don’t simply follow established “best practices.” Instead, they define their own architecture, tooling, and internal frameworks tailored to their specific domain and vision.

Which demands a deep understanding of both the project's environment as well as the core principles of building high-quality software. 

This project was built to showcase how to move fast without sacrificing quality. It strikes the balance between lightwight simplicity and scalable structure.

## Architectural Attributes

The aim wasn’t trying to build the "perfect" architecture; it was to build a system that supports the attributes I care about most:

<img width="428" alt="Attributes" src="https://github.com/user-attachments/assets/76fd3f72-d586-4d48-ad85-8b44785dedd6" />

### 1. Simplicity

Above all, simplicity.

Simple systems are easier to understand and maintain, and harder to misuse.

As systems have the tendency to grow in complexity over time, simplicity is constantly at risk. But if maintained, it brings joy and confidence to the development.

### 2. Modularity

The foundation for a flexible system.

Small, loosley coupled parts working togehter greatly increase the chances of extensibility and reusabilty.

### 3. Cohesion

Cohesion is what makes a project one thing.

Consistency across the codebase reduces the overall cognitive load which makes working on it more comfortable and easier.

### 4. Testability

Because we value speed and quality.

### 5. Scalability

The ability of the codebase to scale in complexity and contributors without reducing throughput.

## Use case: Todo App

Each decision in this template has been made to optimize for the principles outlined above.

This is not a framework you plug and play — it’s a foundation to think from, adapt, and extend.

<img width="1023" alt="Screenshot 2025-05-10 at 22 27 04" src="https://github.com/user-attachments/assets/fc7ffdcd-2052-4c9e-aa72-7a0cc5d208df" />

**In-house Dependencies:**
- [SwiftDependencyContainer](https://github.com/davidscheutz/SwiftDependencyContainer) Code generation-powered depdency management
- [SwiftCopy](https://github.com/davidscheutz/SwiftCopy) Convenient copy functionality for immutable structs to ensure thread safety
- [SwiftUDF](https://github.com/davidscheutz/SwiftUDF) Binding SwiftUI views with a uni-directional data flow architecture
- [SwiftEvolution](https://github.com/davidscheutz/SwiftEvolution) Set of useful Swift extensions

## Installation

Checkout the `Template.xcodeproj`, enable the compiler build plugins and run to see the project in action.

## Discussion

This project is an invitation to explore engineering principles together — not just to implement them, but to think critically about how they apply to your project, your constraints, and your future.

## License

The Modern Swift Template is available under the MIT license.

## Credit

To all the people I've worked with over the last decade, who I could learn and grow from.
