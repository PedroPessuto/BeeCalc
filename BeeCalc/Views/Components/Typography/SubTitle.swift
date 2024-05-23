//
//  P.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 22/05/24.
//

import UIKit

class SubTitle: UILabel {
    
    // ========== CONSTRUCTORS ==========
    init(text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .left
        self.numberOfLines = 2
        self.textColor = UIColor(.white)
        self.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
