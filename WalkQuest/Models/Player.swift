//
//  Player.swift
//  WalkQuest
//
//  Created by David on 1/3/17.
//  Copyright © 2017 damarte. All rights reserved.
//

import Foundation
import MapKit

struct Player: Equatable
{
    var id: String
    var username: String
    var location: CLLocationCoordinate2D?
}

func ==(lhs: Player, rhs: Player) -> Bool
{
    return lhs.id == rhs.id
        && lhs.username == rhs.username
}

