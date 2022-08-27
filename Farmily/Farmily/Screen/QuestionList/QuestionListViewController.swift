//
//  QuestionListViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

final class QuestionListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
    }
}

// MARK: - Extension (CollectionView)

extension QuestionListViewController {
    
    private func setCollectionView() {
        registerXib()
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        collectionView.dataSource = self
    }
    
    private func registerXib() {
        collectionView.register(UINib(nibName: Const.Identifier.WeekQuestionCollectionViewCell, bundle: nil),
                                forCellWithReuseIdentifier: Const.Identifier.WeekQuestionCollectionViewCell)
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
            heightDimension: .fractionalHeight(1.0))
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
    //    section.interGroupSpacing = 8
        return section
        
    }
}

extension QuestionListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.Identifier.WeekQuestionCollectionViewCell, for: indexPath) as? WeekQuestionCollectionViewCell
            else { return UICollectionViewCell() }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}
