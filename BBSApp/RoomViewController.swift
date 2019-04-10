//
//  RoomViewController.swift
//  BBSApp
//
//  Created by 早坂甫 on 2019/03/16.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit
import Firebase

class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    let commentInputField = UITextField()
    var tableView: UITableView!
    var comments: [Comment] = []
    var scrollView: UIScrollView!
    var roomId: String = ""
    
    // イニシャライザを追加する。roomIdを初期化する。
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        print("RoomVC roomID : \(roomId)")
        
        // 作成ボタンを設置（バー右上のボタン）
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "更新", style: .done, target: self, action: #selector(updateButtunTapped))

        // テーブルビュー表示
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        // MARK:ルーム名入力欄の作成
        commentInputField.delegate = self
        commentInputField.borderStyle = UITextField.BorderStyle.roundedRect
        commentInputField.keyboardType = UIKeyboardType.default
        commentInputField.frame = CGRect(x: 10, y: view.frame.height - 50, width: view.frame.width * 0.75, height: 40)
        commentInputField.textAlignment = NSTextAlignment.left // 左寄せ
        commentInputField.placeholder = "メッセージを入力" // 未入力の場合の表示文字を設定
        self.view.addSubview(commentInputField)

        let roomInputLabel = UILabel()
        roomInputLabel.textColor = UIColor.black
        roomInputLabel.font = UIFont.systemFont(ofSize: 20) // フォントサイズを変更
        roomInputLabel.frame = CGRect(x: commentInputField.frame.origin.x, y: commentInputField.frame.origin.y - 20,
                                      width: commentInputField.frame.width, height: 20) // 表示位置を設定
        roomInputLabel.textAlignment = NSTextAlignment.left // 左寄せ
        roomInputLabel.text = "メッセージ" // タイトルを設定
        self.view.addSubview(roomInputLabel)
        
        scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.frame.size = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.addSubview(commentInputField)
        scrollView.addSubview(roomInputLabel)
        self.view.addSubview(scrollView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        reroad()
        configureObserver()
    }
    
    // Notification発行
    func configureObserver() {
        let notification = NotificationCenter.default
        notification.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                                 name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                 name: UIResponder.keyboardWillHideNotification, object: nil)
        print("Notificationを発行")
    }
    
    // キーボードが表示時に画面をずらす。
    @objc func keyboardWillShow(_ notification: Notification?) {
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
            self.scrollView.transform = transform
        }
        print("keyboardWillShowを実行")
    }
    
    // キーボードが降りたら画面を戻す
    @objc func keyboardWillHide(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.scrollView.transform = CGAffineTransform.identity
        }
        print("keyboardWillHideを実行")
    }
    
    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.comments.count)
        return self.comments.count
    }

    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = comments[indexPath.row].message
        print(comments[indexPath.row].message)
        return cell
    }

    // MARK: キーボード関連の処理
    // キーボードの改行ボタンを押された場合の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        Comment.post(roomId: roomId, message: commentInputField.text!)
        reroad()
        return true
    }

    func reroad() {
        Comment.getInfoAll(roomId: roomId) { (comments, err) in
            print("GetRoomInfo nakami")
            if let err = err {
                print(err)
                print("Error!!")
                return
            }
            if let comments = comments {
                print(comments)
                print("commentsの件数：\(comments.count)")
                self.comments = comments
                self.tableView.reloadData()
            }
        }

    }
    
    @objc func updateButtunTapped() {
        reroad()
    }
}
