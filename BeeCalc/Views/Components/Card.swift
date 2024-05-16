//
//  Card.swift
//  BeeCalc
//
//  Created by Sofia Lee on 15/05/24.
//

import UIKit

class Card: UIView {
    
    // ========== ATTRIBUTES ==========
    public var formula: Formula? = nil
    public var deleteAction: () -> Void = {}
    public var editAction: () -> Void = {}
    private let head: UIView = UIView()
    private let title: Title = Title(text: "")
    private let footer: UIView = UIView()
    
    // ========== CONSTRUCTORS ==========
    init(formula: Formula? = nil) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.formula = formula
        if let form: Formula = formula {
            self.title.text = form.name
        }
        setElements()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // ========== METHODS ==========
    private func setElements() {
        setHead()
        setTitle()
        setFooter()
        
//        NSLayoutConstraint.activate([
//            self.heightAnchor.constraint(greaterThanOrEqualToConstant: 175)
//        ])
    }
    
    private func setHead() {
        addSubview(head)
        
        head.translatesAutoresizingMaskIntoConstraints = false
        head.backgroundColor = UIColor(named: "Roxo")
        head.layer.cornerRadius = 10
        head.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        NSLayoutConstraint.activate([
            head.topAnchor.constraint(equalTo: self.topAnchor),
            head.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            head.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            head.heightAnchor.constraint(equalToConstant: 125)
        ])
    }
    
    private func setTitle() {
        addSubview(title)
        title.numberOfLines = 2
        title.lineBreakMode = .byTruncatingTail
        title.textAlignment = .left
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: head.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: head.leadingAnchor, constant: 20),
            title.trailingAnchor.constraint(equalTo: head.trailingAnchor, constant: -20)
        ])
    }
    
    private func setFooter() {
        addSubview(footer)
        footer.backgroundColor = UIColor.black
        footer.translatesAutoresizingMaskIntoConstraints = false
        footer.layer.cornerRadius = 10
        footer.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        NSLayoutConstraint.activate([
            footer.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            footer.topAnchor.constraint(equalTo: head.bottomAnchor),
            footer.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            footer.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let leftContainer: UIView = UIView()
        footer.addSubview(leftContainer)
        leftContainer.translatesAutoresizingMaskIntoConstraints = false
        leftContainer.backgroundColor = UIColor(named: "Rosa")
        leftContainer.layer.cornerRadius = 10
        leftContainer.layer.maskedCorners = [.layerMinXMaxYCorner]
        
        NSLayoutConstraint.activate([
            leftContainer.heightAnchor.constraint(equalTo: footer.heightAnchor),
            leftContainer.widthAnchor.constraint(equalTo: footer.widthAnchor, multiplier: 0.5),
            leftContainer.leadingAnchor.constraint(equalTo: footer.leadingAnchor),
            leftContainer.topAnchor.constraint(equalTo: footer.topAnchor)
        ])
        
        let leftImage: UIImageView = UIImageView(image: UIImage(systemName: "trash.fill"))
        leftContainer.addSubview(leftImage)
        leftImage.translatesAutoresizingMaskIntoConstraints = false
        leftImage.tintColor = UIColor.white
        
        NSLayoutConstraint.activate([
        
            leftImage.heightAnchor.constraint(equalToConstant: 24),
            leftImage.widthAnchor.constraint(equalToConstant: 24),
            leftImage.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor),
            leftImage.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor)
        ])
        
        let leftTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDeleteAction))
        leftContainer.addGestureRecognizer(leftTapGesture)
        
        let rightContainer: UIView = UIView()
        footer.addSubview(rightContainer)
        rightContainer.translatesAutoresizingMaskIntoConstraints = false
        rightContainer.backgroundColor = UIColor(named: "Amarelo")
        rightContainer.layer.cornerRadius = 10
        rightContainer.layer.maskedCorners = [.layerMaxXMaxYCorner]
        
        NSLayoutConstraint.activate([
            rightContainer.heightAnchor.constraint(equalTo: footer.heightAnchor),
            rightContainer.widthAnchor.constraint(equalTo: footer.widthAnchor, multiplier: 0.5),
            rightContainer.trailingAnchor.constraint(equalTo: footer.trailingAnchor),
            rightContainer.topAnchor.constraint(equalTo: footer.topAnchor)
        ])
        
        let rightImage = UIImageView(image: UIImage(systemName: "pencil"))
        rightImage.translatesAutoresizingMaskIntoConstraints = false
        rightContainer.addSubview(rightImage)
        rightImage.tintColor = UIColor.white
        
        NSLayoutConstraint.activate([
            rightImage.heightAnchor.constraint(equalToConstant: 24),
            rightImage.widthAnchor.constraint(equalToConstant: 24),
            rightImage.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor),
            rightImage.centerXAnchor.constraint(equalTo: rightContainer.centerXAnchor)
        ])
        
        let rightTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleEditAction))
        rightContainer.addGestureRecognizer(rightTapGesture)
    }
    
    @objc private func handleDeleteAction() {
        deleteAction()
    }
    
    @objc private func handleEditAction() {
        editAction()
    }
}
