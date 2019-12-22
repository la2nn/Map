//
//  MKCoordinateRegionService.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import MapKit

final class MKCoordinateRegionService {
    
    let defaultCenterCoordinate = CLLocationCoordinate2D(latitude: 25.761681,
                                                         longitude: -80.191788)
    private let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05,
                                               longitudeDelta: 0.05)
    
    func getRegionWith(coordinate: CLLocationCoordinate2D, span: MKCoordinateSpan?) -> MKCoordinateRegion {
        return MKCoordinateRegion(center: coordinate, span: span ?? defaultSpan)
    }
}

