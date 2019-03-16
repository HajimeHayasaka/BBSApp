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

class ViewController: UIViewController {

    var topNavBar: UINavigationBar!
    var topNavBarItems: UINavigationItem!
    var addRoomNavBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("room").addDocument(data: [
            "name": "Room1",
            "create_time": FieldValue.serverTimestamp(),
            "update_time": FieldValue.serverTimestamp()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        // Add a second document with a generated ID.
        ref = db.collection("room").addDocument(data: [
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        db.collection("room").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        db.collection("room").document().delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
        db.collection("room").document("png1facJtRLoKifvMvAK").updateData([
            "born": FieldValue.delete(),
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
        }

        view.backgroundColor = UIColor.blue
        
        topNavBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 100))
        topNavBar.barTintColor = UIColor.red
        topNavBar.backgroundColor = UIColor.green
        
        
        // NavigationBarのItemを生成
        topNavBarItems = UINavigationItem()
        title = "BBSApp"
        
        addRoomNavBtn = UIBarButtonItem(title: "作成", style: .plain, target: self, action: #selector(onClick(sender:)))
        self.navigationItem.rightBarButtonItem = addRoomNavBtn
        topNavBarItems.rightBarButtonItem = addRoomNavBtn

        topNavBar.pushItem(topNavBarItems, animated: true)
        self.view.addSubview(topNavBar)
    }
    
    @objc func onClick(sender: UIBarButtonItem) {
        let secondVC: MakeRoomViewController = MakeRoomViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
}

