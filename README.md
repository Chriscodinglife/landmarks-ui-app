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