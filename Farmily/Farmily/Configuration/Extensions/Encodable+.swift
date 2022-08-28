//
//  Encodable+.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/28.
//

import Foundation

extension Encodable {
    
    var toDictionary : [String: Any] {
        guard let object = try? JSONEncoder().encode(self) else { fatalError() }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else { fatalError() }
        return dictionary
    }
}
