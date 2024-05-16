//
//  BigTitle.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 15/05/24.
//

import UIKit

class BigTitle: UILabel {
    
    // ========== CONSTRUCTORS ==========
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        self.textAlignment = .center
        self.textColor = UIColor(named: "Roxo")
        self.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
}
