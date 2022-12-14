//
//  BaseArrayResponseType.swift
//  Farmily
//
//  Created by κΉνμ on 2022/08/27.
//

import Foundation

struct BaseArrayResponseType<T: Decodable>: Decodable, StatusHandler {
    let status: Int
    let message: String?
    let success: Bool?
    let data: [T]?

    var statusCase: StatusCase? {
        return StatusCase(rawValue: status)
    }
}
