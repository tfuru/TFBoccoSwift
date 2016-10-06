//
//  ViewController.swift
//  TFBoccoSwift
//
//  Created by tfuru on 10/07/2016.
//  Copyright (c) 2016 tfuru. All rights reserved.
//

import UIKit
import TFBoccoSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //アクセストークンを取得
        Bocco.sharedInstance.setApiKey(Config.BOCCO_API_KEY)
            .setEmail(Config.BOCCO_ACCOUNT_EMAIL)
            .setPassword(Config.BOCCO_ACCOUNT_PASSWORD)
            .createAccessToken({(accessToken: AccessToken?,error: NSError?)->Void in
                print("callback")
                print(" error:\(error)")
                if error != nil{
                    print(" error:\(error)")
                    return
                }
                print(" accessToken:\(accessToken)")
                
                //ルーム一覧を取得
                Bocco.sharedInstance.getRooms({(rooms:[Room]?,error: NSError?)->Void in
                    print("callback")
                    if error != nil{
                        print(" error:\(error)")
                        return
                    }
                    
                    print(" rooms:\(rooms)")
                    if let room:Room = rooms![0] {
                        //メッセージをルームに送信
                        print(" room.uuid:\(room.uuid)")
                        
                        Bocco.sharedInstance.postTextMessage(room.uuid ,
                            text: "はじめてのメッセージ",
                            callback:{(message:Message?,error: NSError?)->Void in
                                print("callback")
                                if error != nil{
                                    print(" error:\(error)")
                                    return
                                }
                                print(" message:\(message)")
                        })
                        
                        self.delay({ () -> Void in
                            //メッセージ一覧を取得
                            Bocco.sharedInstance.getMessages(room.uuid,
                                callback:{(messages:[Message]?,error: NSError?)->Void in
                                    print("callback")
                                    if error != nil{
                                        print(" error:\(error)")
                                        return
                                    }
                                    print(" messages:\(messages)")
                            })
                        },delay: 10)
                    }
                })
                
                
            })
    }

    func delay(block: () -> Void,delay: Double = 0){
        let delay = delay * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue(), {
            block()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

