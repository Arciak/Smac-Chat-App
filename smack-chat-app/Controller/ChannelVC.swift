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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    
}
