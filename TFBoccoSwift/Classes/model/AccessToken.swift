//
//  AccessToken.swift
//  TFBoccoSwift
//
//  Created by 古川信行 on 2016/10/06.
//  Copyright © 2016年 tf-web. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

public struct AccessToken {
    public let accessToken: String
    public let uuid: String
}

extension AccessToken:Decodable {
    public static func decode(j: JSON) -> Decoded<AccessToken.DecodedType> {
        return curry(self.init)
            <^> j <| "access_token"
            <*> j <| "uuid"
    }
}

