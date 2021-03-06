//
//  Sensor.swift
//  TFBoccoSwift
//
//  Created by 古川信行 on 2016/10/07.
//  Copyright © 2016年 tf-web. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

public struct Sensor {
    public let uuid:String
    public let userType:String
    public let nickname:String
    public let icon:String
    public let seller:String
    public let address:String
}

extension Sensor: Decodable {
    public static func decode(j: JSON) -> Decoded<Sensor.DecodedType> {
        return curry(self.init)
            <^> j <| "uuid"
            <*> j <| "user_type"
            <*> j <| "nickname"
            <*> j <| "icon"
            <*> j <| "seller"
            <*> j <| "address"
    }
}
