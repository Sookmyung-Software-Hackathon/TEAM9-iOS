//
//  QuestionListViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import SnapKit
import Then

final class QuestionTopCollectionViewCell: UICollectionViewCell {
    
    private let addPhotoImageView = UIImageView().then {
        $0.image = Const.Image.btnAddPhoto
        $0.contentMode = .scaleAspectFit
    }
    
    private let photoImageView = UIImageView().then {
        $0.image = UIImage()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubviews([addPhotoImageView, photoImageView])
        
        addPhotoImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
        
        photoImageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.height.lessThanOrEqualTo(200).priority(.medium)
            $0.leading.trailing.equalToSuperview().inset(8)
        }
    }
}

final class QuestionListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension (화면전환)

extension QuestionListViewController {
    
    private func goToQuestionDetailViewController() {
        guard let detailViewController = UIStoryboard(name: Const.Storyboard.QuestionDetail, bundle: nil)
            .instantiateViewController(withIdentifier: Const.ViewController.QuestionDetailViewController) as? QuestionDetailViewController else { return }
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
        goToQuestionDetailViewController()
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
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionTopCollectionViewCell", for: indexPath)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.WeekQuestionCollectionViewCell, for: indexPath) as? WeekQuestionCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 1:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Const.Identifier.QuestionHeaderCollectionReusableView, for: indexPath)
            return view
        default:
            return UICollectionReusableView()
        }
        
    }
}
