//
//  ResponseHeader.swift
//  RxBus
//
//  Created by HellSage on 2020/01/18.
//  Copyright © 2020 HellSage. All rights reserved.
//

import Foundation

struct ComResponseHeader: Codable {}

struct ResponseHeader: Codable {
    var headerCd: Int
    var headerMsg: String
    var itemCount: Int
}
