//
//  MakeRoomViewController.swift
//  BBSApp
//
//  Created by 早坂甫 on 2019/03/06.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit

class MakeRoomViewController: UIViewController, UITextFieldDelegate {

    let roomNameInputField = UITextField()
    var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        // MARK: ナビゲーションバーの表示変更
        // タイトル名をセット
        title = "ルーム作成"
        // ナビゲーションバーの色を変更
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainColor_EG")
        // 完了ボタンを設置（バー右上のボタン）
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(CompletefButtonTapped))
        
        // MARK:ルーム名入力欄の作成
        // 完了ボタンの作成
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(commitButtonTapped(sender:)))
        kbToolBar.items = [spacer, commitButton]

        roomNameInputField.delegate = self
        roomNameInputField.borderStyle = UITextField.BorderStyle.roundedRect
        roomNameInputField.keyboardType = UIKeyboardType.default
        roomNameInputField.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.25,
                                        width: view.frame.width * 0.7, height: 40)
        roomNameInputField.textAlignment = NSTextAlignment.left // 左寄せ
        roomNameInputField.placeholder = "ルーム名を入力" // 未入力の場合の表示文字を設定
        roomNameInputField.inputAccessoryView = kbToolBar // 完了ボタンをセット
        self.view.addSubview(roomNameInputField)

        let roomInputLabel = UILabel()
        roomInputLabel.textColor = UIColor(named: "textGray") // ボタンの色をグレー色（textGray）に設定
        roomInputLabel.font = UIFont.systemFont(ofSize: 20) // フォントサイズを変更
        roomInputLabel.frame = CGRect(x: roomNameInputField.frame.origin.x, y: roomNameInputField.frame.origin.y - 20,
                                      width: roomNameInputField.frame.width, height: 20)
        roomInputLabel.textAlignment = NSTextAlignment.left // 左寄せ
        roomInputLabel.text = "ルーム名" // タイトルを設定
        self.view.addSubview(roomInputLabel)
    }
    
    // ルーム作成完了ボタン押下処理（ナビゲーションバー右上のボタン押下）
    @objc func CompletefButtonTapped() {
        print("CompletefButtonTapped")
        print(roomNameInputField.text!)
        print(roomNameInputField.text!.isEmpty)
        if !roomNameInputField.text!.isEmpty {
            Room.create(name: roomNameInputField.text!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: キーボード関連の処理
    // キーボードの改行ボタンを押された場合の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    // キーボードの完了ボタンをタッチした場合にキーボードを閉じる
    @objc func commitButtonTapped(sender: UIButton) {
        self.view.endEditing(true)
    }
    // キーボード外をタッチした場合にキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
