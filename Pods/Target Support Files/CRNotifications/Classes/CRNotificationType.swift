//
//  CRNotificationType.swift
//  CRNotifications
//
//  Created by Casper Riboe on 14/09/2017.
//	LICENSE : MIT
//

import Foundation

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
