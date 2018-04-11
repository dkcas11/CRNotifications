//
//  CRNotifications.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  LICENSE : MIT
//

import UIKit

public class CRNotifications {
    static var notifications = [CRNotification]()
    public init(){}
    
    /// Shows a CRNotification
    public static func showNotification(type: CRNotificationType, title: String, message: String, dismissDelay: TimeInterval, completion: @escaping () -> () = {}) {
        let view = CRNotification()
        
        view.setBackgroundColor(color: type.color)
        view.setImage(image: type.image)
        view.setTitle(title: title)
        view.setMessage(message: message)
        view.setDismisTimer(delay: dismissDelay)
        view.setCompletionBlock(completion)
        
        guard let window = UIApplication.shared.keyWindow else {
            print("Failed to show CRNotification. No keywindow available.")
            return
        }
        
        notifications.removeAll()
        notifications.append(view)
        window.addSubview(view)
        view.showNotification()
    }
    
    public static func isNotificationVisible() -> Bool {
        if CRNotifications.notifications.count > 0 && CRNotifications.notifications[0].superview != nil {
            return true
        } else {
            return false
        }
        
    }
    
    public static func hideNotification() {
        for notification in CRNotifications.notifications {
            notification.dismissNotification()
            notifications.removeAll()
        }
    }
}
