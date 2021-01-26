//
//  CreateAccountVC.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 22/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    //Default Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]" //default grey color
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //update profile/ user image when is selected
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
    }
    
    @IBAction func createAccntPressed(_ sender: Any) {
        guard let name = userNameTxt.text, userNameTxt.text != "" else { return }
        guard let email = emailTxt.text , emailTxt.text != "" else { return }// equla emailTxt.text if or where emailTxt is not empty string
        
        guard let pass = passTxt.text , passTxt.text != "" else { return }
        
        AuthServices.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                AuthServices.instance.loginUser(email: email, password: pass) { (success) in
                    if success {
                        AuthServices.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor) { (success) in
                            if success {
                                print(UserDataService.instance.name, UserDataService.instance.avatarName)
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    @IBAction func pickBgColorPressed(_ sender: Any) {
    }
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    
    
}
