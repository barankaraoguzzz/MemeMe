//
//  MemeTextFields.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 26.02.2021.
//

import UIKit

class MemeTextFields: UITextField {
    
    ///Constants
    private let memeTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.strokeColor: UIColor.black,
                                                                     NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                     NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
                                                                     NSAttributedString.Key.strokeWidth:  -4.0]
    

    //MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configures()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configures()
    }

    //MARK: - Private Methods
    
    private func configures() {
        self.defaultTextAttributes = memeTextAttributes
        self.textAlignment = .center
    }
    
    
}
