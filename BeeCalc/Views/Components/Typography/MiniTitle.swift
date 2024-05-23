//
//  MiniTitle.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 23/05/24.
//

import UIKit

class MiniTitle: UILabel {
    
    // ========== CONSTRUCTORS ==========
    init(text: String? = nil) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .left
        self.textColor = UIColor(.white)
        self.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
