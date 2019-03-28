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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        // テーブルビュー表示
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        // MARK:ルーム名入力欄の作成
        let roomInputLabel = UILabel()
        roomInputLabel.textColor = UIColor(named: "textGray") // ボタンの色をグレー色（textGray）に設定
        roomInputLabel.font = UIFont.systemFont(ofSize: 20) // フォントサイズを変更
        roomInputLabel.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.45,
                                      width: view.frame.width * 0.8, height: view.frame.height * 0.1) // 表示位置を設定
        roomInputLabel.textAlignment = NSTextAlignment.left // 左寄せ
        roomInputLabel.text = "メッセージ" // タイトルを設定
        self.view.addSubview(roomInputLabel)
        
        commentInputField.delegate = self
        commentInputField.keyboardType = UIKeyboardType.default
        commentInputField.frame = CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.5,
                                          width: view.frame.width * 0.7, height: view.frame.height * 0.1) // 表示位置を設定
        commentInputField.textAlignment = NSTextAlignment.left // 左寄せ
        commentInputField.placeholder = "メッセージを入力" // 未入力の場合の表示文字を設定
        self.view.addSubview(commentInputField)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        reroad()
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

    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
//        let roomVC: RoomViewController = RoomViewController()
//        self.navigationController?.pushViewController(roomVC, animated: true)
    }
    
    // MARK: キーボード関連の処理
    // キーボードの改行ボタンを押された場合の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        Comment.post(message: commentInputField.text!)
        return true
    }

    func reroad() {
        Comment.getInfoAll() { (comments, err) in
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
}
