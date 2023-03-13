//
//  FirebaseService.swift
//  Ably
//
//  Created by 김진혁 on 2023/03/12.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

final class FirebaseService{
    let storage = Storage.storage()
    //firebase
    var firebaseDB: DatabaseReference = Database.database().reference()
    
}

extension FirebaseService{
    
    func iconImage(){
        let storageRef = storage.reference().child("allPage.png")
        
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else {
                let image = UIImage(data: data!, scale: UIScreen.main.scale)
            }
        }
    }
    
    func dataBaseEx(){
        
        
        self.firebaseDB.observeSingleEvent(of: .value){snap in
            guard let data = snap.value as? [String:Any] else {return}
            print(data)
            /***
             ["test": {
             name = ABC;
             price = 36000;
             }]
             */
            let value = try! JSONSerialization.data(withJSONObject: Array(data.values), options: [])
            print(value)//30bytes
            do{
                //let finalValue = try JSONDecoder().decode([Test].self, from: value)
                print("final")
                //print(finalValue[0].name)
            }catch let error{
                print("error")
            }
            
        }
    }
   
}
