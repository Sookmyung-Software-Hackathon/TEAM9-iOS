//
//  QuestionService.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Moya
import RxSwift

protocol QuestionService {
    func getQuestionLastWeekMaxInt() -> Observable<BaseResponseType<QuestionMax>>
}

final class DefaultQuestionService: QuestionService {
    
    
    private let provider = MoyaProvider<QuestionRouter>(plugins: [MoyaLoggingPlugin()])
    
    func getQuestionLastWeekMaxInt() -> Observable<BaseResponseType<QuestionMax>> {
        return provider.rx.request(.getQuestionLastWeek)
            .asObservable()
            .map(BaseResponseType<QuestionMax>.self)
            .catchError()
    }
}


