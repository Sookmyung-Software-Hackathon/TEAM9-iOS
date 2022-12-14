//
//  AnswerQuestionViewController.swift
//  Farmily
//
//  Created by 안현주 on 2022/08/28.
//

import UIKit
import RxSwift

class AnswerQuestionViewController: UIViewController {

    var question: TodayQuestion?
    private let disposeBag = DisposeBag()
	let textViewPlaceHolder = "이곳을 눌러서 오늘의 답변을 써주세요."
	
	@IBOutlet weak var questionView: UIView!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var answerView: UIView!
	@IBOutlet weak var answerTextView: UITextView!
	@IBOutlet weak var fenceImageView: UIImageView!
	@IBOutlet weak var finishAnswerView: UIView!
	@IBOutlet weak var finishAnswerButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
        if let question = question {
            self.questionLabel.text = question.question
        }
		setUI()
		setAnswerTextView()
    }

	private func setUI(){
		questionView.backgroundColor = UIColor(red: 0.733, green: 0.82, blue: 0.741, alpha: 0.6)
		questionView.cornerRadius = 12
		answerView.backgroundColor = UIColor(red: 0.733, green: 0.82, blue: 0.741, alpha: 0.6)
		answerView.cornerRadius = 12
		finishAnswerView.cornerRadius = 25
	}
	
	private func setAnswerTextView(){
		answerTextView.text = textViewPlaceHolder
		answerTextView.textColor = UIColor(named: "AnswerPlaceHolder")
		answerTextView.backgroundColor = .clear
		answerTextView.delegate = self
	}
	@IBAction func pressToGoBack(_ sender: Any) {
		self.dismiss(animated: true)
	}
	
	@objc private func didTapTextView(_ sender: Any) {
		view.endEditing(true)
	}
    
    @IBAction func finishAnswerButtonDidTap(_ sender: Any) {
        if let question = question {
            NetworkService.shared.question.postAnswerTodayQuestion(todayAnswer: PostTodayAnswer(id: question.id, answer: answerTextView.text))
                .compactMap { $0.data }
                .bind {
                   
                    self.makeOKAlert(title: nil, message: "답변 완료 되었습니다.") { _ in
                        self.dismiss(animated: true)
                    }
                }
                .disposed(by: disposeBag)
        }
        
    }
    

}

extension AnswerQuestionViewController: UITextViewDelegate {
	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.text == textViewPlaceHolder {
			textView.text = nil
			textView.textColor = UIColor(named: "QuestionLabel")
		}
	}
}

extension UILabel {
	func asColor(targetString: String, color: UIColor?) {
		let fullText = text ?? ""
		let range = (fullText as NSString).range(of: targetString)
		let attributedString = NSMutableAttributedString(string: fullText)
		attributedString.addAttribute(.foregroundColor, value: color as Any, range: range)
		attributedText = attributedString
	}
}
