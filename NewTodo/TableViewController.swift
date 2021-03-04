//
//  TableViewController.swift
//  NewTodo
//
//  Created by Distillery on 2/27/21.
//

import UIKit

class TableViewController: UITableViewController {

    @IBAction func editClicked(_ sender: Any) {
        self.tableView.setEditing(!tableView.isEditing, animated: true);
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func pushNewItem(_ sender: Any) {
        let alertController = UIAlertController(title: "Create new item", message: nil, preferredStyle: .alert)
        
        
        alertController.addTextField { textField in
            textField.placeholder = "New todo";
        }
        
        let alertActionCreate = UIAlertAction(title: "Create", style: .cancel) { action in
            addItem(item: alertController.textFields![0].text!)
            self.tableView.reloadData()
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .default) { action in
            
        }
        
        
        alertController.addAction(alertActionCreate)
        alertController.addAction(alertActionCancel)

        
        present(alertController, animated: true, completion: nil)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView();

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return toDoItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = toDoItems[indexPath.row]["name"] as? String
        cell.imageView?.image = (toDoItems[indexPath.row]["isCompleted"] as! Bool) ? #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "uncheck");
        
        if tableView.isEditing {
            cell.textLabel?.alpha = 0.4;
            cell.imageView?.alpha = 0.4;
            
        } else {
            cell.textLabel?.alpha = 1;
            cell.imageView?.alpha = 1;
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.cellForRow(at: indexPath)?.imageView?.image = changeState(at: indexPath.row) ? #imageLiteral(resourceName: "check") : #imageLiteral(resourceName: "uncheck");
        tableView.reloadData()
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView.isEditing {
            return .none
        } else {
            return .delete
        }
        
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        changeOrder(fromIndex: fromIndexPath.row, toIndex: to.row)
        self.tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
