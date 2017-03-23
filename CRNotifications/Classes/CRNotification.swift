//
//  CRNotification.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  Copyright © 2017 Criboe. All rights reserved.
//

import UIKit

class CRNotification: UIView {

	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var messageView: UITextView!
	
	/// Instantiates the view from nib and sets the view layout
	class func instanceFromNib() -> UIView {
		let view = UINib(nibName: "CRNotification", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! CRNotification
		
		view.frame = CGRect(x: 0, y: view.frame.minY, width: UIScreen.main.bounds.width * 0.9, height: view.frame.height)
		view.center.x = UIScreen.main.bounds.width/2
		
		view.layer.cornerRadius = 5
		view.layer.shadowRadius = 5
		view.layer.shadowOpacity = 0.25
		view.layer.shadowColor = UIColor.lightGray.cgColor
		
		view.messageView.backgroundColor = .clear
		view.messageView.textColor = .white
		view.messageView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		
		view.imageView.tintColor = .white
		
		return view
	}
	
	/// Required init for nib loading
	required init?(coder aDecoder:NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	/// Initial setup of the notification
	private func setup() {
		let dismissRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissNotification))
		addGestureRecognizer(dismissRecognizer)
		
		showNotification()
	}
	
	/// Sets the title of the notification
	func setTitle(title: String) {
		self.titleLabel.text = title
	}
	
	/// Sets the message of the notification
	func setMessage(message: String) {
		self.messageView.text = message
	}
	
	/// Sets the image of the notification
	func setImage(image: UIImage) {
		self.imageView.image = image
	}
	
	/// Dismisses the notification with a delay > 0
	func setDismisTimer(delay: Int) {
		if delay > 0 {
			Timer.scheduledTimer(timeInterval: Double(delay), target: self, selector: #selector(dismissNotification), userInfo: nil, repeats: false)
		}
	}
	
	/// Animates in the notification
	func showNotification() {
		self.frame.origin.y = -self.frame.height
		UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations: {
			self.frame.origin.y = UIApplication.shared.statusBarFrame.height + (self.frame.height * 0.1) + 5
			}, completion: {
				(complete: Bool) in
				UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(), animations: {
					self.frame.origin.y = self.frame.origin.y - 5
				}, completion: nil)
		})
	}
	
	/// Animates out the notification
	func dismissNotification() {
		UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(), animations: {
			self.frame.origin.y = self.frame.origin.y + 5
		}, completion: {
			(complete: Bool) in
			UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: {
				self.center.y = -self.frame.height
			}, completion: { (complete) in
				self.removeFromSuperview()
			})
		})
	}
}
