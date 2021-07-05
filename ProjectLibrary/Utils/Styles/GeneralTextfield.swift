//
//  GeneralTextfield.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 1/07/21.
//

import UIKit

class GeneralTextfield: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: frame.height))
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        leftView = paddingView
        leftViewMode = UITextField.ViewMode.always
    }
    
}
