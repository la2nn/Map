//
//  CLLocationManagerService.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import MapKit
import UIKit

final class CLLocationManagerService: CLLocationManager, CLLocationManagerDelegate {

    var isEnabled = false {
        didSet {
            isEnabled ? self.startUpdatingLocation() : self.stopUpdatingLocation()
        }
    }

    var userLocation: CLLocationCoordinate2D? {
        return self.location?.coordinate
    }

    override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            self.delegate = self
            self.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        }
    }

}
