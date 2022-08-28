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
    
    /// 해당 주 질문 주회
    func getWeekQuestion(week: Int) -> Observable<BaseArrayResponseType<Question>>
    
    ///
}

final class DefaultQuestionService: QuestionService {
    
    private let provider = MoyaProvider<QuestionRouter>(plugins: [MoyaLoggingPlugin()])
    
    func getQuestionLastWeekMaxInt() -> Observable<BaseResponseType<QuestionMax>> {
        return provider.rx.request(.getQuestionLastWeek)
            .asObservable()
            .map(BaseResponseType<QuestionMax>.self)
            .catchError()
    }
    
    func getWeekQuestion(week: Int) -> Observable<BaseArrayResponseType<Question>> {
        return provider.rx.request(.getWeekQuestion(week: week))
            .asObservable()
            .map(BaseArrayResponseType<Question>.self)
            .catchError()
    }
    
}


