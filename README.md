# landmarks-ui-app

Playing with SwiftUI with IOS, was able to create this basic Map View:
![image5](images/image5.png)

This is part of the tutorial from this site here: [Landmarks UI](https://developer.apple.com/tutorials/swiftui/creating-and-combining-views)

## Some important concepts to remember (more for myself)

- Swift UI uses the `App` protocol
- Clicking + Command Key on an item can give a special context menu
![image1](images/image1.png)
- The Assets.xcassets is where you can import resources like images for your project
![image2](images/image2.png)
- What the hell is a @State attribute? Example:

```Swift
@State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
```

Looks like Apple Dev says State as the [following](https://developer.apple.com/documentation/swiftui/state):
> Use state as the single source of truth for a given value type that you store in a view hierarchy. Create a state value in an App, Scene, or View by applying the @State attribute to a property declaration and providing an initial value. Declare state as private to prevent setting it in a memberwise initializer, which can conflict with the storage management that SwiftUI provides:

```Swift
struct PlayButton: View {
    @State private var isPlaying: Bool = false // Create the state.


    var body: some View {
        Button(isPlaying ? "Pause" : "Play") { // Read the state.
            isPlaying.toggle() // Write the state.
        }
    }
}
```

![image3](images/image3.png)

- The map view can automatically set the width when you set the height
![image4](images/image4.png)
- Man swift is an interesting language, so unlike Python, if you want call the parameter you want to set when calling a method/function, you can just pass in that value, but in Swift, you can explicitly tell a function you create that you don't want to pass the parameter name, and just pass in the value instead.
`In Swift, you can use an underscore to omit the external parameter names for a function or method. This concept is widely used in iOS applications. For example, if you have a function like this −`

```Swift
func doSomething(_ value: Int) {
   // do something with the value
}

func greetingMessage(_ fullName: String) -> String? {
   return "Good morning, \(fullName)"
}
```

Other wise you would need to declare the "value" attribute, or in the second example above, the `fullName` attribute when calling the greetingMessage function like so:

```Swift
greetingMessage(fullName: "Alex Murphy")
```

- Decodable protocol in Swift is a way to basically to read JSON data from a file or source into your code. Most common ways is to use a structure. In the example below, we have JSON and then our Swift Code:

```JSON
{
"title": "Optionals in Swift explained: 5 things you should know",
"url": "https://www.avanderlee.com/swift/optionals-in-swift-explained-5-things-you-should-know/",
"category": "swift",
"views": 47093
}
```

```Swift
struct BlogPost: Decodable {
    enum Category: String, Decodable {
        case swift, combine, debugging, xcode
    }

    let title: String
    let url: URL
    let category: Category
    let views: Int
}

let JSON = """
{
    "title": "Optionals in Swift explained: 5 things you should know",
    "url": "https://www.avanderlee.com/swift/optionals-in-swift-explained-5-things-you-should-know/",
    "category": "swift",
    "views": 47093
}
"""

let jsonData = JSON.data(using: .utf8)!
let blogPost: BlogPost = try! JSONDecoder().decode(BlogPost.self, from: jsonData)

print(blogPost.title) // Prints: "Optionals in Swift explained: 5 things you should know"
```

- In Swift to pass a variable into a sentence you do:

```Swift
"Hello there \(username)"
```

- Initializing a function like this below can let you ensure that the type you are passing into conforms to the Decodable protocol. You can then later use the type as part of the error logging when catching errors. Notice `T.self` below

```Swift
func load<T: Decodable>(_ filename: String) -> T { ...

do {
    something
    } catch {
        fatalError("Could not decode \(filename) as \(T.self): \(error)")
    }
```
