#  SwiftUI + Combine


## @EnvironmentObject
### For data that should be shared with all views in your entire app. This lets us share model data anywhere it’s needed, while also ensuring that our views automatically stay updated when that data changes. Use @EnvironmentObject for properties that were created elsewhere in the app, such as shared data. 
### For example: AppSetting.


## @ObservedObject
### Use @ObservedObject for complex properties that might belong to several views. Any time you’re using a reference type you should be using @ObservedObject for it.
### External, Reference Type, Developer Managed
### For example:  ViewModel.


## @Binding
### @Binding is one of SwiftUI’s less used property wrappers, but it’s still hugely important: it lets us declare that one value actually comes from elsewhere, and should be shared in both places. This is not the same as @ObservedObject or @EnvironmentObject, both of which are designed for reference types to be shared across potentially many views.
### For Example: Reusable view


## @State
### Use @State for simple properties that belong to a single view. They should usually be marked private.
### View-Local, Value Type, Framework Managed


## SwiftUI tips and tricks
### [To hide a view and remove its space](https://developer.apple.com/documentation/swiftui/view/hidden())
