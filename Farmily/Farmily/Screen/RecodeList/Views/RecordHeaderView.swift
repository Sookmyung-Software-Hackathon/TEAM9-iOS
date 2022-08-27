//
//  RecordHeaderView.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

final class RecordHeaderView: UIView {
    
    private let bgView = UIView().then {
        $0.backgroundColor = .RecordListNavy
    }
    
    private let sheepImageView = UIImageView().then {
        $0.image = Const.Image.imgAnimal02
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "가족과의 울타리"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .white
    }
    
    private let subtitleLabel = UILabel().then {
        $0.text = "지난 답변들을 모아볼 수 있어요"
        $0.font = .systemFont(ofSize: 15, weight: .semibold)
        $0.textColor = .white.withAlphaComponent(0.5)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    init() {
        super.init(frame: CGRect.zero)
        
        setUI()
    }
    
    private func setUI() {
        setLayout()
        
        self.roundCorners(cornerRadius: 18, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
    }
    
    private func setLayout() {
        
        self.addSubviews([bgView])
        
        bgView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
        
        bgView.addSubviews([sheepImageView, titleLabel, subtitleLabel])
        
        sheepImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(3)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(89)
            $0.height.equalTo(106)
        }
        
        titleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(36)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(14)
            $0.trailing.equalTo(titleLabel.snp.trailing)
        }
    }
    
}
