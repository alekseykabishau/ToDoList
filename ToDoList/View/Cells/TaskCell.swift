//
//  TaskCell.swift
//  ToDoList
//
//  Created by Aleksey on 0510..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

protocol TaskCellUpdating {
	func onTextViewChanged(text: String, object: Any?)
}

class TaskCell: UITableViewCell {
	
	var updatingDelegate: TaskCellUpdating!
	var object: Any!
	
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var checkBoxImageView: UIImageView!
	
	
	func commonInit() {
		setCell("", completed: false)
		textView.delegate = self
		updatingDelegate = nil
		object = nil
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
		textView.textContainerInset = .zero
		textView.textContainer.lineFragmentPadding = 0
		
		commonInit()
    }
	
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		commonInit()
	}
	
	
	func setCell(_ text: String, completed: Bool) {
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineHeightMultiple = 1.3
		
		var attributes = [NSAttributedString.Key.font: UIFont(name: "Avenir", size: 16)!,
						  NSAttributedString.Key.foregroundColor: UIColor(red: 0.22, green: 0.24, blue: 0.25, alpha: 1.0),
						  NSAttributedString.Key.paragraphStyle: paragraphStyle
		]
		
		if completed {
			checkBoxImageView.image = UIImage(named: "checkbox-ticked")
			attributes[NSAttributedString.Key.strikethroughStyle] = NSNumber(value: NSUnderlineStyle.single.rawValue)
		} else {
			checkBoxImageView.image = UIImage(named: "checkbox")
		}
		
		textView.attributedText = NSAttributedString(string: text, attributes: attributes)
		
		
	}
	
	
	func beginEditing() {
		textView.becomeFirstResponder()
	}
}

extension TaskCell: UITextViewDelegate {
	
	func textViewDidChange(_ textView: UITextView) {
		updatingDelegate.onTextViewChanged(text: textView.text, object: object)
	}
}
