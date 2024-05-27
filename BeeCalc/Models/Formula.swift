//
//  Formula.swift
//  BeeCalc
//
//  Created by Pedro Pessuto on 16/05/24.
//

import Foundation
import SwiftData

@Model
class Formula {
    public var id: String = UUID().uuidString
    public var name: String
    public var singleGrades: [String] = []
    public var weightedGrades: [String] = ["N1", "1"]
    public var averageGrade: String = ""
    
    init(name: String) {
        self.name = name
    }
    
}


