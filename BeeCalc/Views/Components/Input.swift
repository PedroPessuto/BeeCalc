//
//  Input.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 21/05/24.
//

import UIKit

class Input: UITextField {
    
    init(text: String?, variant: InputVariants = .deafult) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text
       
        self.font = .systemFont(ofSize: 20, weight: .bold)
        self.layer.cornerRadius = 10
        self.textAlignment = .center
        
        switch variant {
            case .deafult:
                self.backgroundColor = UIColor(named: "Cinza")
                self.textColor = UIColor(named: "Roxo")
            
            case .yellow:
                self.backgroundColor = UIColor(named: "Amarelo")
                self.textColor = UIColor.white
            
        }
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
