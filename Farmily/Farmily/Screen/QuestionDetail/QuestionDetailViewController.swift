//
//  QuestionDetailViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import SnapKit
import Then
import RxSwift

final class QuestionContentTableViewCell: UITableViewCell {
    
    private let contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
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
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.lessThanOrEqualTo(20).priority(.low)
        }
    }
    
    func setData(content: String) {
        contentsLabel.text = content
    }
}

final class QuestionDetailViewController: UIViewController {
    
    var week: Int?
    var day: Int?
    var questionText: String?

    var question: [Question]?
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerBottomWhiteView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAnswers()
        setTableView()
    }
    
    private func setTableView() {
        registerXib()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        if let questionText = questionText {
            questionLabel.text = questionText
        }
        
        headerBottomWhiteView.roundCorners(cornerRadius: 16, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension

extension QuestionDetailViewController {
    
    private func getAnswers() {
        if let week = week, let day = day {
            NetworkService.shared.question.getDayAnswer(week: week, day: day)
                .compactMap { $0.data }
                .bind { data in
                    print(data)
                    self.question = data
                    self.tableView.reloadData()
                }
                .disposed(by: disposeBag)
        }
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
        return question?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionContentTableViewCell", for: indexPath) as? QuestionContentTableViewCell else { return UITableViewCell() }
        if let question = question {
            cell.setData(content: question[indexPath.row].answer ?? "")
        }
        return cell
    }
    
    
}
