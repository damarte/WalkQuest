@testable import WalkQuest
import XCTest
import MapKit

class PlayersMemStoreTests: XCTestCase
{
    // MARK: - Subject under test
    
    var sut: PlayersMemStore!
    var testPlayer: Player!
    
    // MARK: - Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupPlayersMemStore()
    }
    
    override func tearDown()
    {
        resetOrdersMemStore()
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupPlayersMemStore()
    {
        sut = PlayersMemStore()
        
        testPlayer = Player(id: "id", username: "testPlayer", location: CLLocationCoordinate2D(latitude: 42.4627195, longitude: 2.444985200000019))
        
        sut.devicePlayer = testPlayer
    }
    
    func resetOrdersMemStore()
    {
        sut.devicePlayer = nil
        sut = nil
    }
    
    // MARK: - Test CRUD operations - Inner closure
    
    func testFetchDevicePlayerShouldReturnDevicePlayer_InnerClosure()
    {
        // Given
        let playerToFetch = testPlayer
        
        // When
        var returnedPlayer: Player?
        let expectation = self.expectation(description: "Wait for fetchDevicePlayer() to return")
        
        sut.fetchDevicePlayer { (player) in
            returnedPlayer = try! player()
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
        
        // Then
        XCTAssertEqual(returnedPlayer, playerToFetch, "fetchDevicePlayer() should return device player")
    }
}
