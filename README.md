# Vragen SDK Network
The networking part of Vragen. Which is currently used by [vragen-cli](https://github.com/MartinMetselaar/vragen-cli) and [vragen-sdk](https://github.com/MartinMetselaar/vragen-sdk).

## Installation
### Swift Package Manager
Add the following as a dependency to your `Package.swift`.
```swift
.package(url: "https://github.com/MartinMetselaar/vragen-sdk-network.git", from: "1.1.0"),
```

## Usage
The [vragen-api](https://github.com/MartinMetselaar/vragen-api) contains several endpoints to create surveys, questions and answers. In this project we have related classes to help you list, create, get, update and delete these. Synchronise and asynchronise. 

To fetch a survey with all its questions and answers we can use `SurveyAsynchroniseNetwork` (where `SurveySynchroniseNetwork` is the synchronise variant). The class needs to be initialised with the url of the server where you are hosting the [vragen-api](https://github.com/MartinMetselaar/vragen-api) and the token. 

```swift
let url = URL(string: "https://vragenapi.example.org")!
let token = "the-correct-token-from-your-server"
let client = SurveyAsynchroniseNetwork(server: url, token: token)
client.getWithChildren(identifier: identifier) { result in
    switch result {
        case .success(let survey): break
        case .failure(let error): break
    }
}
```