//
//  PhotoRouter.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Moya

enum PhotoRouter {
    case getPhoto
}

extension PhotoRouter: BaseTargetType {
    var path: String {
        return URLConstant.photo
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    
}
