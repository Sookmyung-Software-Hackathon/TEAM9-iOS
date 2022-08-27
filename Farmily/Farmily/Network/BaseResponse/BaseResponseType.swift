//
//  BaseResponseType.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import Foundation

struct BaseResponseType<T: Decodable>: Decodable, StatusHandler {
    let status: Int
    let message: String?
    let success: Bool?
    let data: T?

    var statusCase: StatusCase? {
        return StatusCase(rawValue: status)
    }
}
