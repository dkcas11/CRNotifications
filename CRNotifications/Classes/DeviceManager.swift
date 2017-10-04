//  ----------------------------------------------------
//  DeviceManager.swift
//  ----------------------------------------------------
//
//	Complete list of devices sorted by resolution.
//	Device return by the method 'Device' is based on the height of the device.
//
//	iPad Small
//	1536x2048 / 768x1024 (768x1024 / 384x512)
//	- iPad Retina
//	- iPad 3
//	- iPad Mini Retina
//	- iPad Mini 4
//	- iPad Air
//	- iPad Air 2
//	- iPad Pro 9.7"
//
//  iPad Medium
//  1668x2224 (834x1112)
//  iPad Pro 10.5"
//
//	iPad Big
//	2048x2732 (1024x1366)
//	- iPad Pro 12.9"
//
//  iPhone35
//	640x960 (320x480)
//	- iPhone 4
//
//  iPhone40
//	640x1136 (320x568)
//	- iPhone 5
//
//  iPhone47
//	750x1334 (375x667)
//	- iPhone 6
//	- iPhone 7
//	- iPhone 8
//
//  iPhone55
//	1080x1920 / 1242x2208 (540x960 / 621x1104 / 414x736)
//	- iPhone 6 Plus
//	- iPhone 7 Plus
//	- iPhone 8 Plus
//
//  iPhone58
//	1125x2436 (375x812)
//  - iPhone X
//
//  ----------------------------------------------------
//  Created by Casper Riboe on 21/07/2017.
//  Copyright © 2017 Casper Riboe. All rights reserved.
//  ----------------------------------------------------

import UIKit

internal class DeviceManager {
	
	private init() {}
	
	/// Returns the current device in use.
	internal static func device() -> Device {
		let size = CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
		                  height: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height))
		
		switch size {
		case CGSize(width: 320.0, height: 480.0):
			return .iPhone35
		case CGSize(width: 320.0, height: 568.0):
			return .iPhone40
        case CGSize(width: 375.0, height: 667.0):
            return .iPhone47
        case CGSize(width: 375.0, height: 812.0):
            return .iPhone58
		case CGSize(width: 414.0, height: 736.0):
			return .iPhone55
		case CGSize(width: 540.0, height: 960.0):
			return .iPhone55
		case CGSize(width: 621.0, height: 1104.0):
			return .iPhone55
		case CGSize(width: 562.5, height: 1218.0):
			return .iPhone58
		case CGSize(width: 384.0, height: 512.0):
			return .iPadSmall
		case CGSize(width: 768.0, height: 1024.0):
			return .iPadSmall
        case CGSize(width: 834.0, height: 1112.0):
            return .iPadMedium
		case CGSize(width: 1024.0, height: 1366.0):
			return .iPadBig
		default:
			return .unknown
		}
	}
	
	/// Returns a value based on the current iPhone device.
	internal static func value<T>(iPhone35: T, iPhone40: T, iPhone47: T, iPhone55: T, iPhone58: T) -> T {
		switch device() {
		case .iPhone35:
			return iPhone35
		case .iPhone40:
			return iPhone40
		case .iPhone47:
			return iPhone47
		case .iPhone55:
			return iPhone55
		default:
			return iPhone58
		}
	}
	
	/// Returns a value based on the current iPad device.
	internal static func value<T>(iPadSmall: T, iPadMedium: T, iPadBig: T) -> T {
		switch device() {
		case .iPadSmall:
			return iPadSmall
		case .iPadMedium:
			return iPadMedium
		default:
			return iPadBig
		}
	}
	
	/// Returns a value based on the current iPhone or iPad device.
	internal static func value<T>(iPhone35: T, iPhone40: T, iPhone47: T, iPhone55: T, iPhone58: T, iPadSmall: T, iPadMedium: T, iPadBig: T) -> T {
		switch device() {
		case .iPhone35:
			return iPhone35
		case .iPhone40:
			return iPhone40
		case .iPhone47:
			return iPhone47
		case .iPhone55:
			return iPhone55
		case .iPhone58:
			return iPhone58
		case .iPadSmall:
			return iPadSmall
		case .iPadMedium:
			return iPadMedium
		default:
			return iPadBig
		}
	}
    
    /// Returns a value based on the current iPhone or iPad device.
    internal static func value<T>(iPhone: T, iPad: T) -> T {
        return value(iPhone35: iPhone, iPhone40: iPhone, iPhone47: iPhone, iPhone55: iPhone, iPhone58: iPhone, iPadSmall: iPad, iPadMedium: iPad, iPadBig: iPad)
    }
    
}


internal enum Device {
	case iPhone35
	case iPhone40
	case iPhone47
	case iPhone55
	case iPhone58
	
	case iPadSmall
	case iPadMedium
	case iPadBig
	
	case unknown
}
