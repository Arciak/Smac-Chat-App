//
//  ChannelVC.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 21/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //Outlets
    // potrzebujemy outlet dla loginBtn bo zmieniamy nazwe w zaleznosci czy ktos jest zalogowany czy nie jest
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userImg: CircleImage!
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
        //listening
        NotificationCenter.default.addObserver(self, selector: #selector (ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_CHANGE, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // when we open app from scrach
        setUpUserInfo()
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        // when we are login it can take us to our PrifileVC so make a check
        if AuthServices.instance.isLoggedIn {
            //Show profile page
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    //this function we create for notificationCenetr
    @objc func userDataDidChange(_ notif: Notification) {
        // add obserevr to listen when notfication is brodcast
        setUpUserInfo()
    }
    
    func setUpUserInfo() {
        if AuthServices.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }
    
}
