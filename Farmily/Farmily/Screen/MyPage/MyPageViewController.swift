//
//  MyPageViewController.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import UIKit

import SnapKit
import Then
import RxSwift

final class ImageCollectionCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionCell"
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(image: String) {
        imageView.image(url: image)
    }
    
    private func setLayout() {
        
        addSubviews([imageView])
        
        imageView.snp.makeConstraints {
            $0.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}

final class MyPageViewController: UIViewController {
    
    var photos: [FamilyPhoto]?
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getPhoto()
    }
    
}

extension MyPageViewController {
    
    private func getPhoto() {
        NetworkService.shared.photo.getPhoto()
            .compactMap { $0.data }
            .bind { data in
                self.photos = data
                self.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
    }
}

extension MyPageViewController {
    
    private func setCollectionView() {
        registerCell()
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        collectionView.dataSource = self
    }
    
    private func registerCell() {
        collectionView.register(ImageCollectionCell.self,
                                forCellWithReuseIdentifier: ImageCollectionCell.identifier)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.identifier, for: indexPath) as? ImageCollectionCell else { return UICollectionViewCell() }
        if let photos = photos {
            cell.setData(image: photos[indexPath.item].url)
        }
        return cell
    }
    
}
