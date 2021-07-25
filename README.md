

# SGCodeTextField

Simple pin code textfield for iOS and tvOS. Customizable via Interface Builder or code.

# Wiki

## Installation
via CocoaPods

    pod "SGCodeTextField"
    
    
via SwiftPackageManager

    dependencies: [
        .package(url: "https://github.com/grigorievs/SGCodeTextField.git", .upToNextMajor(from: "0.1.4"))
    ]

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
 - isSecureTextEntry
 - secureTextEntryMaskCharacter

Customizing via code:

    self.codeTextField.count = 4
    
    self.codeTextField.placeholder = "*"
    
    self.codeTextField.textColorFocused = UIColor.brown
    
    self.codeTextField.refreshUI()

 
## Usage

Interface Builder

    Drag and drop a 'UIView' on to the desired view and change class to 'SGCodeTextField'.

Code

    let codeTextField = SGCodeTextField()

Getting text:

    import SGCodeTextField
    
    let value = self.codeTextField.text

Setting text:

    self.codeTextField.text = "1234"

Observing text change events:

    self.codeTextField.textChangeHandler = { text, completed in
    
	    self.doneButton.isSelected = completed
    
	    print(text ?? "")
    
    }

# Screenshots

<img src="https://i.imgur.com/lu3lVkD.png" align="left" alt="Editing mode" width="250px;"/>
<img src="https://i.imgur.com/ZCy3YLV.png" align="center" alt="Default mode" width="250px;"/>


### Other customisations

<img src="https://i.imgur.com/2CuJxJ9.png" align="left" alt="Editing mode" width="250px;"/>
