//
//  CRNotifications.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  Copyright © 2017 Criboe. All rights reserved.
//

import UIKit

class CRNotifications {
	
	/// Enum for types of notifications
	enum CRNotificationType {
		case success
		case error
		case info
	}

	/// Shows a CRNotification
	static func showNotification(type: CRNotificationType, title: String, message: String, dismissDelay: Int) {
		let view = CRNotification.instanceFromNib() as! CRNotification
		var color = UIColor.black
		var image = UIImage(named: "success")
		
		switch type {
		case .success:
			color = .flatGreen
			image = UIImage(named: "success")
			break
		case .error:
			color = .flatRed
			image = UIImage(named: "error")
			break
		case .info:
			color = .flatGray
			image = UIImage(named: "info")
			break
		}
		
		view.backgroundColor = color
		view.setImage(image: image!)
		view.setTitle(title: title)
		view.setMessage(message: message)
		view.setDismisTimer(delay: dismissDelay)

		UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(view)
	}
}
