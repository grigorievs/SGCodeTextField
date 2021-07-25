//
//  SGCodeTextField.swift
//  SGCodeTextField
//
//	Copyright (c) 2019 Sergiu Grigoriev
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.
//

import Foundation
import UIKit

@IBDesignable
public class SGCodeTextField: UIControl {
    
    @IBInspectable public var count: Int = 6 {
        didSet {
            if count < 1 { count = 1}
            refreshUI()
        }
    }
    @IBInspectable public var placeholder: String = "-" {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var autocapitalization: Bool = true  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var font: UIFont = UIFont.systemFont(ofSize: 18.0)  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitCornerRadius: CGFloat = 5.0  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitBackgroundColor: UIColor = UIColor.white  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitBackgroundColorFocused: UIColor = UIColor.lightGray  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitBackgroundColorEmpty: UIColor = UIColor.white  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitBorderColor: UIColor = UIColor.gray  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitBorderColorFocused: UIColor = UIColor.black  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitBorderColorEmpty: UIColor = UIColor.lightGray  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitBorderWidth: CGFloat = 1.0  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var digitSpacing: CGFloat = 5.0  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var textColor: UIColor = UIColor.black  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var textColorFocused: UIColor = UIColor.black  {
        didSet {
            refreshUI()
        }
    }
    @IBInspectable public var placeholderColor: UIColor = UIColor.lightGray  {
        didSet {
            refreshUI()
        }
    }
	@IBInspectable public var isSecureTextEntry: Bool = false {
		didSet {
			refreshUI()
		}
	}
	@IBInspectable public var secureTextEntryMaskCharacter: String = "*" {
		didSet {
			refreshUI()
		}
	}
	
	public var textChangeHandler: ((_ text: String?, _ completed: Bool) -> Void)?
	public var keyboardType: UIKeyboardType {
		set {
			self.textField.keyboardType = newValue
		}
		get {
			return self.textField.keyboardType
		}
	}
	
	public var text: String? {
		set {
			if (newValue?.count ?? 0) <= self.count {
				self.textField.text = newValue
				self.updateLabels()
			}
		}
		get {
			return self.textField.text
		}
	}
	
	override public var isFirstResponder: Bool {
		return self.textField.isFirstResponder
	}
	
	// Private
	private var stackView = UIStackView()
	private var textField = UITextField()
	
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
	
	private func setup() {
		self.customize()
		self.addGestures()
		
		self.textField.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)
		self.textField.addTarget(self, action: #selector(editingDidBegin(sender:)), for: .editingDidBegin)
		self.textField.addTarget(self, action: #selector(editingDidEnd(sender:)), for: .editingDidEnd)
	}
	
	private func customize() {
		self.isUserInteractionEnabled = true
		
		self.stackView.axis = .horizontal
		self.stackView.distribution = .fillEqually
		self.stackView.spacing = self.digitSpacing
		
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
		self.textField.keyboardType = .numberPad
		self.textField.isHidden = true
		self.textField.delegate = self
        
        /// Note: Received message must containt one of the following words for the auto-complete to work: passcode, code
        if #available(iOS 12, tvOS 12, *) {
            self.textField.textContentType = .oneTimeCode
        }
	}
	
	private func addGestures() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
		self.addGestureRecognizer(tap)
	}
	
	private func addLabels() {
		self.stackView.subviews.forEach({ $0.removeFromSuperview() })
		
		for i in 0..<self.count {
			let lbl = UILabel()
			lbl.layer.cornerRadius = self.digitCornerRadius
			lbl.layer.borderWidth = self.digitBorderWidth
			lbl.font = self.font
			lbl.textAlignment = .center
			lbl.clipsToBounds = true
			lbl.tag = i
			
			self.stackView.addArrangedSubview(lbl)
		}
	}
	
	// MARK: - Public
	
    @discardableResult
	override public func becomeFirstResponder() -> Bool {
		return self.textField.becomeFirstResponder()
	}
	
    @discardableResult
	override public func resignFirstResponder() -> Bool {
		return self.textField.resignFirstResponder()
	}
	
	// call it after all properties were set for better performance
	public func refreshUI() {
		self.addLabels()
		self.updateLabels()
		
		self.stackView.spacing = self.digitSpacing
	}
	
	// MARK: - Actions
	
	@objc private func textDidChange(sender: UITextField) {
		self.updateLabels()
		self.textChangeHandler?(self.text, self.text?.count == self.count)
        sendActions(for: .editingChanged)
	}
	
	@objc private func editingDidBegin(sender: UITextField) {
		self.updateLabels()
        sendActions(for: .editingDidBegin)
	}
	
	@objc private func editingDidEnd(sender: UITextField) {
		self.updateLabels()
        sendActions(for: .editingDidEnd)
	}
	
	// MARK: - UI
	
	private func updateLabels() {
		if (self.text?.count ?? 0) <= self.stackView.subviews.count {
		
			var lastIndex = -1
		
			for i in 0..<(self.text?.count ?? 0) {
				let str = self.text ?? ""
				let index = str.index(str.startIndex, offsetBy: i)
				let lbl = self.stackView.subviews[i] as! UILabel
				let character = self.isSecureTextEntry ? self.secureTextEntryMaskCharacter : String(str[index])
				
				lbl.backgroundColor = self.digitBackgroundColor
				lbl.textColor = self.textColor
				lbl.text = self.autocapitalization ? character.uppercased() : character
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
				if self.isFirstResponder && lastIndex < (self.count) {
					let lbl = self.stackView.subviews[min(lastIndex + 1, self.count - 1)] as! UILabel
					lbl.backgroundColor = self.digitBackgroundColorFocused
					lbl.textColor = self.textColorFocused
					lbl.layer.borderColor = self.digitBorderColorFocused.cgColor
				}
			}
		}
	}
	
	@objc private func onTap() {
		let _ = self.textField.becomeFirstResponder()
	}
}

extension SGCodeTextField: UITextFieldDelegate {
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
		
		return newString.count <= self.count
	}
}

