//
//  QuestionDetailViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import SnapKit
import Then

final class QuestionContentTableViewCell: UITableViewCell {
    
    private let contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.numberOfLines = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        
        addSubviews([contentsLabel])
        
        contentsLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.height.lessThanOrEqualTo(20).priority(.low)
        }
    }
}

final class QuestionDetailViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerBottomWhiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    private func setTableView() {
        registerXib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        
        headerBottomWhiteView.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension QuestionDetailViewController {
    
    private func registerXib() {
        tableView.register(QuestionContentTableViewCell.self, forCellReuseIdentifier: "QuestionContentTableViewCell")
    }
}

extension QuestionDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension QuestionDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionContentTableViewCell", for: indexPath)
        return cell
    }
    
    
}
