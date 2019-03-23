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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let db = Firestore.firestore()
//
//        // Add a new document with a generated ID
//        var ref: DocumentReference? = nil
//        ref = db.collection("room").addDocument(data: [
//            "name": "Room1",
//            "create_time": FieldValue.serverTimestamp(),
//            "update_time": FieldValue.serverTimestamp()
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
//
//        // Add a second document with a generated ID.
//        ref = db.collection("room").addDocument(data: [
//            "first": "Alan",
//            "middle": "Mathison",
//            "last": "Turing",
//            "born": 1912
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
//
//        db.collection("room").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
//                }
//            }
//        }
//
//        db.collection("room").document().delete() { err in
//            if let err = err {
//                print("Error removing document: \(err)")
//            } else {
//                print("Document successfully removed!")
//            }
//        }
//
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
        
        title = "BBSApp"
        
        // テーブルビュー表示
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
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
        return self.tableList.count
    }
    
    // MARK: テーブルビューのセルの中身を設定する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    // MARK: テーブルビューのセルが押されたら呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)番のセルを選択しました！ ")
        let roomVC: RoomViewController = RoomViewController()
        self.navigationController?.pushViewController(roomVC, animated: true)
    }
}

