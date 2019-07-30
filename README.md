# ShazamLite

### Overview
ShazamLite is an asynchronous, concurrent, and rapid Networking Library built in Swift for iOS & MacOS.

### Features

* Absract complex URLSession functionalities for beginner developers.
* Absract Model Encoding and Decoding from developers.
* Provide support for all HTTP Request types(GET, POST, PUT, DELETE).
* Handle all types of possible HTTP errors.
* Handle request building
* Handle response assessment

### Requirements

- Swift 4.2

### Installation
* For iOS 10.2+ with <a href="https://cocoapods.org/">Cocoapods</a>:

  ```python
    pod 'ShazamLite' 
  ```

### Quick start

* Your Model

* Your View Controller
``` Swift

import ShazamLite

var downloader = Shazam(withUrlString: "https://jsonplaceholder.typicode.com/posts/1")
downloader.getparameters: nil, headers: nil) { (result: Result<Todo?, Error>) in

  switch result{
      case let .success(data):
        // Your data available!
                
      case let .failure(error):
                
   }
}

```


### Author

* Medi Assumani - Initial Work

### Built With

* Swift 4.2
* Xcode 10.2
* Cocoapods 1.7.5

### License
<b>ShazamLite</b> is an Open-sourced project and under the MIT license. See the <a href="https://github.com/MediBoss/ShazamLite/License.md">LICENSE</a> file for more info.
