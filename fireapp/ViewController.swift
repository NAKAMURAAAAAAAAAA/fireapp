//
//  ViewController.swift
//  fireapp
//
//  Created by Kan Nakamura on 2019/11/16.
//  Copyright © 2019 Kan Nakamura. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var messageInputView: UITextField!
    
    //Databaseのインスタンス作成
    var databaseRef: DatabaseReference!

       override func viewDidLoad() {
           super.viewDidLoad()
        //Databaseのインスタンス作成
        databaseRef = Database.database().reference()
        
        //databaseRef.observe(.childAdded, with: { snapshot in〜~}でイベントを表示させる
        databaseRef.observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
                //currentTextを定義
                let currentText = self.textView.text
                //textViewにcurrentTextを表示
                self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
            }
        })

       }
    @IBAction func tappedSendButton(_ sender: Any) {
    //ボタンを押した時に、UITextField２つに入力されている値を送信します。
       view.endEditing(true)
        
        //nameInputViewとmessageInputViewに値がある場合のif文
       if let name = nameInputView.text, let message = messageInputView.text {
        //messageDataを定義
           let messageData = ["name": name, "message": message]
        //databaseに保存
           databaseRef.childByAutoId().setValue(messageData)
        //text欄を空欄にする
           messageInputView.text = ""
       }
    }


}

