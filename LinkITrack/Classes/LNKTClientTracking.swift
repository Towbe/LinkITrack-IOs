import Foundation
import GoogleMaps
import UIKit

public struct Location: Codable {
    var lat: Double?;
    var lng: Double?;
}

public struct Destination: Codable {
    var location: Location?
}

public struct Driver: Codable {
    var driver_location: Location?
    var first_name: String?
    var last_name: String?
    var profilePicture: String?
}

public struct Job: Codable {
    var destinations: [Destination]?
    var driver: Driver?
    var eta: Int?
}

public struct GraphInternalData: Codable {
    var jobs: [Job]?
}

public struct GraphData: Codable {
    var data: GraphInternalData?
}

public class LNKTClientTracking {
    static var apiKey: String? = nil;
    
    var done: Bool = false;
    let queue = DispatchQueue(label: "com.linkit.polling-queue", qos: .userInitiated)
    var job: String? = nil;
    
    var map: GMSMapView;
    var vehicleMarker: GMSMarker;
    var destinationMarker: GMSMarker;
    
    public var data: Job? = nil;
    
    let query = "query ($job: ID!) {  jobs(ids: [$job]) {    driver {      first_name      last_name      profilePicture      phone_number      driver_location {        lat        lng      }    }    eta    destinations {      location {        lat        lng      }    }  }}";
    
    func fetch(jobId: String) {
        print(jobId)
        let requestBody: [Any]  = [
            [
                "query": self.query,
                "variables": [
                    "job": jobId,
                ]
            ]
        ];

        let url = URL(string: "https://graph.towbe.com/v1")!

        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if (LNKTClientTracking.apiKey != nil) {
            request.addValue(LNKTClientTracking.apiKey!, forHTTPHeaderField: "authentication")
        }

        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            print("Getting Response");
            
            guard error == nil else {
                print("error: ", error);
                return
            }

//            guard let data = data else {
//                print(data);
//                return
//            }

            do {
                let decoder = JSONDecoder()
                //create json object from data
                if let unwraped = data {
                    let gqlStruct = try decoder.decode([GraphData].self, from:unwraped)
                    self.data = gqlStruct[0].data?.jobs?[0];
                    self.vehicleMarker.position = CLLocationCoordinate2D(latitude: Double(self.data?.driver?.driver_location?.lat ?? 0), longitude: Double(self.data?.driver?.driver_location?.lng ?? 0))
                    self.destinationMarker.position = CLLocationCoordinate2D(latitude: Double(self.data?.destinations?[1].location?.lat ?? 0), longitude: Double(self.data?.destinations?[1].location?.lng ?? 0))
                }
            } catch {
                print("error", error.localizedDescription)
            }
        })
        task.resume()
    }
    
    deinit {
        self.done = true;
    }
    
    func update() {
        if (job != nil) {
            self.fetch(jobId: self.job!)
        }
        
        if (!done) {
            queue.asyncAfter(deadline: .now() + .seconds(5), execute: {
                self.update();
            })
        }
    }
    
    public init(view: UIView) {
        let camera = GMSCameraPosition.camera(withLatitude: 35.5243188, longitude: 33.8810078, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: view.frame, camera: camera)
        view.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.map = mapView
        
        self.map = mapView;
        self.vehicleMarker = marker;
        self.destinationMarker = GMSMarker()
        
        self.destinationMarker.map = mapView
    }
    
    public func watchJob(jobId: String) {
        self.job = jobId;
        self.update();
    }
    
    public static func setApiKey(apiKey: String) {
        LNKTClientTracking.apiKey = apiKey;
    }
}
