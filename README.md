<p align="center">
  <img width="460" height="250" src="ShazamLite_logo.png">A dynamically built, yet easy to use Networking Library for iOS.
</p>

[![HitCount](http://hits.dwyl.io/MediBoss/ShazamLite.svg)](http://hits.dwyl.io/MediBoss/ShazamLite)[![star this repo](http://githubbadges.com/star.svg?user=MediBoss&repo=ShazamLite&style=default)](https://github.com/MediBoss/ShazamLite)
[![fork this repo](http://githubbadges.com/fork.svg?user=MediBoss&repo=ShazamLite&style=default)](https://github.com/MediBoss/ShazamLite/fork)
### Overview
ShazamLite is an asynchronous, concurrent, and rapid Networking Library built in Swift for iOS.

### Why use ShazamLite?

* Absract complex URLSession functionalities from developers.
* Configure model Encoding and Decoding for developers.
* Provide support for all HTTP Request types (GET, POST, PUT, PATCH, DELETE).
* Graceful handle of common HTTP errors.
* Dynamic and custom construction of request.
* Custom handle of server responses.

### Requirements

- Swift 4.2+
- Xcode 10.2+
- iOS 10.0

### Installation
* For iOS 10.0+ projects with <a href="https://cocoapods.org/">Cocoapods</a>:

  ```python
    pod 'ShazamLite' 
  ```

### Quick start

<b>NOTE</b>: ShazamLite only has two powerfull methods:

    * get : Use this for requests when getting data from an API. 
    * set : Use this for for requests when you're sending data to an API.
  
* Your Model - make sure it conforms to the Codable protocol.

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

// Initialize a Shazam instance with a url/endpoint/route.
var downloader = Shazam(withUrlString: "https://jsonplaceholder.typicode.com/todo/1")

downloader.get(parameters: nil, headers: nil) { (result: Result<Todo?, Error>) in

  switch result{
      case let .success(todo):
        print(todo.title)
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

* Request for sending data to a server with POST method.

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

### Developer

* <a href="https://github.com/MediBoss">Medi Assumani</a> - Initial Work

### Built With

* Swift 4.2
* Xcode 10.2
* Cocoapods 1.7.5

### License
<b>ShazamLite</b> is an Open-sourced project and under the MIT license. See the <a href="https://github.com/MediBoss/ShazamLite/blob/master/LICENSE">LICENSE</a> file for more info.
