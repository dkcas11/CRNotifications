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
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
		label.textColor = .white
		return label
	}()
	public fileprivate(set) lazy var messageView: UITextView = {
		let view = UITextView()
		view.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
		view.backgroundColor = .clear
		view.textColor = .white
		view.isUserInteractionEnabled = false
		view.textContainerInset = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0)
        view.textContainer.lineBreakMode = .byWordWrapping
		return view
	}()
	public var completion: () -> () = {}
	
	init() {
		let deviceWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let widthFactor: CGFloat = DeviceManager.value(iPhone35: 0.9, iPhone40: 0.9, iPhone47: 0.9, iPhone55: 0.85, iPhone58: 0.9, iPadSmall: 0.5, iPadMedium: 0.45, iPadBig: 0.4)
        let heightFactor: CGFloat = DeviceManager.value(iPhone35: 0.2, iPhone40: 0.2, iPhone47: 0.2, iPhone55: 0.2, iPhone58: 0.2, iPadSmall: 0.18, iPadMedium: 0.17, iPadBig: 0.17)

        let width = deviceWidth * widthFactor
        let height = width * heightFactor
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
            titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: -2),
			titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: -8),
			titleLabel.bottomAnchor.constraint(equalTo: titleLabel.superview!.centerYAnchor, constant: -2)
			])
		
		NSLayoutConstraint.activate([
			messageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -6),
			messageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			messageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
			messageView.bottomAnchor.constraint(equalTo: messageView.superview!.bottomAnchor, constant: -4)
			])
	}
	
	func setupTargets() {
		NotificationCenter.default.addObserver(self, selector: #selector(didRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
		let dismissRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissNotification))
		addGestureRecognizer(dismissRecognizer)
	}
	
	@objc func didRotate() {
		UIView.animate(withDuration: 0.2) {
			self.center.x = UIScreen.main.bounds.width/2
			self.center.y = UIApplication.shared.statusBarFrame.height + 10 + self.frame.height/2
		}
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
	
	/// Sets the completion block of the notification for when it is dismissed
	func setCompletionBlock(_ completion: @escaping () -> ()) {
		self.completion = completion
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
			self.frame.origin.y = UIApplication.shared.statusBarFrame.height + 10
		})
	}
	
	/// Animates out the notification
	@objc func dismissNotification() {
		UIView.animate(withDuration: 0.1, delay: 0.0, options: UIViewAnimationOptions(), animations: {
			self.frame.origin.y = self.frame.origin.y + 5
		}, completion: {
			(complete: Bool) in
			UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: {
				self.center.y = -self.frame.height
			}, completion: { [weak self] (complete) in
				self?.completion()
				self?.removeFromSuperview()
			})
		})
	}
}
