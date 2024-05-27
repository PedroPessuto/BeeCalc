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
    public var formula: String = ""
    public var rating: Int = 1
    
    init(name: String) {
        self.name = name
    }
    
}


