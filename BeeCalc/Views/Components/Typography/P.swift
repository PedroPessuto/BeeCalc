//
//  P.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 23/05/24.
//

import UIKit

class P: UILabel {
    
    // ========== CONSTRUCTORS ==========
    init(text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .left
        self.numberOfLines = 10
        self.textColor = UIColor(.white)
        self.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
