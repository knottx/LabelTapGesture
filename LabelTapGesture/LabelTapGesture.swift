//
//  LabelTapGesture.swift
//  LabelTapGesture
//
//  Created by Developer on 22/2/21.
//

import UIKit

class LabelTapGesture: UITapGestureRecognizer {
    var rangeText: String?
    var completion: (() -> ())?
}

extension String {
    
    func attributed(_ attributes: [NSAttributedString.Key:Any]?) -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self, attributes: attributes)
    }
    
    func range(of rangeText:String) -> NSRange {
        return (self as NSString).range(of: rangeText)
    }
    
}

extension UILabel {
    
    public func addTapGesture(text: String, textAttributes: [NSAttributedString.Key:Any]?,
                              rangeText: String, rangeTextAttributes: [NSAttributedString.Key:Any],
                              completion: @escaping () -> ()) {
        let attributedString = text.attributed(textAttributes)
        attributedString.addAttributes(rangeTextAttributes, range: text.range(of: rangeText))
        self.isUserInteractionEnabled = true
        self.attributedText = attributedString
        let tapgesture: LabelTapGesture = .init(target: self, action: #selector(self.tappedOnAttributedText(_:)))
        tapgesture.numberOfTapsRequired = 1
        tapgesture.rangeText = rangeText
        tapgesture.completion = completion
        self.addGestureRecognizer(tapgesture)
    }

    @objc func tappedOnAttributedText(_ gesture: LabelTapGesture) {
        guard let text = self.text,
              let rangeText = gesture.rangeText,
              let completion = gesture.completion else { return }
        let range = (text as NSString).range(of: rangeText)
        if gesture.didTapAttributedTextInLabel(label: self, inRange: range) {
            completion()
        }
    }
    
}

extension UITapGestureRecognizer {
    
    public func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y)
        var indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        indexOfCharacter = indexOfCharacter + 4
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}
