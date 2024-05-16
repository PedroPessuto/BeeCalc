//
//  CalculatorViewController.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 15/05/24.
//

import UIKit
//
//class CalculatorViewController: UIViewController {
//    
//    let buttons: [[(String, ButtonVariants)]] = [
//        [("(", .yellow), (")", .yellow), ("var", .purple), ("clear.fill", .pink)],
//        [("7", .purple), ("8", .purple), ("9", .purple), ("/", .yellow)],
//        [("4", .purple), ("5", .purple), ("6", .purple), ("*", .yellow)],
//        [("1", .purple), ("2", .purple), ("3", .purple), ("-", .yellow)],
//        [("0", .purple), (".", .yellow), ("=", .yellow), ("+", .yellow)]
//    ]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        let gridStackView = UIStackView()
//        gridStackView.axis = .vertical
//        gridStackView.alignment = .fill
//        gridStackView.distribution = .fillEqually
//        gridStackView.spacing = 10
//        gridStackView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(gridStackView)
//        
//        NSLayoutConstraint.activate([
//            gridStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            gridStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            gridStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        
//        for row in buttons {
//            let rowStackView = UIStackView()
//            rowStackView.axis = .horizontal
//            rowStackView.alignment = .fill
//            rowStackView.distribution = .fillEqually
//            rowStackView.spacing = 10
//            
//            for buttonInfo in row {
//                let button: Button
//                if buttonInfo.1 == .pink {
//                    button = Button(variant: buttonInfo.1, systemName: buttonInfo.0)
//                } else {
//                    button = Button(buttonText: buttonInfo.0, variant: buttonInfo.1)
//                }
//                rowStackView.addArrangedSubview(button)
//            }
//            
//            gridStackView.addArrangedSubview(rowStackView)
//        }
//    }
//}
//
//#Preview {
//    CalculatorViewController()
//}
