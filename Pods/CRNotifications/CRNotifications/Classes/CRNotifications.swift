//
//  CRNotifications.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  LICENSE : MIT
//

import UIKit

public class CRNotifications {
    
    // MARK: - Static notification types
    
    public static let success: CRNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatGreen, image: UIImage(named: "success", in: Bundle(for: CRNotifications.self), compatibleWith: nil))
    public static let error: CRNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatRed, image: UIImage(named: "error", in: Bundle(for: CRNotifications.self), compatibleWith: nil))
    public static let info: CRNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatGray, image: UIImage(named: "info", in: Bundle(for: CRNotifications.self), compatibleWith: nil))

    
    // MARK: - Init
    
    public init(){}
    
    
    // MARK: - Helpers
    
    /** Shows a CRNotification **/
    public static func showNotification(textColor: UIColor, backgroundColor: UIColor, image: UIImage?, title: String, message: String, dismissDelay: TimeInterval, completion: @escaping () -> () = {}) {
        let notificationDefinition = CRNotificationTypeDefinition(textColor: textColor, backgroundColor: backgroundColor, image: image)
        showNotification(type: notificationDefinition, title: title, message: message, dismissDelay: dismissDelay, completion: completion)
    }
    
    /** Shows a CRNotification from a CRNotificationType **/
    public static func showNotification(type: CRNotificationType, title: String, message: String, dismissDelay: TimeInterval, completion: @escaping () -> () = {}) {
        let view = CRNotification()
        
        view.setBackgroundColor(color: type.backgroundColor)
        view.setTextColor(color: type.textColor)
        view.setImage(image: type.image)
        view.setTitle(title: title)
        view.setMessage(message: message)
        view.setDismisTimer(delay: dismissDelay)
		view.setCompletionBlock(completion)
        
        guard let window = UIApplication.shared.keyWindow else {
            print("Failed to show CRNotification. No keywindow available.")
            return
        }
        
        window.addSubview(view)
        view.showNotification()
    }
}

fileprivate struct CRNotificationTypeDefinition: CRNotificationType {
    var textColor: UIColor
    var backgroundColor: UIColor
    var image: UIImage?
}
