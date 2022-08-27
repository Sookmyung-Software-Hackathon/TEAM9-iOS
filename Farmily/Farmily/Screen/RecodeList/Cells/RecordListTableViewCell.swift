//
//  RecordListTableViewCell.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

final class RecordListTableViewCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUI()
        
        self.selectedBackgroundView = UIView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12.0, left: 16, bottom: 0, right: 16))
    }
    
    private func setUI() {
        bgView.cornerRadius = 12
    }
    
}
