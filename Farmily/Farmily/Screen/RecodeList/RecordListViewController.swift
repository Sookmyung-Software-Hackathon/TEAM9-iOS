//
//  RecordListViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import SnapKit
import Then

final class RecordListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    private func setTableView() {
        
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        registerXib()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerXib() {
        tableView.register(UINib(nibName: Const.Identifier.RecordListTableViewCell, bundle: nil),
                           forCellReuseIdentifier: Const.Identifier.RecordListTableViewCell)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: "EmptyTableViewCell")
    }
}

extension RecordListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return RecordHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 100
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 76
    }
}

extension RecordListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 10
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as? EmptyTableViewCell else { return UITableViewCell() }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Const.Identifier.RecordListTableViewCell, for: indexPath) as? RecordListTableViewCell else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

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
