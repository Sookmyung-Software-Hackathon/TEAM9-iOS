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

// MARK: - Extension (화면전환)

extension RecordListViewController {
    
    private func goToQuestionListViewController() {
        guard let questionListViewController = UIStoryboard(name: Const.Storyboard.QuestionList, bundle: nil)
            .instantiateViewController(withIdentifier: Const.ViewController.QuestionListViewController) as? QuestionListViewController else { return }
        questionListViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(questionListViewController, animated: true)
    }
    
}

extension RecordListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            goToQuestionListViewController()
        default:
            print("zz")
        }
    }
    
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
