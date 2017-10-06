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
    
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	/// Test buttons
	@IBAction func showSuccess(_ sender: Any) {
		CRNotifications.showNotification(type: .success, title: "Success!", message: "You successfully showed this notification.", dismissDelay: 3, completion: {
			print("Successfully executed this print when the notification disappeared.")
		})
	}
	
	@IBAction func showError(_ sender: Any) {
		CRNotifications.showNotification(type: .error, title: "Error", message: "This notification does not have a green background.", dismissDelay: 3)
	}
	
	@IBAction func showInfo(_ sender: Any) {
		CRNotifications.showNotification(type: .info, title: "Did you know?", message: "This notification will dismiss itself in 3 seconds.", dismissDelay: 3)
	}
	
	@IBAction func nextViewControllerButton(_ sender: Any) {
		navigationController?.pushViewController(PushViewController(), animated: true)
	}
}
