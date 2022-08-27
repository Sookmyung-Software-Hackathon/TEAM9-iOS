//
//  HomeViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

class HomeViewController: UIViewController {

	@IBOutlet weak var questionLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func pressToGoAnswerQuestionView(_ sender: Any) {
		
		let storyboard = UIStoryboard(name: "AnswerQuestion", bundle : nil)
												 
		guard let answerQuestionVC = storyboard.instantiateViewController(withIdentifier: "AnswerQuestionViewController") as? AnswerQuestionViewController else {return}
		answerQuestionVC.modalPresentationStyle = .fullScreen
		self.present(answerQuestionVC, animated: true, completion: nil)
	}
	

}
