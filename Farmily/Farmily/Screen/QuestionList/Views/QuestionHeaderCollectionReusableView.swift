//
//  QuestionHeaderCollectionReusableView.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import UIKit

import SnapKit
import Then

final class QuestionHeaderCollectionReusableView: UICollectionReusableView {
    
    private let titleLabel = UILabel().then {
        $0.text = "27주차엔 어떤 질문들이 있었나요?"
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        
        addSubviews([titleLabel])
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
        }
    }
}
