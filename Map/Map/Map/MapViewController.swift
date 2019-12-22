//
//  ViewController.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private let mapView = MKMapView()
    private let regionService = MKCoordinateRegionService()
    private lazy var layoutGuide = view.safeAreaLayoutGuide

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapViewLayout()
        mapView.setRegion(regionService.getRegionWith(coordinate: regionService.defaultCenterCoordinate,
                                                      span: nil), animated: false)
    }

}

// MARK: SetupConstraints

extension MapViewController {
    fileprivate func setupMapViewLayout() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        ])
    }
}

// MARK: MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
}


