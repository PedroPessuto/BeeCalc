//
//  Formula.swift
//  BeeCalc
//
//  Created by Sofia Lee on 16/05/24.
//

import Foundation
import SwiftData

@Model
class Formula {
    public var id: String = UUID().uuidString
    public var name: String
    public var formula: String?
    
    init(name: String) {
        self.name = name
    }
    
}
