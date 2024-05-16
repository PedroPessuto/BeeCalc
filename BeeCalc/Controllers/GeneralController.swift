//
//  GeneralController.swift
//  BeeCalc
//
//  Created by Sofia Lee on 16/05/24.
//

import Foundation

class GeneralController {
    
    static let shared: GeneralController = GeneralController()
    private let dataController: DataController = DataController()
    public var formulas: [Formula] = []
    
    private init() {
        Task {
            let response: Result<[Formula], DataControllerErrors> = await dataController.getFormulas()
            if case .success(let formulas) = response {
                self.formulas = formulas
            }
        }
    }
}
