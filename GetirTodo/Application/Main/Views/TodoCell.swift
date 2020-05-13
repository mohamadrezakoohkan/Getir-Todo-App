//
//  TodoCell.swift
//  GetirTodo
//
//  Created by Mohammad reza Koohkan on 2/23/1399 AP.
//  Copyright © 1399 AP Mohamadreza Koohkan. All rights reserved.
//

import UIKit

final class TodoCell: UITableViewCell, NibbedCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var monthDayLbl: UILabel!
    
    lazy var viewModel = TodoCellViewModel(model: self, todo: self.todo)
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.cellTapped))
    
    var todo: Todo! {
        didSet {
            self.viewModel.todo = self.todo
            self.viewModel.feed()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewModel.setupGestures()
    }
    
    @objc func cellTapped() {
        self.viewModel.tapped()
    }
    
}
