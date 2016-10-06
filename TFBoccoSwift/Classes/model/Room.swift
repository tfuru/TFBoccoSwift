//
//  Room.swift
//  TFBoccoSwift
//
//  Created by 古川信行 on 2016/10/07.
//  Copyright © 2016年 tf-web. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

public struct Room {
    public let uuid: String
    public let name: String
    public let updatedAt: String
    public let backgroundImage: String
    public let members:[Member]
    public let messages:[Message]
    public let sensors:[Sensor]
}

extension Room: Decodable{
    public static func decode(j: JSON) -> Decoded<Room.DecodedType> {
        return curry(self.init)
            <^> j <| "uuid"
            <*> j <| "name"
            <*> j <| "updated_at"
            <*> j <| "background_image"
            <*> j <|| "members"
            <*> j <|| "messages"
            <*> j <|| "sensors"
    }
}
