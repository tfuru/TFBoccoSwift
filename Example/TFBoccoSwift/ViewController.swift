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
                print(" accessToken:\(accessToken)")
                print(" error:\(error)")
                
                //ルーム一覧を取得
                Bocco.sharedInstance.getRooms({(rooms:[Room]?,error: NSError?)->Void in
                    print("callback")
                    print(" rooms:\(rooms)")
                    print(" error:\(error)")
                })
                
                //メッセージをルームに送信
                Bocco.sharedInstance.postTextMessage("f5020da2-f2ec-4d11-a1f9-7a21463a88ba",
                    text: "はじめてのメッセージ",
                    callback:{(message:Message?,error: NSError?)->Void in
                        print("callback")
                        print(" message:\(message)")
                        print(" error:\(error)")
                })
                
                //メッセージ一覧を取得
                Bocco.sharedInstance.getMessages("f5020da2-f2ec-4d11-a1f9-7a21463a88ba",
                    callback:{(messages:[Message]?,error: NSError?)->Void in
                        print("callback")
                        print(" messages:\(messages)")
                        print(" error:\(error)")
                })
                
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

