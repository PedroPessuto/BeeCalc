//
//  Card.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 15/05/24.
//

import UIKit
        
class Card: UIView {
    
    // ========== ATTRIBUTES ==========
    private var generalController: GeneralController = GeneralController.shared
    public var formula: Formula
    public var deleteAction: @MainActor () async -> () = {}
    public var editAction: () -> Void = {}
    private let head: UIView = UIView()
    private let title: Title = Title(text: "")
    private let footer: UIView = UIView()
    
    // ========== CONSTRUCTORS ==========
    init(formula: Formula) {      
        self.formula = formula
        self.title.text = formula.name
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
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
        setRating()
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
    
    private func setRating() {
      
        let stackView = UIStackView()
        self.addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 10
        
        for i in 1...5 {
            let button = UIButton()
            button.setImage(UIImage(systemName: i > formula.rating ? "star" : "star.fill"), for: .normal)
            button.tintColor = UIColor.white
            stackView.addArrangedSubview(button)
            
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         
        ])
    }
    
    @objc private func handleDeleteAction() {
        Task {
            await generalController.deleteFormula(formula)
            await deleteAction()

        }
    }
    
    @objc private func handleEditAction() {
        editAction()
        
    }
}
