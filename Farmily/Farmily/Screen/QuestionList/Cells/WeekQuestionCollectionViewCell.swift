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
    
    private let questionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setLayout()
    }
    
    private func setLayout() {
        
        addSubviews([bgView])
        
        bgView.addSubviews([questionLabel])
        
        bgView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        questionLabel.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview().inset(8)
        }
    }
    
    func setData(question: Question) {
        questionLabel.text = question.question
    }

}
