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
		
		var color: UIColor {
			switch self {
			case .success: return UIColor.flatGreen
			case .error: return UIColor.flatRed
			case .info: return UIColor.flatGray
			}
		}
		
		var image: UIImage {
			switch self {
			case .success: return UIImage(named: "success")!
			case .error: return UIImage(named: "error")!
			case .info: return UIImage(named: "info")!
			}
		}
	}

	/// Shows a CRNotification
	static func showNotification(type: CRNotificationType, title: String, message: String, dismissDelay: TimeInterval) {
		let view = CRNotification()
		
		view.setBackgroundColor(color: type.color)
		view.setImage(image: type.image)
		view.setTitle(title: title)
		view.setMessage(message: message)
		view.setDismisTimer(delay: dismissDelay)

		guard let window = UIApplication.shared.keyWindow else {
			print("Failed to show CRNotification. No keywindow available.")
			return
		}
		window.addSubview(view)
		view.showNotification()
	}
}
