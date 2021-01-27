//
//  ProfileVC.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 27/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // Outlets
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView! // we will make geasture recognizer that we tap and it will thismissed
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        // now we inform that we logout
        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func customizeView() {
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        UserName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        
        //tap geasture recognizer
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
