//
//  NewAdventurerViewController.swift
//  group14_assignment6
//
//  Created by Dana Brannon on 10/20/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit
import os.log
import CoreData


class NewAdventurerViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let characters = ["cloudImage", "tifaImage", "vincentImage", "yuffieImage", "linkImage"]
    var newAdventurer : NSManagedObject?
    
    let cellIdentifier = "imageSelection"
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nameTextField.delegate = self
        professionTextField.delegate = self
        
//        self.myCollectionView.register(imageSelectionCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier) //THIS CRASHES THE PROGRAM
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        saveButton.isEnabled = false
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        
        //Check if both textfields and a picture is selected.
        if (nameTextField.text != "") && (professionTextField.text != "") {
            saveButton.isEnabled = true
        }
        
        return true
    }
    
    //MARK: - UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! imageSelectionCollectionViewCell
        
        cell.image.image = UIImage(named: "\(characters[indexPath.item])")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected")
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
    
    //MARK: - Actions
    @IBAction func addNewAdventurer(_ sender: UIButton) {
        //newAdventurer = addAdventurer(name: nameTextField.text!, profession: professionTextField.text!, appearance: "linkImage")
    }
    
    
    //MARK: - Add Adventurer
    func addAdventurer(name : String, profession : String, appearance : String) -> NSManagedObject {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity = NSEntityDescription.entity(forEntityName: "Adventurerr", in: managedContext)
        let adventurer = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        adventurer.setValue(name, forKey: "name")
        adventurer.setValue(profession, forKey: "profession")
        adventurer.setValue(appearance, forKey: "appearance")
        adventurer.setValue(1, forKey: "level")
        
        let attack = Int.random(in: 0...5)
        let hp = Int.random(in: 90...150)
        
        adventurer.setValue(attack , forKey: "attack")
        adventurer.setValue(hp, forKey: "currentHP")
        adventurer.setValue(hp, forKey: "totalHP")
        
        do {
            try managedContext.save()
        } catch {
            let nserror = error as NSError
            NSLog("Unable to save \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return adventurer
        
        
    }
    
    // MARK: - Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = nameTextField.text ?? ""
        let profession = professionTextField.text ?? ""
        //let photo = photoImageView.image
        //let rating = ratingControl.rating
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        //SHOULD SET THIS TO ADVENTURER
        //meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
