//
//  ViewController.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  LICENSE : MIT
//

import UIKit
import CRNotifications

class ViewController: UIViewController {
    
	/// Test buttons
	@IBAction func showSuccess(_ sender: Any) {
		CRNotifications.showNotification(type: CRNotifications.success, title: "Success!", message: "You successfully showed this notification.", dismissDelay: 3, completion: {
			print("Successfully executed this print when the notification disappeared.")
		})
	}
	
	@IBAction func showError(_ sender: Any) {
		CRNotifications.showNotification(type: CRNotifications.error, title: "Error", message: "This notification does not have a green background.", dismissDelay: 3)
	}
	
    @IBAction func showInfo(_ sender: Any) {
        CRNotifications.showNotification(type: CRNotifications.info, title: "Did you know?", message: "This notification will dismiss itself in 3 seconds.", dismissDelay: 3)
    }
    
    @IBAction func showCustom(_ sender: Any) {
        let customNotification = CustomCRNotification(textColor: UIColor.green, backgroundColor: UIColor.brown, image: UIImage())
        CRNotifications.showNotification(type: customNotification, title: "Did you know?", message: "This notification is very long and resizes itself in order to fit the size of the view. These last words exceed the limit.", dismissDelay: 3)
    }
	
    @IBAction func showWithOnTapFeature(_ sender: Any) {
        CRNotifications.showNotification(type: CRNotifications.info, title: "Did you know?", message: "Tap on this notification to show another notification", dismissDelay: 3, delegate: self)
    }
    
    @IBAction func nextViewControllerButton(_ sender: Any) {
		navigationController?.pushViewController(PushViewController(), animated: true)
	}
}

fileprivate struct CustomCRNotification: CRNotificationType {
    var textColor: UIColor
    var backgroundColor: UIColor
    var image: UIImage?
}

extension ViewController: CRNotificationDelegate {
    func onNotificationTap(type: CRNotificationType, title: String?, message: String?) {
        CRNotifications.showNotification(type: CRNotifications.success, title: "Success!", message: "You successfully tapped on the previous notification. Title was \(title ?? "no title")", dismissDelay: 3, completion: {
            print("Successfully executed this print when the notification disappeared.")
        })
    }
}
