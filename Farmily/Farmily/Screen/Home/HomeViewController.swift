//
//  HomeViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import RxSwift

final class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()

    var questionToday: TodayQuestion?

	@IBOutlet weak var questionLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        getTodayQuestion()
    }
    
	@IBAction func pressToGoAnswerQuestionView(_ sender: Any) {
		
        if let isAnSwered = questionToday?.isAnswered,
                isAnSwered == false,
            let questionToday = questionToday{
            let storyboard = UIStoryboard(name: "AnswerQuestion", bundle : nil)
                                                     
            guard let answerQuestionVC = storyboard.instantiateViewController(withIdentifier: "AnswerQuestionViewController") as? AnswerQuestionViewController else { return }
            answerQuestionVC.question = questionToday
            answerQuestionVC.modalPresentationStyle = .fullScreen
            self.present(answerQuestionVC, animated: true, completion: nil)
        }
        else {
            self.makeOKAlert(title: nil, message: "이미 답변한 질문입니다.")
        }
	}
	

}

// MARK: - Extension (Network)
extension HomeViewController {
    
    private func getTodayQuestion() {
        NetworkService.shared.question.getTodayQuestion()
            .compactMap { $0.data }
            .bind {
                self.questionToday = $0
                self.questionLabel.text = $0.question
            }
            .disposed(by: disposeBag)
    }
}
