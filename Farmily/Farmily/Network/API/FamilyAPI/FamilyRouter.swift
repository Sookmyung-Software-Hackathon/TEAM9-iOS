//
//  FamilyRouter.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import Moya

struct FamilyJoinRequest: Encodable {
    let device: String
    let code: String
}

enum FarmilyRouter {
    case postFamily
    case postFamilyJoin(joinRequest: FamilyJoinRequest)
}

extension FarmilyRouter: BaseTargetType {
    var path: String {
        switch self {
        case .postFamily:
            return URLConstant.family
        case .postFamilyJoin:
            return URLConstant.familyJoin
        }
    }
    
    var method: Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .postFamily:
            return .requestPlain
        case let .postFamilyJoin(request):
            return .requestParameters(
                parameters: request.toDictionary,
                encoding: JSONEncoding.default)
        }
    }
}
