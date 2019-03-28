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
    var toolbar: UIToolbar!
    var rooms: [Room] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Room.create(name: "test002")
//        Room.deleteAll(collection: "room")
        
        view.backgroundColor = UIColor.white
        
        // MARK: ナビゲーションバーの表示変更
        // タイトルをセット
        title = "BBSアプリ"
        // ナビゲーションバーの色を変更
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "MainColor_EG")
        // 作成ボタンを設置（バー右上のボタン）
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "作成", style: .done, target: self, action: #selector(MakeButtunTapped))
        // 戻るボタンの文字変更（遷移後のバー左上のボタン）
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "戻る", style: .done, target: self, action: nil)

        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        reroad()
    }
    
    @objc func MakeButtunTapped() {
        print("MakeButtunTapped")
        let makeRoomVC: MakeRoomViewController = MakeRoomViewController()
        self.navigationController?.pushViewController(makeRoomVC, animated: true)
    }
    
    // MARK: テーブルビューのセルの高さを設定する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        return 100
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
    
    func reroad() {
        Room.getInfoAll() { (rooms, err) in
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
    }
}

