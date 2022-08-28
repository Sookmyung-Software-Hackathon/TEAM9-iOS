//
//  FamilyService.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Moya
import RxSwift

protocol FamilyService {
    func postFamily() -> Observable<BaseResponseType<Family>>
    func postFamilyJoin(joinRequest: FamilyJoinRequest) -> Observable<BaseResponseType<FamilyJoin>>
}

final class DefaultFamilyService: FamilyService {
    
    private let provider = MoyaProvider<FarmilyRouter>(plugins: [MoyaLoggingPlugin()])
    
    func postFamily() -> Observable<BaseResponseType<Family>> {
        return provider.rx.request(.postFamily)
            .asObservable()
            .map(BaseResponseType<Family>.self)
            .catchError()
    }
    
    func postFamilyJoin(joinRequest: FamilyJoinRequest) -> Observable<BaseResponseType<FamilyJoin>> {
        return provider.rx.request(.postFamilyJoin(joinRequest: joinRequest))
            .asObservable()
            .map(BaseResponseType<FamilyJoin>.self)
            .catchError()
    }
}


