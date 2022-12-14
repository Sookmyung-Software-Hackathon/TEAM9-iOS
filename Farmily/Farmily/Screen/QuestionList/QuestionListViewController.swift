//
//  QuestionListViewController.swift
//  Farmily
//
//  Created by κΉνμ on 2022/08/27.
//

import UIKit

import SnapKit
import Then
import RxSwift

public class ScaleAspectFitImageView : UIImageView {
    
    public override var intrinsicContentSize: CGSize {
          if let myImage = self.image {
              let myImageWidth = myImage.size.width
              let myImageHeight = myImage.size.height
              let myViewWidth = self.frame.size.width

              let ratio = myViewWidth/myImageWidth
              let scaledHeight = myImageHeight * ratio

              return CGSize(width: myViewWidth, height: scaledHeight)
          }
          return CGSize(width: -1.0, height: -1.0)
      }
}

final class QuestionTopCollectionViewCell: UICollectionViewCell {
    
    private let addPhotoImageView = UIImageView().then {
        $0.image = Const.Image.btnAddPhoto
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    private let photoImageView = ScaleAspectFitImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(hasImage: Bool, image: UIImage? = nil, imageURL: String? = nil) {
        print("hasImage", hasImage)
        if hasImage {
            addPhotoImageView.isHidden = true
            photoImageView.isHidden = false
            if let image = image {
                photoImageView.image = image
            }
            
            else if let imageURL = imageURL {
                photoImageView.image(url: imageURL)
                
                photoImageView.sizeToFit()
            }
        } else {
            photoImageView.isHidden = true
            addPhotoImageView.isHidden = false
        }
    }
    
    private func setLayout() {
        addSubviews([addPhotoImageView, photoImageView])
        
        addPhotoImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(92)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(200).priority(.low)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}

final class QuestionListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var weekIdx: Int?
    var photoWithQuestion: QuestionWithPhoto?
    var photo: UIImage?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setCollectionView()
        
        if let weekIdx = weekIdx {
            navigationTitleLabel.text = "\(weekIdx)μ£Όμ°¨ μΈνλ¦¬"
            getWeekQuestion(week: weekIdx)
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Network

extension QuestionListViewController {
    
    private func getWeekQuestion(week: Int) {
        NetworkService.shared.question.getWeekQuestion(week: week)
            .compactMap { $0.data }
            .bind { data in
                self.photoWithQuestion = data
                self.setCollectionView()
       
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - Extension (νλ©΄μ ν)

extension QuestionListViewController {
    
    private func goToQuestionDetailViewController(day: Int, questionText: String) {
        guard let detailViewController = UIStoryboard(name: Const.Storyboard.QuestionDetail, bundle: nil)
            .instantiateViewController(withIdentifier: Const.ViewController.QuestionDetailViewController) as? QuestionDetailViewController else { return }
        
        if let weekIdx = weekIdx {
            detailViewController.week = weekIdx
            detailViewController.day = day
        }
        detailViewController.questionText = questionText
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - Extension (CollectionView)

extension QuestionListViewController {
    
    private func setCollectionView() {
        registerXib()
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    private func registerXib() {
        collectionView.register(UINib(nibName: Const.Identifier.WeekQuestionCollectionViewCell, bundle: nil),
                                forCellWithReuseIdentifier: Const.Identifier.WeekQuestionCollectionViewCell)
        collectionView.register(QuestionHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: Const.Identifier.QuestionHeaderCollectionReusableView)
        collectionView.register(QuestionTopCollectionViewCell.self, forCellWithReuseIdentifier: "QuestionTopCollectionViewCell")
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] idx, env in
            switch idx {
            case 0:
                return self?.createTopSectionLayout()
            case 1:
                return self?.createQuestionSectionLayout()
            default:
                fatalError()
            }
        }
        return layout
    }
    
    private func createTopSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(130))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createQuestionSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //      group.interItemSpacing = .flexible(8)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
        
    }
}

extension QuestionListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:

                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                self.present(imagePicker, animated: true)
        case 1:
            goToQuestionDetailViewController(day: indexPath.item,
                                             questionText: photoWithQuestion?.question[indexPath.item].question ?? "")
        default:
            print("zz")
        }
        
    }
}

extension QuestionListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return photoWithQuestion?.question.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionTopCollectionViewCell", for: indexPath) as? QuestionTopCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(
                hasImage: ((photo != nil) || (photoWithQuestion?.photo != nil)),
                image: photo,
                imageURL: photoWithQuestion?.photo
            )
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.WeekQuestionCollectionViewCell, for: indexPath) as? WeekQuestionCollectionViewCell
            else { return UICollectionViewCell() }
            if let photoWithQuestion = photoWithQuestion {
                cell.setData(question: photoWithQuestion.question[indexPath.row])
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 1:
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Identifier.QuestionHeaderCollectionReusableView, for: indexPath) as? QuestionHeaderCollectionReusableView else { return UICollectionReusableView() }
            if let weekIdx = weekIdx {
                view.setData(week: weekIdx)
            }
            
            return view
        default:
            return UICollectionReusableView()
        }
        
    }
}

extension QuestionListViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photo = image
            if let weekIdx = weekIdx {
                NetworkService.shared.question.postPhoto(
                    familyPhoto: PostFamilyPhotoRequest(file: image, week: weekIdx))
                .compactMap { $0.data }
                .bind { _ in
                    self.collectionView.reloadData()
                    self.dismiss(animated: true, completion: nil)
                }
                .disposed(by: disposeBag)
            }
        }
    }
    
    
}
