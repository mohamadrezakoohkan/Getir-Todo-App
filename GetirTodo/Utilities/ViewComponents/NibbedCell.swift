//
//  NibbedCell.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

protocol NibbedCell {
    
    static var identifier: String { get }
    
    static var nib: UINib { get }
    
    static func register(in table: UITableView)
    
    static func deque(in table: UITableView) -> UITableViewCell
    
    static func bind(to cell: UITableViewCell, _ completion: (Self) -> Void)

}

extension NibbedCell where Self: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: Self.identifier, bundle: Bundle.main)
    }
    
    static func register(in table: UITableView) {
        table.register(Self.nib, forCellReuseIdentifier: Self.identifier)
    }
    
    static func deque(in table: UITableView) -> UITableViewCell {
       return table.dequeueReusableCell(withIdentifier: Self.identifier)!
    }
    
    static func bind(to cell: UITableViewCell, _ completion: (Self) -> Void) {
        completion(cell as! Self)
    }
    
}
