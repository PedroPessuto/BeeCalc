//
//  Button.swift
//  BeeCalc
//
//  Created by Sofia Lee on 14/05/24.
//

import UIKit

class Button: UIButton {
    
    // ========== ATTRIBUTES ==========
    var buttonText: String?
    var variant: ButtonVariants
    var systemName: String?
    
    // ========== METHODS ==========
    
    private func setupButton() {
        translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
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
            imageView?.tintColor = UIColor(.white)
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
        
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 36, weight: .bold)
    }
    
    private func setBackground() {
        layer.cornerRadius = 10
        switch variant {
            case .purple:
                backgroundColor = UIColor(named: "Roxo")
            case .yellow:
                backgroundColor = UIColor(named: "Amarelo")
            case .pink:
                backgroundColor = UIColor(named: "Rosa")
        }
    }
    
    // ========== CONSTRUCTORS ==========
    init(buttonText: String? = nil, variant: ButtonVariants = .purple, systemName: String? = nil) {
        self.buttonText = buttonText
        self.variant = variant
        self.systemName = systemName
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        return nil
//        guard let buttonText = coder.decodeObject(forKey: ButtonFields.buttonText.rawValue) as? String,
//              let variantString = coder.decodeObject(forKey: ButtonFields.variant.rawValue) as? String,
//              let systemName = coder.decodeObject(forKey: ButtonFields.systemName.rawValue) as? String,
//              let variant = ButtonVariants(rawValue: variantString)
//        else {
//            return nil
//        }
//        
//        self.buttonText = buttonText
//        self.variant = variant
//        self.systemName = systemName
//        super.init(coder: coder)
//        setupButton()
    }
    
//    override func encode(with coder: NSCoder) {
//        coder.encode(buttonText, forKey: ButtonFields.buttonText.rawValue)
//        coder.encode(variant.rawValue, forKey: ButtonFields.variant.rawValue)
//        coder.encode(image, forKey: ButtonFields.systemName.rawValue)
//        super.encode(with: coder)
//    }
}
