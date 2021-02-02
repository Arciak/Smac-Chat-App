//
//  UpdateProfile.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 02/02/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class UpdateProfile: UIViewController {
    
    @IBOutlet weak var closeBtn: UIButton!
    
    @IBOutlet weak var userNameTxt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateNamePressed(_ sender: Any) {
        guard let newName = userNameTxt.text, userNameTxt.text != "" else { return }
        let email = UserDataService.instance.email
        let avatarName = UserDataService.instance.avatarName
        let avatarColor = UserDataService.instance.avatarColor
        AuthServices.instance.updateUsrName(newName: newName, email: email, avatarName: avatarName, avatarColor: avatarColor) { (success) in
            if success {
                print("chack mongDb")
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
                self.dismiss(animated: true, completion: nil)
            }
            
            
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
