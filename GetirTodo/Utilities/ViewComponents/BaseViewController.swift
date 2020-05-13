//
//  BaseViewController.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit.UIViewController
import SafariServices

public class BaseViewController: UIViewController {
    
    final func open(urlString: String, push: Bool = false) {
        guard let url = URL(string: urlString) else { return }
        self.open(url: url)
    }
    
    final func open(url: URL, push: Bool = false) {
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true, completion: nil)
    }
}
