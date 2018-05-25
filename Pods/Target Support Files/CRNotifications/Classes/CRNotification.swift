//
//  CRNotification.swift
//  CRNotifications
//
//  Created by Casper Riboe on 21/03/2017.
//  LICENSE : MIT
//

import UIKit

internal class CRNotification: UIView {

	private lazy var imageView: UIImageView = {
		let view = UIImageView()
		view.tintColor = .white
		return view
	}()
    
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
		label.textColor = .white
		return label
	}()
	
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: UIFont.Weight.semibold)
        label.textColor = .white
        label.numberOfLines = 2
        return label
	}()
	
    private var completion: () -> () = {}
    
    
    // MARK: - Init
	
    required internal init?(coder aDecoder:NSCoder) { fatalError("Not implemented.") }
    
	internal init() {
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
	
    
    // MARK: - Setup
    
	private func setupLayer() {
		layer.cornerRadius = 5
		layer.shadowRadius = 5
		layer.shadowOpacity = 0.25
		layer.shadowColor = UIColor.lightGray.cgColor
	}
	
	private func setupSubviews() {
		addSubview(imageView)
		addSubview(titleLabel)
		addSubview(messageLabel)
	}
	
	private func setupConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		messageLabel.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
		NSLayoutConstraint.activate([
			imageView.topAnchor.constraint(equalTo: imageView.superview!.topAnchor, constant: 12),
			imageView.leadingAnchor.constraint(equalTo: imageView.superview!.leadingAnchor, constant: 12),
			imageView.bottomAnchor.constraint(equalTo: imageView.superview!.bottomAnchor, constant: -12),
			imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
		
		NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.superview!.topAnchor, constant: 6),
            titleLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.superview!.topAnchor, constant: 2),
			titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
			titleLabel.trailingAnchor.constraint(equalTo: titleLabel.superview!.trailingAnchor, constant: -8)
        ])
		
		NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(lessThanOrEqualTo: titleLabel.bottomAnchor, constant: 3),
			messageLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
			messageLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            messageLabel.bottomAnchor.constraint(lessThanOrEqualTo: messageLabel.superview!.bottomAnchor, constant: -4)
        ])
	}
	
	private func setupTargets() {
		NotificationCenter.default.addObserver(self, selector: #selector(didRotate), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
		
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissNotification))
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.dismissNotification))
        swipeRecognizer.direction = .up
        
        addGestureRecognizer(tapRecognizer)
        addGestureRecognizer(swipeRecognizer)
	}
    
    
    // MARK: - Helpers
	
	@objc internal func didRotate() {
		UIView.animate(withDuration: 0.2) {
			self.center.x = UIScreen.main.bounds.width/2
			self.center.y = UIApplication.shared.statusBarFrame.height + 10 + self.frame.height/2
		}
	}
		
    /** Sets the background color of the notification **/
    internal func setBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    /** Sets the background color of the notification **/
    internal func setTextColor(color: UIColor) {
        titleLabel.textColor = color
        messageLabel.textColor = color
    }
	
	/** Sets the title of the notification **/
	internal func setTitle(title: String) {
		titleLabel.text = title
	}
	
	/** Sets the message of the notification **/
	internal func setMessage(message: String) {
		messageLabel.text = message
	}
	
	/** Sets the image of the notification **/
	internal func setImage(image: UIImage?) {
		imageView.image = image
	}
	
	/** Sets the completion block of the notification for when it is dismissed **/
	internal func setCompletionBlock(_ completion: @escaping () -> ()) {
		self.completion = completion
	}
	
	/** Dismisses the notification with a delay > 0 **/
	internal func setDismisTimer(delay: TimeInterval) {
		if delay > 0 {
			Timer.scheduledTimer(timeInterval: Double(delay), target: self, selector: #selector(dismissNotification), userInfo: nil, repeats: false)
		}
	}
	
	/** Animates in the notification **/
	internal func showNotification() {
		UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.68, initialSpringVelocity: 0.1, options: UIViewAnimationOptions(), animations: {
			self.frame.origin.y = UIApplication.shared.statusBarFrame.height + 10
		})
	}
	
	/** Animates out the notification **/
	@objc internal func dismissNotification() {
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
