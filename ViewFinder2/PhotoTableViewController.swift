//
//  PhotoTableViewController.swift
//  ViewFinder2
//
//  Created by Eric Smith on 5/25/19.
//  Copyright © 2019 Eric Smith. All rights reserved.
//

import UIKit

class PhotoTableViewController: UITableViewController {

    var photos : [Photos] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        getPhotos()
    }
    
    func getPhotos() {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            
            if let coreDataPhotos = try? context.fetch(Photos.fetchRequest()) as? [Photos] {
            //    if let unwrappedPhotos = coreDataPhotos {
                    photos = coreDataPhotos
                    tableView.reloadData()
           //     }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()

        let cellPhoto = photos[indexPath.row]

       cell.textLabel?.text = cellPhoto.caption
//
//        if let cellPhotoImageData = cellPhoto.imageData {
        
        if let cellphotoImageData = cellPhoto.imageData{
            if let cellPhotoImage = UIImage(data:cellphotoImageData){
                cell.imageView?.image = cellPhotoImage
            }
        
        
            if let cellPhotoImage = UIImage(data: cellphotoImageData) {
            cell.imageView?.image = cellPhotoImage
            }
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "moveToDetail", sender: photos[indexPath.row])
        
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
    if segue.identifier == "moveToDetail" {
        
        if let photoDetailView = segue.destination as? PhotoDetailViewController{
           
            if let photoToSend = sender as? Photos{
            
                photoDetailView.photo = photoToSend
         
            
            }
        }
    }
}
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            
            print("Is this Working")
            
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext{
                
                let photoToDelete = photos[indexPath.row]
                
                context.delete(photoToDelete)
                
                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                
            getPhotos()
            }
        }
        }    
    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


