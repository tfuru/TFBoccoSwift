//
//  Member.swift
//  TFBoccoSwift
//
//  Created by 古川信行 on 2016/10/07.
//  Copyright © 2016年 tf-web. All rights reserved.
//

import Foundation
import Argo
import Curry
import Runes

public struct Member {
    let user:User
    let joinedAt:String
    let readId:Int
}

extension Member: Decodable{
    public static func decode(j: JSON) -> Decoded<Member.DecodedType> {
        return curry(self.init)
            <^> j <| "user"
            <*> j <| "joined_at"
            <*> j <| "read_id"
    }
}
