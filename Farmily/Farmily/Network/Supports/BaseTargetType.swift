//
//  BaseTargetType.swift
//  Farmily
//
//  Created by κΉνμ on 2022/08/27.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType { }

extension BaseTargetType {

    var baseURL: URL {
        return URL(string: URLConstant.baseURL)!
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json",
                "Authorization": UserDefaults.standard.value(forKey: Const.UserDefaultsKey.accessToken) as? String ?? "" ]
    }

    var sampleData: Data {
        return Data()
    }
}
