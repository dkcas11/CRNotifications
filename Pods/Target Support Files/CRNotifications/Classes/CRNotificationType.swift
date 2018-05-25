//
//  CRNotificationType.swift
//  CRNotifications
//
//  Created by Casper Riboe on 14/09/2017.
//	LICENSE : MIT
//

import Foundation

/** Protocol for defining a CRNotification style **/
public protocol CRNotificationType {
    var textColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var image: UIImage? { get }
}
