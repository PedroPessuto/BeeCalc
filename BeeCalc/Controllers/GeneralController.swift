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
        getFormulas()
    }
    
    public func getFormulas() {
        Task {
            let response: Result<[Formula], DataControllerErrors> = await dataController.getFormulas()
            if case .success(let formulas) = response {
                self.formulas = formulas
            }
        }
    }
    
    public func addFormula() {
        Task {
            let formula: Formula = Formula(name: "Fórmula \(formulas.count + 1)")
            let _ = await dataController.createFormula(formula)
            formulas.append(formula)
        }
    }
    
    public func deleteFormula(_ formula: Formula) {
        Task {
            let _ = await dataController.deleteFormula(formula)
            formulas.removeAll { index in
                index.id == formula.id
            }
        }
    }
    
}
