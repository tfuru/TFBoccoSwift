//
//  Message.swift
//  TFBoccoSwift
//
//  Created by 古川信行 on 2016/10/07.
//  Copyright © 2016年 tf-web. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

public struct Message {
    let id: Int
    let uniqueId:String
    let date:String
    let media:String
    let messageType:String
    let user:User
}

extension Message: Decodable{
    public static func decode(j: JSON) -> Decoded<Message.DecodedType> {
        return curry(self.init)
            <^> j <| "id"
            <*> j <| "unique_id"
            <*> j <| "date"
            <*> j <| "media"
            <*> j <| "message_type"
            <*> j <| "user"
    }
}
