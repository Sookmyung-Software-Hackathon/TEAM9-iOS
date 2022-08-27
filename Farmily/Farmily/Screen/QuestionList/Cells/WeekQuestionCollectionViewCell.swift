//
//  WeekQuestionCollectionViewCell.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import SnapKit
import Then

final class WeekQuestionCollectionViewCell: UICollectionViewCell {
    
    private let bgView = UIView().then {
        $0.backgroundColor = .RecordListGreen37
        $0.cornerRadius = 18
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLayout()
    }
    
    private func setLayout() {
        
        addSubviews([bgView])
        
        bgView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(4)
        }
    }

}
