//
//  InitialViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

final class InitialViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var newFarmilyButton: UIButton!
    @IBOutlet weak var joinFarmilyButton: UIButton!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: - Function (UI)
    
    private func setUI() {
        [newFarmilyButton, joinFarmilyButton].forEach({ button in
            button?.cornerRadius = 25
        })
    }
    
    // MARK: - IBAction
    
    @IBAction func newFarmilyButtonDidTap(_ sender: Any) {
        
        self.makeOKAlert(title: "가족 코드가 복사되었습니다.",
                         message: "코드: D3LEk9", okAction: { _ in
            print("화면전환")
        }, completion: nil)
    }
    
    @IBAction func joinFarmilyButtonDidTap(_ sender: Any) {
        makeTextFieldRequestAlert {
            print("화면전환")
        }
    }
}

extension InitialViewController {
    
    /// 취소와 확인이 뜨는 UIAlertController
    func makeTextFieldRequestAlert(completion : (() -> Void)? = nil)
    {
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: nil, message: "가족 코드를 입력해주세요",
                                                    preferredStyle: .alert)
        
        alertViewController.addTextField { (textField) in
            textField.placeholder = "코드입력"
        }
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            /// 통신
            print(alertViewController.textFields?[0].text ?? "nil")
        })
        alertViewController.addAction(okAction)
        
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertViewController.addAction(cancelAction)
        
        
        self.present(alertViewController, animated: true, completion: completion)
    }
}
