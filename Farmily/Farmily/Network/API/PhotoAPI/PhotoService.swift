//
//  PhotoService.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Moya
import RxSwift

protocol PhotoService {
    
    func getPhoto() -> Observable<BaseArrayResponseType<FamilyPhoto>>
}

final class DefaultPhotoService: PhotoService {

    private let provider = MoyaProvider<PhotoRouter>(plugins: [MoyaLoggingPlugin()])
    
    func getPhoto() -> Observable<BaseArrayResponseType<FamilyPhoto>> {
        return provider.rx.request(.getPhoto)
            .asObservable()
            .map(BaseArrayResponseType<FamilyPhoto>.self)
            .catchError()
    }
    
    
}

