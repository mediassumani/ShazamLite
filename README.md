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

* Your Model - make sure it conforms to the Codable protocole

```swift
  struct Todo: Codable {
    
      var userId: Int?
      var title: String?
      var completed: Bool?
  }

```

* Request for decoding JSON of type dictionary. See example  <a href="https://jsonplaceholder.typicode.com/todos">here</a>.

``` Swift

import ShazamLite

var downloader = Shazam(withUrlString: "https://jsonplaceholder.typicode.com/todo/1")
downloader.get(parameters: nil, headers: nil) { (result: Result<Todo?, Error>) in

  switch result{
      case let .success(data):
        // Your data available!
                
      case let .failure(error):
        // Errors are customed in ShazamLite, print it to see what caused the failure             
   }
}


```
* Request for decoding  JSON of type dictionary. See example  <a href="https://jsonplaceholder.typicode.com/todos/1">here</a>.

``` Swift

import ShazamLite

var downloader = Shazam(withUrlString: "https://jsonplaceholder.typicode.com/todos/1")
downloader.get(parameters: nil, headers: nil) { (result: Result<[Todo]?, Error>) in

  switch result{
      case let .success(data):
        // Your data available!
                
      case let .failure(error):
        // Errors are customed in ShazamLite, print it to see what caused the failure             
   }
}

```

* Request for sending data to a server with POST request.

``` Swift

import ShazamLite


var todo = Todo(userId: 1, title: "Get Food from work", completed: true)
var encodedData = try! JSONEncoder().encode(todo)
var downloader = Shazam(withUrlString: "https://jsonplaceholder.typicode.com/todo/1")

downloader.set(parameters: nil, headers: nil, method: .post, body: encodedBody) { (result: Result<Bool?, Error>) in

  switch result{
      case let .success(data):
        // Your data available!
                
      case let .failure(error):
        // Errors are customed in ShazamLite, print it to see what caused the failure             
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
<b>ShazamLite</b> is an Open-sourced project and under the MIT license. See the <a href="https://github.com/MediBoss/ShazamLite/blob/master/LICENSE">LICENSE</a> file for more info.
