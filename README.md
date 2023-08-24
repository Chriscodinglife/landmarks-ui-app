# Landmarks UI App

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

- So @State is this:

> @State is a property wrapper that allows you to declare a property whose value can change over time, and when the value changes, the user interface that uses this value will automatically be updated to reflect the change.

```Swift
    // Using @State allows the user interface and this 
    // region variable to updated as changes are made. 
    // This makes it so the user can interact with the map
    
    // We also set a default for the 
    // region location using MKCoordinateRegion 
    // and setting the center and span
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

- Depending where you put a `Spacer()` in your stacks, you can make it literally push all your content to a certain side:
![spacer](images/spacer.png)
![spacerleft](images/spacerleft.png)

- You can actually customize how previews are dispalyed in your code according to [Apple](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation#Customize-the-Row-Preview):

> Xcode’s canvas automatically recognizes and displays any type in the current editor that conforms to the PreviewProvider protocol. A preview provider returns one or more views, with options to configure the size and device. You can customize the returned content from a preview provider to render exactly the previews that are most helpful to you.

- `some View` lets you tell Swift that you can return basically anything (because your views can be complex) but still basically return a View. It's an "opaque return"

```Swift
struct LandmarkList: View {
    var body: some View {
        do something
        }
    }
}
```

- You can iterate through lists, but you also need to pass it unique iterable identification (such as a id variable) if it is not already adhering to the Identifiable protocol. If you set a structure to adhere to the Identifiable protocol, then you don't need to set the id parameter for the `List()` method. Also below are closures are closures, you basically tell how each iterable item in a list can be used. It is like a for loop. Basically closures are another name for lambda expressions:

```Swift
// Adhering your structure to the Identifiable protocol
struct Landmark: Hashable, Codable, Identifiable {
    
    var id: Int
    ...
```

```Swift
// closures
{ this_iterable in 
    do something
}
```

```Swift

// Leveraging the List method and not having to pass in the id: attribute
struct LandmarkList: View {
    var body: some View {
        List(landmarks) { landmark in
            LandmarkRow(landmark: landmark)
        }
        // Otherwise you would need to do List(landmarks, id: \.id) 
    }
}
```

- A binding in swift is denoted by `$` like `$region` variable. This is used to make a two way directional variable the gets updated by user interactions:

> The Map view takes a coordinateRegion parameter that requires a `Binding<MKCoordinateRegion>`. By using $region, you're passing a binding to the coordinateRegion parameter, allowing the map to update its region based on changes to the region property. Similarly, if the map's region changes due to user interactions, the region property will automatically be updated. In essence, using $region establishes a dynamic link between the region property (which is marked as @State and thus can change) and the map's coordinateRegion, ensuring that changes in one are immediately reflected in the other.

```Swift
// Here we declare the view and make a binding (two way connection
    // for region
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
```

- You can use `Scroll View` Container to allow a user to scroll on a screen

```Swift

    ...
    ScrollView {
        MapView(coordinate: landmark.locationCoordinate)
            .ignoresSafeArea(edges: .top)
            .frame(height: 300)
    
    ...

```

- Below is an example of how in your Detail view you can set .navigationTitle() to something. This can only be actually viewed though when your Detail is part of a Navigation Context

```Swift
struct LandmarkDetail: View {
    var landmark: Landmark
    
    var body: some View {
        
        ScrollView {
           // view stuff
        }
        .navigationTitle(landmark.name) // This here
        .navigationBarTitleDisplayMode(.inline)
    }
}
```

- And then look at the top navigation here, we are calling LandMark Detail. So within a view we can actually set methods related to navigation when its in the context of a navigation.

```Swift
NavigationView {
            List(landmarks) { landmark in
                NavigationLink {
                    LandmarkDetail(landmark: landmark)
                } label: {
                    LandmarkRow(landmark: landmark)
                }
                
            }
            .navigationTitle("Landmarks")
        }
```

![navtitle](images/navigationtitle.png)
