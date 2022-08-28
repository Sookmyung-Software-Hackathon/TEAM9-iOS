//
//  FamilyService.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Moya
import RxSwift

protocol FamilyService {
    func postFamily() -> Observable<BaseResponseType<VoidType>>
    func postFamilyJoin(joinRequest: FamilyJoinRequest) -> Observable<BaseResponseType<VoidType>>
}

final class DefaultFamilyService: FamilyService {
    
    private let provider = MoyaProvider<FarmilyRouter>(plugins: [MoyaLoggingPlugin()])
    
    func postFamily() -> Observable<BaseResponseType<VoidType>> {
        return provider.rx.request(.postFamily)
            .asObservable()
            .map(BaseResponseType<VoidType>.self)
            .catchError()
    }
    
    func postFamilyJoin(joinRequest: FamilyJoinRequest) -> Observable<BaseResponseType<VoidType>> {
        return provider.rx.request(.postFamilyJoin(joinRequest: joinRequest))
            .asObservable()
            .map(BaseResponseType<VoidType>.self)
            .catchError()
    }
}


