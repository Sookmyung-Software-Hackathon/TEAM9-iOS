//
//  Observable+catchError.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import RxSwift

extension Observable {
    func catchError() -> Observable<Element> {
           return self.do(onNext: { item in
               guard
                   let element = item as? StatusHandler,
                   let status = element.statusCase
               else {
                   return
               }

           })
           .catch { error in
               #if DEBUG
               print("⛔️⛔️⛔️", Date(), error, "⛔️⛔️⛔️")
               #endif
               return .empty()
           }
       }
}
