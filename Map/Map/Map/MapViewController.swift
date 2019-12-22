//
//  ViewController.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    private lazy var mapView: GMSMapView = {
        let mapView = GMSMapView()
        mapView.camera = GMSCameraPosition.camera(withLatitude: 25.761681,
                                                  longitude: -80.191788,
                                                  zoom: defaultZoomLevel)
        return mapView
    }()
    private let locationService = CLLocationManagerService()
    private let defaultZoomLevel: Float = 17.0
    private var navigationButton: UIButton?
    private lazy var layoutGuide = view.safeAreaLayoutGuide

    override func viewDidLoad() {
        super.viewDidLoad()
        locationService.delegate = self
//        let marker = GMSMarker()
//         marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//         marker.title = "Sydney"
//         marker.snippet = "Australia"
//         marker.map = mapView
        
        setupMapViewLayout()
        setupNavigationView()

        locationService.requestWhenInUseAuthorization()
    }

}

// MARK: - SetupConstraints

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
    
    fileprivate func setupNavigationView() {
        let backgroundView = UIView()
        if #available(iOS 13.0, *) {
            backgroundView.backgroundColor = .systemBackground
        } else {
            backgroundView.backgroundColor = .white
        }
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.alpha = 0.65
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 48),
            backgroundView.widthAnchor.constraint(equalTo: layoutGuide.widthAnchor, multiplier: 0.15),
            backgroundView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -16)
        ])
        backgroundView.layoutIfNeeded()
        backgroundView.layer.cornerRadius = backgroundView.frame.width / 6
        
        let navigationButton = UIButton(type: .system)
        navigationButton.setImage(getImageForNavigationButton(), for: .normal)
        navigationButton.contentMode = .scaleAspectFit
        navigationButton.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(navigationButton)
        NSLayoutConstraint.activate([
            navigationButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            navigationButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            navigationButton.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5),
            navigationButton.heightAnchor.constraint(equalTo: navigationButton.widthAnchor)
        ])
        navigationButton.addTarget(self, action: #selector(handleNavigation), for: .touchUpInside)
        self.navigationButton = navigationButton
    }
    
    private func getImageForNavigationButton() -> UIImage? {
        let imageName = locationService.isEnabled ? "locationEnabled" : "locationDisabled"
        return UIImage(named: imageName)
    }
   
}

// MARK: - HandleNavigation

extension MapViewController {
    @objc private func handleNavigation() {
        guard CLLocationManager.authorizationStatus() == .authorizedWhenInUse else {
            // Презенти у роутера
            if let alertController = AlertControllerLocationDenied.getAlertController() {
                present(alertController, animated: true)
            }
            return
        }
        
        locationService.isEnabled.toggle()
        navigationButton?.setImage(getImageForNavigationButton(), for: .normal)
        mapView.isMyLocationEnabled = locationService.isEnabled
        
        if locationService.isEnabled {
            locationService.startUpdatingLocation()
        } else {
            locationService.stopUpdatingLocation()
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        let latitude = lastLocation.coordinate.latitude
        let longitude = lastLocation.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude,
                                              longitude: longitude,
                                              zoom: mapView.camera.zoom)
        
        mapView.animate(to: camera)
    }
}
