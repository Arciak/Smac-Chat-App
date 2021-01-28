//
//  ChatVC.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 21/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        //doing check if we are logged in
        if AuthServices.instance.isLoggedIn {
            AuthServices.instance.findUserByEmail { (success) in
                NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGE, object: nil)
            }
            
            MessageService.instance.findAllChannel { (success) in
                       
            }
        }
    }

}
