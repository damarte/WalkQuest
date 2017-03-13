import Foundation
import MapKit

class PlayersMemStore: PlayersStoreProtocol
{
    var devicePlayer: Player? = Player(id: "id", username: "testPlayer", location: CLLocationCoordinate2D(latitude: 42.4627195, longitude: 2.444985200000019))
    
    func fetchDevicePlayer(_ completionHandler: @escaping (() throws -> Player?) -> Void) {
            
        if let player = self.devicePlayer {
            completionHandler { return player }
        } else {
            completionHandler { throw PlayersStoreError.cannotFetch("Cannot fetch device player") }
        }
    }
}
