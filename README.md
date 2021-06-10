**LabelTapGesture** An extension for setup UILabel with custom hyperlink styling, and interaction when tap on link.

## 📲 Installation

`LabelTapGesture` is available on [CocoaPods](https://cocoapods.org/pods/LabelTapGesture):

```ruby
pod 'LabelTapGesture'
```

## 📝 How
### Code Implementation
```swift
import LabelTapGesture
```
Example Terms and Conditions Label.
```swift
@IBOutlet var termsConditionLabel: UILabel!

// Example Terms and Conditions text.
let text:String = "By signing up you confirm your agreement with our terms and conditions. We’ll never share your information"
let textAttributes:[NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16)]
        
let rangeText:String = "terms and conditions"
let rangeTextAttributes:[NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16),
                                                          .foregroundColor: UIColor.blue,
                                                          .underlineStyle: NSUnderlineStyle.single]

self.termsConditionLabel.addTapGesture(text: text, textAttributes: textAttributes,
                                       tapOnText: rangeText, tapOnTextAttributes: rangeTextAttributes) {
    // Handles when tapping the rangeText on the label.
}
```

## 📋 Requirements

* iOS 10.0+
* Xcode 11+
* Swift 5.1+
