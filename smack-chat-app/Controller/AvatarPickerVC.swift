//
//  AvatarPickerVC.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 26/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    //Variables
    var avatrType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // cell for item at
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{
            cell.configureCell(index: indexPath.item, type: avatrType)
            return cell
        }
        return AvatarCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // we only have 1 section
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // how many items are in section
        return 28 // we are having 28 avatar imagies
    }
    
    
    @IBAction func segmentControlChanged(_ sender: Any) {
//        let title = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)
//        if title! == "Light" {
//            avatrType = AvatarType.light
//        } else {
//            avatrType = AvatarType.dark
//        }
        //or
        if segmentControl.selectedSegmentIndex == 0 {
            avatrType = .dark
        } else {
            avatrType = .light
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // dynamic sizeing cells to the screen of phone
        var numOfColumns : CGFloat = 3
        if UIScreen.main.bounds.width > 320 { //320 is size of smallest iphone
            numOfColumns = 4
        }
        let spacceBetweenCells : CGFloat = 10
        let padding : CGFloat = 40 // 20 in both sides
        let cellDimension = ((collectionView.bounds.width - padding) - (numOfColumns - 1) * spacceBetweenCells) / numOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    //select avatar
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatrType == .dark {
            UserDataService.instance.setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
