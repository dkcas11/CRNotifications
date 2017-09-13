//
//  CRNotification.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  LICENSE : MIT
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
	public fileprivate(set) lazy var messageView: UITextView = {
		let view = UITextView()
		view.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
		view.backgroundColor = .clear
		view.textColor = .white
		view.textContainerInset = UIEdgeInsets(top: -4, left: -5, bottom: 0, right: 0)
		view.isUserInteractionEnabled = false
		return view
	}()
	
	init() {
		let width = UIScreen.main.bounds.width * 0.9
		let height = (65 / 337) * width
		super.init(frame: CGRect(x: 0, y: -height, width: width, height: height))
		center.x = UIScreen.main.bounds.width/2
		
		setupLayer()
		setupSubviews()
		setupConstraints()
		setupTargets()
	}
	
	func setupLayer() {
		layer.cornerRadius = 5
		layer.shadowRadius = 5
		layer.shadowOpacity = 0.25
		layer.shadowColor = UIColor.lightGray.cgColor
	}
	
	func setupSubviews() {
		addSubview(imageView)
		addSubview(titleLabel)
		addSubview(messageView)
	}
	
	func setupConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		messageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: imageView.superview!.topAnchor, constant: 12),
			imageView.leadingAnchor.constraint(equalTo: imageView.superview!.leadingAnchor, constant: 12),
			imageView.bottomAnchor.constraint(equalTo: imageView.superview!.bottomAnchor, constant: -12),
			imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
			])
		
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: -8),
			titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.centerYAnchor, constant: -2)
			])
		
		NSLayoutConstraint.activate([
			messageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -2),
			messageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			messageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			messageView.bottomAnchor.constraint(equalTo: messageView.superview!.bottomAnchor, constant: -2)
			])
	}
	
	func setupTargets() {
		let dismissRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissNotification))
		addGestureRecognizer(dismissRecognizer)
	}
	
	/// Required init for nib loading (nib loading is not supported)
	required public init?(coder aDecoder:NSCoder) { fatalError("Not implemented.") }
	
	/// Sets the background color of the notification
	func setBackgroundColor(color: UIColor) {
		backgroundColor = color
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
	func setDismisTimer(delay: TimeInterval) {
		if delay > 0 {
			Timer.scheduledTimer(timeInterval: Double(delay), target: self, selector: #selector(dismissNotification), userInfo: nil, repeats: false)
		}
	}
	
	/// Animates in the notification
	func showNotification() {
		UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.68, initialSpringVelocity: 0.1, options: UIViewAnimationOptions(), animations: {
			self.frame.origin.y = UIApplication.shared.statusBarFrame.height * 1.5
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
