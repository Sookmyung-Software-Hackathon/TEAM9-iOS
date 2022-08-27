//
//  UIImageView.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import Kingfisher

extension UIImageView {

    /// Kingfisher 이미지 처리
    /// - Parameters:
    ///   - url: 이미지 URL
    ///   - defaultImage: 디폴트 이미지!!
    func image(url: String?, defaultImage: UIImage? = UIImage()) {
        kf.indicatorType = .activity
        guard let url = URL(string: url ?? "") else {
            image = defaultImage
            return
        }
        kf.setImage(
            with: url,
            placeholder: .none,
            options: [
                .transition(ImageTransition.fade(0.5)),
                .backgroundDecode,
                .alsoPrefetchToMemory,
                .cacheMemoryOnly
            ]
        )
    }

    func cancelDownloadTask() {
        kf.cancelDownloadTask()
    }
}
