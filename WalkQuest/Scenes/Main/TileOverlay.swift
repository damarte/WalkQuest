import UIKit
import MapKit

class TileOverlay: MKTileOverlay {
    
    init() {
        super.init(urlTemplate: "https://stamen-tiles.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg")
        
        self.canReplaceMapContent = true
        self.maximumZ = 22
        self.minimumZ = 1
        self.tileSize = CGSize(width: 256, height: 256)
    }
    
    /*override init(urlTemplate URLTemplate: String?) {
        super.init(urlTemplate: URLTemplate)
        
        self.canReplaceMapContent = true
        self.maximumZ = 22
        self.minimumZ = 5
        self.tileSize = CGSize(width: 256, height: 256)
    }*/
    
    override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: self.url(forTilePath: path), cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            }
            
            result(data, error)
        }
        
        task.resume()
    }
}
