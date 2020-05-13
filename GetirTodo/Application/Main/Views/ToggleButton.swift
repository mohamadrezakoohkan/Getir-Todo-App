//
//  ToggleButton.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/24/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIButton

final class ToggleButton: UIButton {
    
    @IBInspectable var secondaryImage: String = ""
    @IBInspectable var primaryImage: String = "" {
        didSet {
            self.setImage(self.primary, for: .normal)
        }
    }
    
    
    lazy var secondary: UIImage? = {
        let image = UIImage(systemName: self.secondaryImage)!
        let scale = UIImage.SymbolScale.large
        let configuration = UIImage.SymbolConfiguration(scale: scale)
        return image.withConfiguration(configuration)
    }()
    
    lazy var primary: UIImage? = {
        let image = UIImage(systemName: self.primaryImage)!
        let scale = UIImage.SymbolScale.large
        let configuration = UIImage.SymbolConfiguration(scale: scale)
        return image.withConfiguration(configuration)
    }()
    
    
    var isOnPrimary: Bool = true {
        didSet {
            self.setImage(self.isOnPrimary ? self.primary : self.secondary, for: .normal)
        }
    }
    
    var shouldToggle: Bool = true {
        didSet {
            if shouldToggle == self.isOnPrimary {
                self.toggle()
            }
        }
    }
    
    func toggle() {
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { finished in
            if finished {
                self.isOnPrimary.toggle()
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 1
                    self.transform = CGAffineTransform.identity
                }, completion: {
                    if $0 {
                        self.isUserInteractionEnabled = true
                    }
                })
            }
        })
        
    }
    
}
