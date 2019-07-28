//
//  CRNotifications.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  LICENSE : MIT
//

import UIKit

public protocol CRNotificationDelegate {
    func onNotificationTap()
}

public class CRNotifications {
    
    // MARK: - Static notification types
    
    public static let success: CRNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatGreen, image: UIImage(named: "success", in: Bundle(for: CRNotifications.self), compatibleWith: nil))
    public static let error: CRNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatRed, image: UIImage(named: "error", in: Bundle(for: CRNotifications.self), compatibleWith: nil))
    public static let info: CRNotificationType = CRNotificationTypeDefinition(textColor: UIColor.white, backgroundColor: UIColor.flatGray, image: UIImage(named: "info", in: Bundle(for: CRNotifications.self), compatibleWith: nil))

    
    // MARK: - Init
    
    public init(){}
    
    
    // MARK: - Helpers
    
    /** Shows a CRNotification.
        Returns the CRNotification that is displayed. Returns nil if the keyWindow is not present.
     **/
    @discardableResult
    public static func showNotification(textColor: UIColor, backgroundColor: UIColor, image: UIImage?, title: String, message: String, dismissDelay: TimeInterval, delegate: CRNotificationDelegate? = nil, completion: @escaping () -> () = {}) -> CRNotification? {
        let notificationDefinition = CRNotificationTypeDefinition(textColor: textColor, backgroundColor: backgroundColor, image: image)
        return showNotification(type: notificationDefinition, title: title, message: message, dismissDelay: dismissDelay, delegate: delegate, completion: completion)
    }
    
    /** Shows a CRNotification from a CRNotificationType.
        Returns the CRNotification that is displayed. Returns nil if the keyWindow is not present.
     **/
    @discardableResult
    public static func showNotification(type: CRNotificationType, title: String, message: String, dismissDelay: TimeInterval, delegate: CRNotificationDelegate? = nil, completion: @escaping () -> () = {}) -> CRNotification? {
        let view = CRNotificationView()
        
        view.setBackgroundColor(color: type.backgroundColor)
        view.setTextColor(color: type.textColor)
        view.setImage(image: type.image)
        view.setTitle(title: title)
        view.setMessage(message: message)
        view.setDismisTimer(delay: dismissDelay)
		view.setCompletionBlock(completion)
        view.onClickDelegate = delegate
        
        guard let window = UIApplication.shared.keyWindow else {
            print("Failed to show CRNotification. No keywindow available.")
            return nil
        }
        
        window.addSubview(view)
        view.showNotification()
        
        return view
    }
}

fileprivate struct CRNotificationTypeDefinition: CRNotificationType {
    var textColor: UIColor
    var backgroundColor: UIColor
    var image: UIImage?
}
