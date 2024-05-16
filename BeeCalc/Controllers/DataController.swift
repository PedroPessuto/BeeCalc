//
//  DataController.swift
//  BeeCalc
//
//  Created by Sofia Lee on 16/05/24.
//

import Foundation
import SwiftData

class DataController {
    
    // ========== Atributtes ==========
    @MainActor
    private var container: ModelContainer = {
        let schema = Schema([
            Formula.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false, cloudKitDatabase: .none)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // ========== Functions ==========
    
    
    // Create Formula
    @MainActor
    public func createFormula(_ formula: Formula) -> Result<Bool, DataControllerErrors> {
        self.container.mainContext.insert(formula)
        return .success(true)
    }
    
    // Get Formulas
    @MainActor
    public func getFormulas() -> Result<[Formula], DataControllerErrors> {
        do {
            let descriptor: FetchDescriptor = FetchDescriptor<Formula>()
            let formulas: [Formula] = try container.mainContext.fetch(descriptor)
            return .success(formulas)
        }
        catch {
            return .failure(.FailToGetFormulas)
        }
    }
    
    // Deltete Formulas
    @MainActor
    public func deleteFormula(_ formula: Formula) -> Result<Bool, DataControllerErrors> {
        container.mainContext.delete(formula)
        return .success(true)
    }
    
}
