//
//  MarkerServiceProtocol.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import GoogleMaps

public protocol MarkerServiceProtocol {
    func makeMarkerAt(map: GMSMapView,
                      position: CLLocationCoordinate2D,
                      title: String?,
                      subtitle: String?,
                      image: UIImage?)
}
