//
//  AlertControllerLocationDenied.swift
//  Map
//
//  Created by Николай Спиридонов on 22.12.2019.
//  Copyright © 2019 nnick. All rights reserved.
//

import UIKit

final class AlertControllerLocationDenied {
    static func getAlertController() -> UIAlertController? {
        guard let applicationSettingsURL = URL(string: UIApplication.openSettingsURLString) else { return nil }
        let alert = UIAlertController(title: "GPS is not allowed",
                                      message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.",
                                      preferredStyle: .alert)

        
        alert.addAction(UIAlertAction(title: "Go to Settings now",
                                      style: .default,
                                      handler: { alert in UIApplication.shared.open(applicationSettingsURL,
                                                                                    options: [:],
                                                                                    completionHandler: nil)
        }))
        
        return alert
    }
}
