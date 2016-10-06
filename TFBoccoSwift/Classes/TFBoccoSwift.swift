//
//  TFBoccoSwift.swift
//  TFBoccoSwift
//
//  Created by 古川信行 on 2016/10/06.
//  Copyright © 2016年 tf-web. All rights reserved.
//

import Foundation
import Argo
import AFNetworking

public class Bocco {
    private let API_BASE:String = "https://api.bocco.me/alpha"
    //アクセストークン取得
    private let API_SESSION:String = "/sessions"

    //チャットルーム一覧 取得
    private let API_ROOMS_JOINED = "/rooms/joined"
    
    //チャットルームへ メッセージ送信等
    private let API_ROOMS_MESSAGES = "/rooms/room_id/messages"
    
    //API申し込み時に送られてきたAPIキー
    private var apiKey:String?
    
    //BOCCOアプリで登録したメールアドレス
    private var email:String?
    
    //BOCCOアプリで登録したパスワード
    private var password:String?
    
    // アクセストークン
    private var accessToken:AccessToken?
    
    //シングルトンインスタンス
    public class var sharedInstance:Bocco {
        struct Static {
            static let instance:Bocco = Bocco()
        }
        return Static.instance
    }
    
    //コンストラクタ
    init() {
    
    }
    
    //APIキー
    public func setApiKey(apiKey:String)->Self {
        self.apiKey = apiKey
        return self
    }
    
    //メールアドレス
    public func setEmail(email:String)->Self {
        self.email = email
        return self
    }
    
    //パスワード
    public func setPassword(password:String)->Self {
        self.password = password
        return self
    }
    
    //アクセストークンを設定
    public func setAccessToken(accessToken:AccessToken)->Self {
        self.accessToken = accessToken
        return self
    }
    
    /** アクセストークンを取得する
     * callback
     */
    public func createAccessToken(callback:(accessToken: AccessToken?,error: NSError?)->Void)->Self?{
        
        if apiKey == nil {
            callback(accessToken: nil,error: NSError(domain: "apikey is nil", code: -1, userInfo: nil))
            return nil
        }
        if email == nil {
            callback(accessToken: nil,error: NSError(domain: "email is nil", code: -1, userInfo: nil))
            return nil
        }
        if password == nil {
            callback(accessToken: nil,error: NSError(domain: "password is nil", code: -1, userInfo: nil))
            return nil
        }
        
        if accessToken != nil {
            //アクセストークンが設定済みだった
            callback(accessToken: nil,error: NSError(domain: "accessToken is not nil", code: -1, userInfo: nil))
            return nil
        }
        
        let parameters = ["apikey": apiKey!,"email":email!,"password":password!]
        let url:String = "\(API_BASE)\(API_SESSION)"
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.POST(url, parameters: parameters,
            success: { (task, responseObject) -> Void in
                if let j:JSON = JSON(responseObject!) {
                    self.accessToken = AccessToken.decode(j).value
                    callback(accessToken: self.accessToken,error: nil)
                }
            },
            failure: { (task, error) -> Void in
                print("failed: \(error)")
                callback(accessToken: nil,error: error)
            })
        return self
    }
    
    //ルーム一覧を取得
    public func getRooms(callback:(rooms:[Room]?,error: NSError?)->Void)->Self?{
        if accessToken == nil {
            //アクセストークンが未設定だった
            callback(rooms: nil,error: NSError(domain: "accessToken is nil", code: -1, userInfo: nil))
            return nil
        }
        
        let parameters = ["access_token": accessToken!.accessToken]
        let url:String = "\(API_BASE)\(API_ROOMS_JOINED)"
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.GET(url, parameters: parameters,
            success: { (task, responseObject) -> Void in
                var rooms:[Room] = []
                for room in responseObject as! NSArray{
                    let r:Decoded<Room> = Room.decode( JSON(room) )
                    if let v = r.value {
                        rooms += [v]
                    }
                }
                callback(rooms:rooms,error: nil)
            },
            failure: { (task, error) -> Void in
                        print("failed: \(error)")
                        callback(rooms: nil,error: error)
            })
        
        return self
    }
    
    //メッセージ送信
    public func postTextMessage(roomId:String,text:String,callback:(message:Message?,error: NSError?)->Void) -> Self? {
        if accessToken == nil {
            //アクセストークンが未設定だった
            callback(message: nil,error: NSError(domain: "accessToken is nil", code: -1, userInfo: nil))
            return nil
        }
        
        let uniqueId = NSUUID().UUIDString
        let media = "text"
        
        let parameters = ["access_token": accessToken!.accessToken,"unique_id":uniqueId,"media":media,"text":text]
        let url:String = "\(API_BASE)\(API_ROOMS_MESSAGES)".stringByReplacingOccurrencesOfString("room_id", withString: roomId)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer.setValue("js", forHTTPHeaderField: "Accept-Language")
        manager.POST(url, parameters: parameters,
                    success: { (task, responseObject) -> Void in
                        let message:Decoded<Message> = Message.decode( JSON(responseObject!) )
                        callback(message:message.value,error: nil)
                    },
                    failure: { (task, error) -> Void in
                        print("failed: \(error)")
                        callback(message: nil,error: error)
                    })
        
        return self
    }
    
    //指定ルームのメッセージ一覧を取得
    public func getMessages(roomId:String,callback:(messages:[Message]?,error: NSError?)->Void) -> Self? {
        if accessToken == nil {
            //アクセストークンが未設定だった
            callback(messages: nil,error: NSError(domain: "accessToken is nil", code: -1, userInfo: nil))
            return nil
        }
        
        let parameters = ["access_token": accessToken!.accessToken]
        let url:String = "\(API_BASE)\(API_ROOMS_MESSAGES)".stringByReplacingOccurrencesOfString("room_id", withString: roomId)
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.GET(url, parameters: parameters,
                     success: { (task, responseObject) -> Void in
                        var messages:[Message] = []
                        for message in responseObject as! NSArray{
                            let r:Decoded<Message> = Message.decode( JSON(message) )
                            if let v = r.value {
                                messages += [v]
                            }
                        }
                        
                        callback(messages:messages,error: nil)
                    },
                    failure: { (task, error) -> Void in
                        print("failed: \(error)")
                        callback(messages: nil,error: error)
        })
        
        return self
    }
}
