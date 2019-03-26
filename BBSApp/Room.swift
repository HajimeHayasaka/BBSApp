//
//  Room.swift
//  BBSApp
//
//  Created by 早坂甫 on 2019/03/24.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit
import Firebase

class Room {
    var name: String
//    var createTime: String
//    var updateTime: String
    
    init(doc: DocumentSnapshot) {
        if let name = doc.get("name") as? String {
            self.name = name
        } else {
            self.name = "Error"
            print("init Error")
        }
        
    }
    
    // MARK: 部屋を新規作成（ルームのドキュメントを１つ追加）
    static func CreateNewRoom(name: String) {
        let db = Firestore.firestore()
        // データ追加
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("room").addDocument(data: [
            "name": name,
            "create_time": FieldValue.serverTimestamp(),
            "update_time": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // MARK: 部屋を削除（ルームのドキュメントを１つ削除）
    static func DeleteRoom(id: String) {
        let db = Firestore.firestore()
        // データ削除
        db.collection("room").document(id).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("DocumentID[\(id)] successfully removed!")
            }
        }
    }
    
    // MARK: 部屋を全て削除する（ルームのドキュメントを全て削除）
    static func AllDeleteRoom(collection: String) {
        let db = Firestore.firestore()
        // データ取得
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.DeleteRoom(id: document.documentID)
                }
            }
        }
    }
    // MARK: 部屋の情報を全て取得する（ルームのドキュメントを全て取得）
    // 非同期時の対策 クロージャ メモリ管理方法でescapingがつかわれる
    static func GetRoomInfo(name: String, completion: @escaping([Room]?, NSError?) -> Void) {
        let db = Firestore.firestore()
        print("GetRoomInfo メソッド1")
        db.collection(name).getDocuments() { (querySnapshot, err) in // ここから非同期
            print("GetRoomInfo メソッド2")
            if let err = err {
                completion(nil, err as NSError)
                print("Error getting documents: \(err)")
            } else {
                var rooms: [Room] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let room = Room(doc: document)
                    rooms.append(room)
                }
                completion(rooms, nil)
            }
        }
        print("GetRoomInfo メソッド END")
    }
}
