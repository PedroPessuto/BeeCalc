//
//  NumberCard.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 22/05/24.
//

import UIKit

class NumberCard: UIView {
    
    // ========== ATTRIBUTES ==========
    var variant: NumberCardVariants
    private let label: UILabel = UILabel()
    
    // ========== METHODS ==========
    private func setElements() {
        setConfig()
        setLabel()
    }
  
    private func setLabel() {
        addSubview(label)
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
    private func setConfig() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(greaterThanOrEqualToConstant: 30),
            widthAnchor.constraint(equalToConstant: 30)
        ])
        
        switch variant {
            case .number:
                backgroundColor = UIColor(named: "CinzaClaro")
                label.textColor = UIColor(named: "Roxo")
            case .operation:
                backgroundColor = UIColor(named: "Amarelo")
                label.textColor = UIColor(.white)
        }
    }
    
    // ========== CONSTRUCTORS ==========
    init(text: String, variant: NumberCardVariants) {
        self.label.text = text
        self.variant = variant
        super.init(frame: .zero)
        setElements()
    }
    
    required init?(coder: NSCoder) {
        return nil

    }
    
}
