//
//  Comment.swift
//  BBSApp
//
//  Created by 早坂甫 on 2019/03/28.
//  Copyright © 2019年 早坂甫. All rights reserved.
//

import UIKit
import Firebase

class Comment {
    var message: String
    
    init(doc: DocumentSnapshot) {
        if let message = doc.get("message") as? String {
            self.message = message
        } else {
            self.message = "Error"
            print("init Error")
        }
    }
    
    // MARK: メッセージ投稿
    static func post(roomId: String, message: String) {
        let db = Firestore.firestore()
        // データ追加
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("comment").addDocument(data: [
            "room_id": roomId,
            "message": message,
            "update_time": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // MARK: コメント情報を全て取得する（コメントのドキュメントを全て取得）
    // 非同期時の対策 クロージャ メモリ管理方法でescapingがつかわれる
    static func getInfoAll(roomId: String, completion: @escaping([Comment]?, NSError?) -> Void) {
        let db = Firestore.firestore()
        
//        db.collection(name).whereField(Post.uid, isEqualTo: uid).order(by: createdAt, descending: true).limit(to: 50).getDocuments { (querySnapshot, error) in
        // whereField はif文のようなもの。
        // orderはソート。by は何で並び替えるか？　descending true = 降順。　false = 昇順。
        db.collection("comment").whereField("room_id", isEqualTo: roomId).order(by: "update_time", descending: false).getDocuments() { (querySnapshot, err) in // ここから非同期
            if let err = err {
                completion(nil, err as NSError)
                print("Error getting documents: \(err)")
            } else {
                var comments: [Comment] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let comment = Comment(doc: document)
                    comments.append(comment)
                }
                completion(comments, nil)
            }
        }
    }
    
    // MARK: コメントを削除（ドキュメントを１つ削除）
    static func delete(doc: String) {
        let db = Firestore.firestore()
        // データ削除
        db.collection("comment").document(doc).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("DocumentID[\(doc)] successfully removed!")
            }
        }
    }
    
    // MARK: コメントを全て削除する（ドキュメントを全て削除）
    static func deleteAll() {
        let db = Firestore.firestore()
        // データ取得
        db.collection("comment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.delete(doc: document.documentID)
                }
            }
        }
    }

}
