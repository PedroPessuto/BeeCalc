//
//  Input.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 21/05/24.
//

import UIKit

class Input: UITextField {
    
    init(text: String?) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        self.backgroundColor = UIColor(named: "Cinza")
        self.font = .systemFont(ofSize: 20, weight: .bold)
        self.textColor = UIColor(named: "Roxo")
        self.layer.cornerRadius = 10
        self.textAlignment = .center
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
