//
//  UIButton+Observer.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit
import Combine

public extension UIButton {
    

    @discardableResult
    func onTap(_ completion: @escaping (UIButton) -> Void) -> AnyCancellable {
        self.publisher(for: .touchUpInside).sink { _ in
            completion(self)
        }
    }
}
