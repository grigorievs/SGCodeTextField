# SGCodeTextField

Simple pin code textfield. Customizable via Interface Builder or code.

# Wiki

## Customisable properties

 - count
 - placeholder
 - autocapitalization
 - font
 - digitCornerRadius
 - digitBackgroundColor
 - digitBackgroundColorFocused
 - digitBackgroundColorEmpty
 - digitBorderColor
 - digitBorderColorFocused
 - digitBorderColorEmpty
 - digitBorderWidth
 - digitSpacing
 - textColor
 - textColorFocused
 - placeholderColor
 - keyboardType

Customizing via code:

    self.codeTextField.count = 4
    
    self.codeTextField.placeholder = "*"
    
    self.codeTextField.textColorFocused = UIColor.brown
    
    self.codeTextField.refreshUI()

 
## Usage

Getting text:

    let value = self.codeTextField.text

Setting text:

    self.codeTextField.text = "1234"

Observing text change events:

    self.codeTextField.textChangeHandler = { text, completed in
    
	    self.doneButton.isSelected = completed
    
	    print(text ?? "")
    
    }

# Screenshots

<img src="https://i.imgur.com/lu3lVkD.png" alt="Editing mode" style="width: 200px;"/>
<img src="https://i.imgur.com/ZCy3YLV.png" alt="Default mode" style="width: 200px;"/>
