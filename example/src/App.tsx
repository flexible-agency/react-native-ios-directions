import * as React from 'react';

import MapView, { Polyline } from 'react-native-maps';
import { StyleSheet, Text, SafeAreaView } from 'react-native';
import { getDirections, DirectionsResponse } from 'react-native-ios-directions';

export default function App() {
  const [result, setResult] = React.useState<DirectionsResponse | undefined>();

  React.useEffect(() => {
    getDirections([51.526023, -0.083454], [51.5336, -0.05711]).then(setResult);
  }, []);

  if(!result){
    return null;
  }

  return (
    <SafeAreaView style={styles.container}>
      <Text style={{padding: 32}} numberOfLines={8}>Result: {JSON.stringify(result, null, 2)}</Text>
      <MapView style={{flex: 1}} initialRegion={{
        latitude: 51.535950,
        longitude: -0.071930,
        latitudeDelta: 0.0522,
        longitudeDelta: 0.0421,
      }}>
        <Polyline
          coordinates={result.points.map(([latitude, longitude]) => ({latitude, longitude}))}
          strokeColor="#1871f9"
          strokeWidth={5}
        />
      </MapView>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
});
