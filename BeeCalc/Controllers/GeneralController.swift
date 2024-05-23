//
//  GeneralController.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 16/05/24.
//

import Foundation

class GeneralController {
    
    static let shared: GeneralController = GeneralController()
    private let dataController: DataController = DataController()
    public var formulas: [Formula] = []
    public var resultText: String? = nil
    
    public func getFormulas() async -> Result<[Formula], GeneralControllerErrors> {
        let response: Result<[Formula], DataControllerErrors> = await dataController.getFormulas()
        if case .success(let formulas) = response {
            self.formulas = formulas
            return .success(formulas)
        }
        return .failure(.FailToGetFormula)
    }
    
    public func addFormula() async -> Result<Formula, Error> {
        let formula: Formula = Formula(name: "Nova Fórmula")
        let _ = await dataController.createFormula(formula)
        formulas.append(formula)
        return .success(formula)
    }
    
    public func deleteFormula(_ formula: Formula) async {
        formulas.removeAll { index in
            index.id == formula.id
        }
        let _ = await dataController.deleteFormula(formula)
        
    }
}
