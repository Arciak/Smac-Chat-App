//
//  AvatarCell.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 26/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit


// dark or light cell
enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    //first thing called afetr nib
    override func awakeFromNib() {
        super.awakeFromNib()
        self.custiomizeView()
    }
    
    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func custiomizeView() {
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true //view doesn't spill outside the corner radious
    }
    
}
