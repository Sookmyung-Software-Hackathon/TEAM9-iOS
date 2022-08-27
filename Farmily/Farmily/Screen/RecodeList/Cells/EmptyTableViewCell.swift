//
//  EmptyTableViewCell.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import SnapKit
import Then

final class EmptyTableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let bgView = UIView().then {
        $0.backgroundColor = .RecordListNavy
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
       // setLayout()
    }
    
    private func setLayout() {
        
        addSubviews([bgView])
        bgView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}
