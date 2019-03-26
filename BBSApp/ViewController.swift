//
//  ViewController.swift
//  BBSApp
//
//  Created by 早坂甫 on 2019/02/17.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView!
    var tableList: [String] = ["a", "b", "c"]
    var toolbar: UIToolbar!
    var rooms: [Room] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Room.CreateNewRoom(name: "test003")
        
        print("GetRoomInfo call")
        Room.GetRoomInfo(name: "room") { (rooms, err) in
            print("GetRoomInfo nakami")
            if let err = err {
                print(err)
                print("Error!!")
                return
            }
            if let rooms = rooms {
                print(rooms)
                print("roomsの件数：\(rooms.count)")
                self.rooms = rooms
                self.tableView.reloadData()
            }
        }
        print("GetRoomInfo 通過")
        
//        DeleteRoom(db: db, id: "zY9wkP79m2S6QcJHIKWr")

//         // データ更新
//        db.collection("room").document("png1facJtRLoKifvMvAK").updateData([
//            "born": FieldValue.delete(),
//            ]) { err in
//                if let err = err {
//                    print("Error updating document: \(err)")
//                } else {
//                    print("Document successfully updated")
//                }
//        }

        view.backgroundColor = UIColor.white
        
        // 上部のタイトル表示
        title = "BBSアプリ"
        
        // ナビゲーションバーの表示変更
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainColor_EG") // ナビゲーションバーの色を変更
        
        // ルーム一覧をテーブルビューで表示
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        // 画面下部のツールバーを表示
        toolbar = UIToolbar(frame: CGRect(x: 0, y: view.frame.height - 50, width: view.frame.width, height: 50))
        toolbar.barTintColor = UIColor(named: "MainColor_EG")
        self.view.addSubview(toolbar)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        return 100
    }
    
    @objc func onClick(sender: UIBarButtonItem) {
        let secondVC: MakeRoomViewController = MakeRoomViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
    // MARK: テーブルビューのセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rooms.count
    }
    
    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = rooms[indexPath.row].name
        print("indexPath:\(indexPath)")
        print("indexPath.row:\(indexPath.row)")
        return cell
    }
    
    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        let roomVC: RoomViewController = RoomViewController()
        self.navigationController?.pushViewController(roomVC, animated: true)
    }
    
    /*
    GetRoomInfo データ取得できていない状態
    ↓                       ↓
    別処理
    ↓                       ↓
    別処理
    ↓                       ↓
    別処理                   completion()
    ↓                       ↓
    completion成立          ←
    ↓
    */
}

