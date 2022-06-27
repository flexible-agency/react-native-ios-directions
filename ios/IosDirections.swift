import Foundation;
import MapKit;

public extension MKMultiPoint {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid,
                                              count: pointCount)

        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))

        return coords
    }
}

@objc(IosDirections)
class IosDirections: NSObject {

    @objc(getDirections:withOriginLongitude:withDestinationLatitude:withDestinationLongitude:withResolver:withRejecter:)
    func getDirections(originLatitude: Double, originLongitude: Double, destinationLatitude: Double, destinationLongitude: Double, resolve: @escaping(RCTPromiseResolveBlock), reject: @escaping(RCTPromiseRejectBlock)) -> Void {
        let placemarkOne = MKPlacemark(coordinate: CLLocationCoordinate2DMake(originLatitude, originLongitude), addressDictionary: nil)
        let placemarkTwo = MKPlacemark(coordinate:CLLocationCoordinate2DMake(destinationLatitude, destinationLongitude), addressDictionary: nil)

        let sourceMapItem = MKMapItem(placemark: placemarkOne)
        let destinationMapItem = MKMapItem(placemark: placemarkTwo)

        let request = MKDirections.Request()
        request.source = sourceMapItem
        request.destination = destinationMapItem
        request.requestsAlternateRoutes = false
        request.transportType = .walking

        let directions = MKDirections(request:request)
        directions.calculate { response, error in
            if error != nil {
                reject("Error getting directions", error!.localizedDescription, nil);
                return;
            }

            guard let unwrappedResponse = response else {
                reject("Error getting directions", "Could not unwrap response", nil);
                return;
            }
            if unwrappedResponse.routes.count > 0 {
                let route = unwrappedResponse.routes[0]
                
                var points: [[Double]] = [];

                for point in route.polyline.coordinates {
                    points.append([point.latitude, point.longitude]);
                }

                let successDict: NSDictionary! = [
                    "eta": Double(route.expectedTravelTime),
                    "distance": Double(route.distance),
                    "points": points
                ]

                resolve([successDict])
            }
        }
    }
}
