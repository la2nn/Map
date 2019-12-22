//
//  MarkerService.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import GoogleMaps

final class MarkerService: MarkerServiceProtocol {
    
    func makeMarkerAt(map: GMSMapView,
                      position: CLLocationCoordinate2D,
                      title: String?,
                      subtitle: String?,
                      image: UIImage?) {
        let marker = GMSMarker(position: position)
        marker.title = title
        marker.snippet = subtitle
        marker.icon = image?.resizedImage()
        marker.map = map
    }
}


