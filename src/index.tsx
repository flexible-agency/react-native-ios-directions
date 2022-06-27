import { NativeModules, Platform } from 'react-native';

const LINKING_ERROR =
  `The package 'react-native-ios-directions' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: '- You have run \'pod install\'\n', default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo managed workflow\n';

const IosDirections = NativeModules.IosDirections
  ? NativeModules.IosDirections
  : new Proxy(
    {},
    {
      get() {
        if (Platform.OS !== 'ios') {
          // @ts-ignore
          console.warn(
            '[react-native-ios-directions] This library does not have any effect on non-iOS platforms.',
          );
        } else {
          throw new Error(LINKING_ERROR);
        }
      },
    },
  );

export interface DirectionsResponse {
  eta: number;
  distance: number;
  points: [[number, number]];
}

export function getDirections(
  pointA: number[],
  pointB: number[],
): Promise<DirectionsResponse> {
  return IosDirections.getDirections(
    pointA[0],
    pointA[1],
    pointB[0],
    pointB[1],
  );
}
