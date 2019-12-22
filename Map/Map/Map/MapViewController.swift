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
    private let locationService = CLLocationManagerService()
    
    private var navigationButton: UIButton?
    private lazy var layoutGuide = view.safeAreaLayoutGuide

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsCompass = false
        setupMapViewLayout()
        setupNavigationView()
        mapView.setRegion(regionService.getRegionWith(coordinate: regionService.defaultCenterCoordinate,
                                                      span: nil), animated: false)
        locationService.requestWhenInUseAuthorization()
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

// MARK: HandleNavigation

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
        
        if locationService.isEnabled {
            mapView.userTrackingMode = .follow
            mapView.userActivity?.becomeCurrent()
            mapView.showsUserLocation = true
        } else {
            mapView.userTrackingMode = .none
            mapView.userActivity?.invalidate()
            mapView.showsUserLocation = false
        }
    }
}
