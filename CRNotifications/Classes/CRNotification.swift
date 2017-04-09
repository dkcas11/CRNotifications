//
//  CRNotification.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  Copyright © 2017 Criboe. All rights reserved.
//

import UIKit

class CRNotification: UIView {

	public fileprivate(set) lazy var imageView: UIImageView = {
		let view = UIImageView()
		view.tintColor = .white
		return view
	}()
	public fileprivate(set) lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFontWeightBold)
		label.textColor = .white
		return label
	}()
	var messageView: UITextView = {
		let view = UITextView()
		view.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
		view.backgroundColor = .clear
		view.textColor = .white
		view.textContainerInset = UIEdgeInsets(top: -4, left: -5, bottom: 0, right: 0)
		return view
	}()
	
	override init(frame: CGRect) {
		let width = UIScreen.main.bounds.width * 0.9
		let height = (65 / 337) * width
		super.init(frame: CGRect(x: 0, y: -height, width: width, height: height))
		center.x = UIScreen.main.bounds.width/2
		
		layer.cornerRadius = 5
		layer.shadowRadius = 5
		layer.shadowOpacity = 0.25
		layer.shadowColor = UIColor.lightGray.cgColor
		
		addSubview(imageView)
		addSubview(titleLabel)
		addSubview(messageView)
		
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.topAnchor.constraint(equalTo: imageView.superview!.topAnchor, constant: 12).isActive = true
		imageView.leadingAnchor.constraint(equalTo: imageView.superview!.leadingAnchor, constant: 12).isActive = true
		imageView.bottomAnchor.constraint(equalTo: imageView.superview!.bottomAnchor, constant: -12).isActive = true
		imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true

		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: -8).isActive = true
		titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.centerYAnchor, constant: -2).isActive = true

		messageView.translatesAutoresizingMaskIntoConstraints = false
		messageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -2).isActive = true
		messageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
		messageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
		messageView.bottomAnchor.constraint(equalTo: messageView.superview!.bottomAnchor, constant: -2).isActive = true
		
		let dismissRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissNotification))
		addGestureRecognizer(dismissRecognizer)
		
		showNotification()
	}
	
	/// Required init for nib loading
	required public init?(coder aDecoder:NSCoder) {
		super.init(coder: aDecoder)
	}
	
	/// Sets the title of the notification
	func setTitle(title: String) {
		titleLabel.text = title
	}
	
	/// Sets the message of the notification
	func setMessage(message: String) {
		messageView.text = message
	}
	
	/// Sets the image of the notification
	func setImage(image: UIImage) {
		imageView.image = image
	}
	
	/// Dismisses the notification with a delay > 0
	func setDismisTimer(delay: Int) {
		if delay > 0 {
			Timer.scheduledTimer(timeInterval: Double(delay), target: self, selector: #selector(dismissNotification), userInfo: nil, repeats: false)
		}
	}
	
	/// Animates in the notification
	func showNotification() {
		UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations: {
			self.frame.origin.y = UIApplication.shared.statusBarFrame.height + (self.frame.height * 0.1) + 5
			}, completion: {
				(complete: Bool) in
				UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(), animations: {
					self.frame.origin.y = self.frame.origin.y - 5
				})
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
