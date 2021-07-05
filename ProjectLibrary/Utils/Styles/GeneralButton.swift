//
//  GeneralButton.swift
//  ProjectLibrary
//
//  Created by Camilo Betancourt on 1/07/21.
//

import UIKit

class GeneralButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 0.00,
                                    green: 0.68,
                                    blue: 0.93,
                                    alpha: 1.00)
    }
    
}
