@testable import WalkQuest
import XCTest
import MapKit

class PlayersWorkerTests: XCTestCase
{
    // MARK: Subject under test
    
    var sut: PlayersWorker!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupPlayersWorker()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupPlayersWorker()
    {
        sut = PlayersWorker(playersStore: PlayersMemStoreSpy())
    }
    
    // MARK: Test doubles
    
    class PlayersMemStoreSpy: PlayersMemStore
    {
        // MARK: Method call expectations
        var fetchedPlayerCalled = false
        
        // MARK: Spied methods
        override func fetchDevicePlayer(_ completionHandler: @escaping (() throws -> Player?) -> Void) {
            fetchedPlayerCalled = true
            
            let oneSecond = DispatchTime.now() + Double(1 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: oneSecond, execute: {
                completionHandler {
                    return Player(id: "id", username: "testPlayer", location: CLLocationCoordinate2D(latitude: 42.4627195, longitude: 2.444985200000019))
                }
            })
        }
    }
    
    // MARK: Tests
    
    func testFetchOrdersShouldReturnListOfOrders()
    {
        // Given
        let playersMemStoreSpy = sut.playersStore as! PlayersMemStoreSpy
        
        // When
        let expectation = self.expectation(description: "Wait for fetchDevicePlayer() to return")
        sut.fetchDevicePlayer({ (player) in
            expectation.fulfill()
        })
        
        // Then
        XCTAssert(playersMemStoreSpy.fetchedPlayerCalled, "Calling fetchDevicePlayer() should ask the data store for player on device")
        waitForExpectations(timeout: 1.1) { _ in
            XCTAssert(true, "Calling fetchDevicePlayer() should result in the completion handler being called with the fetched result")
        }
    }
}
