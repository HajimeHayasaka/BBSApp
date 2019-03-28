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
    
    // MARK: 部屋を新規作成（ルームのドキュメントを１つ追加）
    static func post(message: String) {
        let db = Firestore.firestore()
        // データ追加
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("comment").addDocument(data: [
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
    
    // MARK: 部屋の情報を全て取得する（ルームのドキュメントを全て取得）
    // 非同期時の対策 クロージャ メモリ管理方法でescapingがつかわれる
    static func getInfoAll(completion: @escaping([Comment]?, NSError?) -> Void) {
        let db = Firestore.firestore()
        db.collection("comment").getDocuments() { (querySnapshot, err) in // ここから非同期
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
}
