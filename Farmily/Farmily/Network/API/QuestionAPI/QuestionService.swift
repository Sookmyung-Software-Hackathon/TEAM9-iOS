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
    func getWeekQuestion(week: Int) -> Observable<BaseResponseType<QuestionWithPhoto>>
    
    /// 가족 질문 추가
    func postFamilyQuestionAdd(question: FamilyQuestionAddRequest) -> Observable<BaseResponseType<Question>>
    
    /// 해당 주에 사진 추가
    func postPhoto(familyPhoto: PostFamilyPhotoRequest) -> Observable<BaseResponseType<FamilyPhoto>>
    
    /// 오늘 질문 조회
    func getTodayQuestion() -> Observable<BaseResponseType<TodayQuestion>>
    
    /// 오늘 질문에 답변
    func postAnswerTodayQuestion(todayAnswer: PostTodayAnswer) -> Observable<BaseResponseType<TodayQuestionAnswer>>
    
    /// 해당 주차 요일 답변 조회
    func getDayAnswer(week: Int, day: Int) -> Observable<BaseArrayResponseType<Question>>
}

final class DefaultQuestionService: QuestionService {
   
    
    private let provider = MoyaProvider<QuestionRouter>(plugins: [MoyaLoggingPlugin()])
    
    func getQuestionLastWeekMaxInt() -> Observable<BaseResponseType<QuestionMax>> {
        return provider.rx.request(.getQuestionLastWeek)
            .asObservable()
            .map(BaseResponseType<QuestionMax>.self)
            .catchError()
    }
    
    func getWeekQuestion(week: Int) -> Observable<BaseResponseType<QuestionWithPhoto>> {
        return provider.rx.request(.getWeekQuestion(week: week))
            .asObservable()
            .map(BaseResponseType<QuestionWithPhoto>.self)
            .catchError()
    }
    
    func postFamilyQuestionAdd(question: FamilyQuestionAddRequest) -> Observable<BaseResponseType<Question>> {
        return provider.rx.request(.postFamilyQuestionAdd(question: question))
            .asObservable()
            .map(BaseResponseType<Question>.self)
            .catchError()
    }
    
    func postPhoto(familyPhoto: PostFamilyPhotoRequest) -> Observable<BaseResponseType<FamilyPhoto>> {
        return provider.rx.request(.postPhoto(familyPhoto: familyPhoto))
            .asObservable()
            .map(BaseResponseType<FamilyPhoto>.self)
            .catchError()
    }
    
    func getTodayQuestion() -> Observable<BaseResponseType<TodayQuestion>> {
        return provider.rx.request(.getTodayQuestion)
            .asObservable()
            .map(BaseResponseType<TodayQuestion>.self)
            .catchError()
    }
    
    func postAnswerTodayQuestion(todayAnswer: PostTodayAnswer) -> Observable<BaseResponseType<TodayQuestionAnswer>> {
        return provider.rx.request(.postAnswerTodayQuestion(answer: todayAnswer))
            .asObservable()
            .map(BaseResponseType<TodayQuestionAnswer>.self)
            .catchError()
    }
    
    func getDayAnswer(week: Int, day: Int) -> Observable<BaseArrayResponseType<Question>> {
        return provider.rx.request(.getDayAnswer(week: week, day: day))
            .asObservable()
            .map(BaseArrayResponseType<Question>.self)
            .catchError()
    }
    
   
}


