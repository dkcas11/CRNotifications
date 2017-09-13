//
//  CRNotifications.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  LICENSE : MIT
//

import UIKit

public class CRNotifications {
    
    	public init(){}
	
	/// Enum for types of notifications
	public enum CRNotificationType {
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
            		let bundle = Bundle(for: CRNotifications.self)
            
			switch self {
			case .success: return UIImage(named: "success", in: bundle, compatibleWith: nil)!
			case .error: return UIImage(named: "error", in: bundle, compatibleWith: nil)!
			case .info: return UIImage(named: "info", in: bundle, compatibleWith: nil)!
			}
		}
	}

	/// Shows a CRNotification
	public static func showNotification(type: CRNotificationType, title: String, message: String, dismissDelay: TimeInterval) {
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
