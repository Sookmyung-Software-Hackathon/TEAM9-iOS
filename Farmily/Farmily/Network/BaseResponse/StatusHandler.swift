//
//  StatusHandler.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import Foundation

protocol StatusHandler {
    var status: Int { get }
    var message: String? { get }
    var statusCase: StatusCase? { get }
}
