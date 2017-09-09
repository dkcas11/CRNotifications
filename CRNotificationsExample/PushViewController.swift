//
//  PushViewController.swift
//  CRNotificationsExample
//
//  Created by Casper Riboe on 06/07/2017.
//  Copyright © 2017 Criboe. All rights reserved.
//

import UIKit
import CRNotifications

class PushViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor.groupTableViewBackground
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		CRNotifications.showNotification(type: .success, title: "Pushed through!", message: "I'm right here.", dismissDelay: 3)
	}
	
}
