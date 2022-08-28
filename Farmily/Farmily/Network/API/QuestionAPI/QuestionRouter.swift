//
//  QuestionRouter.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import Moya


enum QuestionRouter {
    case getTodayQuestion
    case postAnswerTodayQuestion
    
    /// 가족 질문 추가
    case postFamilyQuestionAdd
    
    /// 마지막 주차 조회
    case getQuestionLastWeek
    
    /// 해당 주에 사진 추가
    case postPhoto
    
    /// 해당 주 질문 조회
    case getWeekQuestion
    
    /// 해당 주차 요일 답변 조회
    case getDayAnswer
}

extension QuestionRouter: BaseTargetType {
    var path: String {
        switch self {
        case .getQuestionLastWeek:
            return URLConstant.questionList
        default:
            return ""
        }
    }
    
    var method: Method {
        switch self {
        case .getQuestionLastWeek:
            return .get
        default:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getQuestionLastWeek:
            return .requestPlain
        default:
            return .requestPlain
        }
    }
    
  
}
