//
//  StringTable.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import Foundation

protocol StringTable {
    
    
    static func localize(_ key: String) -> String
    
    static var table: String { get set }
    
    func localize(_ key: String) -> String
}

extension StringTable {
        
    static func localize(_ key: String) -> String {
        return Bundle.main.localizedString(forKey: key, value: nil, table: Self.table)
    }
    
    func localize(_ key: String) -> String {
        return Self.localize(key)
    }
    
}
