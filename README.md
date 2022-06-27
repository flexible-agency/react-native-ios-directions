# react-native-ios-directions

Exposing the native [MKDirections](https://developer.apple.com/documentation/mapkit/mkdirections) API on iOS.


## Installation

```sh
yarn add react-native-ios-directions
```

## Usage

```js
import { getDirections } from "react-native-ios-directions";

const route = await getDirections([51.526023, -0.083454], [51.5336, -0.05711]);
if (route) {
    // route = { eta: 0, distance: 0, points: [[0,0],[1,1]] }
}
```
