//
//  InitialViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

class InitialViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

//    @IBAction func showAlertButtonDIdTap(_ sender: Any) {
//        makeTextFieldOKAlert()
//    }
}

extension InitialViewController {
    
    func makeTextFieldOKAlert(completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title ?? nil,
                                                    message: "message",
                                                    preferredStyle: .alert)
        alertViewController.addTextField { (textField) in
            textField.placeholder = "코드입력"
        }
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            /// 통신
            print(alertViewController.textFields?[0].text ?? "nil")
        })
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
