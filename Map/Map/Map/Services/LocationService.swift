//
//  LocationService.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import MapKit
import UIKit

final class LocationService: CLLocationManager, CLLocationManagerDelegate {

    var isEnabled = false {
        didSet {
            isEnabled ? self.startUpdatingLocation() : self.stopUpdatingLocation()
        }
    }

    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            self.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }

}
