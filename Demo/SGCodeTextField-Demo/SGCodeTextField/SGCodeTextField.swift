//
//  SGCodeTextField.swift
//  SGCodeTextField
//
//  Created by Sergiu Grigoriev on 08/01/2019.
//  Copyright © 2019 Sergiu Grigoriev. All rights reserved.
//

import Foundation
import UIKit

class SGCodeTextField: UIView {
	
	@IBInspectable var count: Int = 6
	@IBInspectable var placeholder: String = "-"
	@IBInspectable var keyboardType: UIKeyboardType = .numberPad
	@IBInspectable var isSecureTextEntry: Bool =  false
	@IBInspectable var autocapitalization: Bool = true
	@IBInspectable var font: UIFont = UIFont.systemFont(ofSize: 18.0)
	@IBInspectable var digitCornerRadius: CGFloat = 5.0
	@IBInspectable var digitBackgroundColor: UIColor = UIColor.white
	@IBInspectable var digitBackgroundColorFocused: UIColor = UIColor.lightGray
	@IBInspectable var digitBackgroundColorEmpty: UIColor = UIColor.white
	@IBInspectable var digitBorderColor: UIColor = UIColor.gray
	@IBInspectable var digitBorderColorFocused: UIColor = UIColor.green
	@IBInspectable var digitBorderColorEmpty: UIColor = UIColor.green
	@IBInspectable var digitBorderWidth: CGFloat = 1.0
	@IBInspectable var textColor: UIColor = UIColor.black
	@IBInspectable var textColorFocused: UIColor = UIColor.black
	@IBInspectable var placeholderColor: UIColor = UIColor.lightGray
	
	private var stackView = UIStackView()
	private var textField = UITextField()
	
	override var isFirstResponder: Bool {
		return self.textField.isFirstResponder
	}
	
	var textChangeHandler: ((_ completed: Bool) -> Void)?
	var text: String? {
		return self.textField.text
	}
	
	init() {
		super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
		
		self.setup()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.setup()
	}
	
	func setup() {
		self.customize()
		self.addGestures()
		
		self.textField.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
	}
	
	func customize() {
		self.isUserInteractionEnabled = true
		
		self.stackView.axis = .horizontal
		self.stackView.distribution = .fillEqually
		self.stackView.spacing = 5.0
		
		self.addSubview(self.stackView)
		self.stackView.translatesAutoresizingMaskIntoConstraints = false
		
		let viewsDict = ["subView" : self.stackView]
		
		let constraint_POS_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subView]-0-|", options: [], metrics: nil, views: viewsDict)
		let constraint_POS_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subView]-0-|", options: [], metrics: nil, views: viewsDict)
		
		self.addConstraints(constraint_POS_V)
		self.addConstraints(constraint_POS_H)
		
		self.addLabels()
		self.updateLabels()
		
		self.insertSubview(self.textField, at: 0)
		self.textField.isHidden = true
		self.textField.delegate = self
	}
	
	private func addGestures() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
		self.addGestureRecognizer(tap)
	}
	
	private func addLabels() {
		for i in 0..<self.count {
			let lbl = UILabel()
			lbl.layer.cornerRadius = self.digitCornerRadius
			lbl.layer.borderWidth = self.digitBorderWidth
			lbl.font = self.font
			lbl.textAlignment = .center
			lbl.tag = i
			
			self.stackView.addArrangedSubview(lbl)
		}
	}
	
	override func becomeFirstResponder() -> Bool {
		let value = self.textField.becomeFirstResponder()
		
		self.updateLabels()
		
		return value
	}
	
	override func resignFirstResponder() -> Bool {
		let value = self.textField.becomeFirstResponder()
		
		self.updateLabels()
		
		return value
	}
	
	// MARK: - Actions
	
	@objc func textDidChange(sender: UITextField) {
		self.updateLabels()
		self.textChangeHandler?(self.text?.count == self.count)
	}
	
	private func updateLabels() {
		var lastIndex = -1
		
		for i in 0..<(self.text?.count ?? 0) {
			let str = self.text ?? ""
			let index = str.index(str.startIndex, offsetBy: i)
			let lbl = self.stackView.subviews[i] as! UILabel
			
			lbl.backgroundColor = self.digitBackgroundColor
			lbl.textColor = self.textColor
			lbl.text = self.autocapitalization ? String(str[index]).uppercased() : String(str[index])
			lbl.layer.borderColor = self.digitBorderColor.cgColor
			
			lastIndex = i
		}
		
		// empty labels
		if lastIndex < self.count {
			for i in (lastIndex+1)..<self.count {
				let lbl = self.stackView.subviews[i] as! UILabel
				
				lbl.backgroundColor = self.digitBackgroundColorEmpty
				lbl.textColor = self.placeholderColor
				lbl.text = self.placeholder
				lbl.layer.borderColor = self.digitBorderColorEmpty.cgColor
			}
			
			// focused label
			if self.isFirstResponder && lastIndex < (self.count - 1) {
				let lbl = self.stackView.subviews[lastIndex + 1] as! UILabel
				lbl.backgroundColor = self.digitBackgroundColorFocused
				lbl.textColor = self.textColorFocused
				lbl.layer.borderColor = self.digitBorderColorFocused.cgColor
			}
		}
	}
	
	@objc func onTap() {
		let _ = self.textField.becomeFirstResponder()
	}
}

extension SGCodeTextField: UITextFieldDelegate {
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
		
		return newString.count <= self.count
	}
}

