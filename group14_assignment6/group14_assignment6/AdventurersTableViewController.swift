//
//  AdventurersTableViewController.swift
//  group14_assignment6
//
//  Created by Dana Brannon on 10/20/19.
//  Copyright © 2019 Dana Brannon. All rights reserved.
//

import UIKit
import CoreData
import os.log

class AdventurersTableViewController: UITableViewController {
    var adventurers = [NSManagedObject]()
    
    //Get data from the persistent store
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Adventurerr")
        
        //3
        do {
            adventurers = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return adventurers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let person = adventurers[indexPath.row]
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdventurersTableViewCell", for: indexPath) as! AdventurersTableViewCell
        
        cell.attackLabel.text = "Attack:"
        cell.hpLabel.text = "HP:"
        let imageName = person.value(forKeyPath: "appearance") as! String
        
        cell.nameLabel?.text = person.value(forKeyPath: "name") as? String
        cell.professionLabel?.text = person.value(forKeyPath: "profession") as? String
        cell.levelLabel.text = "\(person.value(forKeyPath: "level")!)"
        var attack = person.value(forKey: "attack") as! Float
        cell.attackScoreLabel.text = String(format: "%.2f", attack)
        cell.hpScoreLabel.text = "\(person.value(forKeyPath: "currentHP")!)" + "/" + "\(person.value(forKeyPath: "totalHP")!)"
        cell.characterImageView.image = UIImage(named: imageName)
        
        return cell
    }
    
    // Set table row height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }

    // MARK: - Actions

    
    @IBAction func unwindToTableViewWithSavedData(sender: UIStoryboardSegue) {
        // Code to increase number of rows? -- Miguel
        if let sourceViewController = sender.source as? NewAdventurerViewController,
            let newAdventurer = sourceViewController.finalAdventurer {
                let newIndexPath = IndexPath(row: adventurers.count, section: 0)
                adventurers.append(newAdventurer)
            
           
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
        // Case for unwinding from Quest Log
        if let sourceViewController = sender.source as? QuestLogViewController,
            let adventurer = sourceViewController.adventurer {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing adventurer with new level.
                adventurers[selectedIndexPath.row] = adventurer
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            
        }
    }
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let questLogDetailViewController = segue.destination as? QuestLogViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedAdventurerCell = sender as? AdventurersTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedAdventurerCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            
            let selectedAdventurer = adventurers[indexPath.row]
            //print("Selected adventurer:", selectedAdventurer.name)
            
            questLogDetailViewController.adventurer = selectedAdventurer
        case "newAdventurerRecruit":
            guard let newAdventurerVC = segue.destination as? NewAdventurerViewController else {
                fatalError("Unexpected sender: \(segue.destination)")
            }
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    
}


