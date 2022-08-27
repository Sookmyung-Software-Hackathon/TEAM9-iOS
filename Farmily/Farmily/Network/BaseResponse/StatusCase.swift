//
//  StatusCase.swift
//  Farmily
//
//  Created by 김혜수 on 2022/08/27.
//

import Foundation

/*
OK: 200, 목록, 상세, 수정 성공
CREATED: 201, POST나 PUT으로 데이터 등록할 경우 사용, 어떠한 생성 작업을 요청받아 생성 작업을 성공
ACCEPTED: 202, 요청은 받았지만, 아직 동작을 수행하지 않은 상태로 요청이 적절함을 의미한다.
NO_CONTENT: 204, 요청이 성공은 했지만 응답할 콘텐츠가 없을 경우를 뜻한다.
BAD_REQUEST: 400, 클라이언트가 올바르지 못한 요청을 보내고 있음을 의미
UNAUTHORIZED: 401, 로그인을 하지 않아 권한이 없음. 권한 인증 요구
FORBIDDEN: 403, 요청이 서버에 의해 거부 되었음을 의미. 금지된 페이지
NOT_FOUND: 404, 요청한 URL을 찾을 수 없음을 의미
CONFLICT: 409, 클라이언트 요청에 대해 서버에서 충돌 요소가 발생 할수 있음을 의미
UNPROCESSABLE: 422, 서버가 요청을 이해하고 요청 문법도 올바르지만 요청된 지시를 따를 수 없음
INTERNAL_SERVER_ERROR: 500, 서버에 오류가 발생하여 응답 할 수 없음을 의미
SERVICE_UNAVAILABLE: 503, 현재 서버가 유지보수 등의 이유로 일시적인 사용 불가함을 의미
DB_ERROR: 600, DB 내부 오류
*/

enum StatusCase: Int {
    case okay = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    case badRequest = 400
    case unAuthorized = 401
    case forbidden = 403
    case notFound = 404
    case conflict = 409
    case internalServerError = 500
    case serviceUnavailable = 503
    case dbError = 600
}
