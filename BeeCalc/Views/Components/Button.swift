//
//  Button.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 14/05/24.
//

import UIKit

class Button: UIButton {
    
    // ========== ATTRIBUTES ==========
    var buttonText: String?
    var variant: ButtonVariants
    var systemName: String?
    var action: () -> Void = {}
    
    // ========== METHODS ==========
    
    @objc func doAction() {
        self.action()
    }
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let actionTap = UITapGestureRecognizer(target: self, action: #selector(doAction))
        addGestureRecognizer(actionTap)
        
        setBackground()
        if (buttonText != nil) {
            setLabel()
        }
        if (systemName != nil) {
            setIcon()
        }
       
    }
    
    private func setIcon() {
        if let name = systemName {
            setImage(UIImage(systemName: name), for: .normal)
            
            imageView?.translatesAutoresizingMaskIntoConstraints = false
            
            if let imageView = imageView {
                NSLayoutConstraint.activate([
                    imageView.heightAnchor.constraint(equalToConstant: 36),
                    imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
                    imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                    imageView.centerYAnchor.constraint(equalTo: centerYAnchor)
                ])
            }
        }
    }
    
    private func setLabel() {
        if let text = self.buttonText {
            setTitle(text, for: .normal)
        }
        
        
        titleLabel?.font = .systemFont(ofSize: 36, weight: .bold)
    }
    
    private func setBackground() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        imageView?.tintColor = UIColor(.white)
        
        switch variant {
            
            case .purple:
                backgroundColor = UIColor(named: "Roxo")
            case .yellow:
                backgroundColor = UIColor(named: "Amarelo")
            case .pink:
                backgroundColor = UIColor(named: "Rosa")
            case .white:
                backgroundColor = UIColor(named: "CinzaClaro")
                setTitleColor(UIColor(named: "Roxo"), for: .normal)
                imageView?.tintColor = UIColor(named: "Roxo")
        }
    }
    
    // ========== CONSTRUCTORS ==========
    init(buttonText: String? = nil, variant: ButtonVariants = .purple, systemName: String? = nil, doAction: @escaping () -> Void = {}) {
        self.buttonText = buttonText
        self.variant = variant
        self.systemName = systemName
        self.action = doAction
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        return nil

    }
}
