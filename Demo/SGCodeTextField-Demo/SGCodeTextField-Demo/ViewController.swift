//
//  ViewController.swift
//  SGCodeTextField-Demo
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

import UIKit
import SGCodeTextField

class ViewController: UIViewController {
	
	// outlets
	@IBOutlet weak var codeTextField: SGCodeTextField!
	@IBOutlet weak var doneButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.customize()
		self.addGestures()
	}
	
	func customize() {
		self.codeTextField.count = 4
		self.codeTextField.placeholder = "*"
		self.codeTextField.textColorFocused = UIColor.brown
		self.codeTextField.refreshUI()
		
		// self.codeTextField.text = "1234"
		
		self.codeTextField.textChangeHandler = { text, completed in
			self.doneButton.isSelected = completed
			print(text ?? "")
		}
		
	}

	func addGestures() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(onTap))
		self.view.addGestureRecognizer(tap)
	}

	// MARK: - Actions
	
	@objc func onTap() {
		let _ = self.codeTextField.resignFirstResponder()
	}
}

