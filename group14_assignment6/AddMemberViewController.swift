//
//  ViewController.swift
//  group14_assignment6
//
//  Created by Arriaga, Miguel A on 10/15/19.
//  Copyright © 2019 Arriaga, Miguel A. All rights reserved.
//

import UIKit

class AddMemberViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let cellIdentifier = "imageSelection"
    //MARK: - Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://stackoverflow.com/questions/41191491/using-collectionview-in-uiview-with-xib-file
//        self.myCollectionView.register(imageSelectionCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! imageSelectionCollectionViewCell
        
        cell.image.image = UIImage(named: "default")
        return cell
    }


}

