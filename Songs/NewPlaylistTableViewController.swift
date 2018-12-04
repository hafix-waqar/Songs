//
//  NewPlaylistTableViewController.swift
//  Songs
//
//  Created by Hafiz Waqar Mustafa on 10/10/17.
//  Copyright © 2017 Hafiz Waqar Mustafa. All rights reserved.
//

import UIKit
import CoreData

class NewPlaylistTableViewController: UITableViewController {

    var playlistName = ""
    var playlistDescription = ""
    var image: UIImage?
    var songURLS = [URL]()
    var songs = [String]()
    
    // Change this way of getting indexPath
    var cellOneIndexPath = IndexPath()
    var cellTwoIndexPath = IndexPath()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func savePlaylist(_ sender: UIBarButtonItem) {
        let entity = NSEntityDescription.entity(forEntityName: "Playlist", in: context)!
        let playlistClass = Playlist(entity: entity, insertInto: context)
        playlistClass.playlistName = playlistName
        playlistClass.playlistDescription = playlistDescription
        if let myImage = image, let imageData = myImage.jpegData(compressionQuality: 1) as NSData? {
            playlistClass.playlistImage = imageData
        }
        playlistClass.songs = songs
        do {
            try context.save()
        } catch {
            print("error saving in core data")
        }
        print(playlistName)
        print(playlistDescription)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
   
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    @IBAction func getSelectedSongsWithUnwindSegue(sender: UIStoryboardSegue) {
        print("got the unwind segue working")
        if let sourceViewController = sender.source as? ChooseSongsTableViewController {
            let selectedNow = sourceViewController.selectedSongs
            for song in selectedNow {
                songs.append(song)
            }
            tableView.reloadData()
        }
    }
    
}


 // MARK: - Table View
extension NewPlaylistTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        }
        if indexPath.row == 1 { return 100 }
        else { return 70 }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 + songs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! FirstTableViewCell
            cellOneIndexPath = indexPath
            cell.delegate = self
            if image != nil {
                cell.playlistImageView?.image = image
            }
            return cell
        }
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! SecondTableViewCell
            cellTwoIndexPath = indexPath
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath)
            if indexPath.row == 2 {
                cell.textLabel?.text = "Add Songs"
            } else {
                cell.textLabel?.text = songs[indexPath.row - 3]
            }
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cellOne = tableView.cellForRow(at: cellOneIndexPath) as? FirstTableViewCell,
            let cellTwo = tableView.cellForRow(at: cellTwoIndexPath) as? SecondTableViewCell {
            cellOne.playlistNameTextView?.resignFirstResponder()
            cellTwo.playlistDescriptionTextView?.resignFirstResponder()
        } else { print("error getting the cells") }
        if indexPath.row == 2 {
            performSegue(withIdentifier: "chooseSongs", sender: indexPath)
        }
    }
}


//MARK: - Image Picker Controller
extension NewPlaylistTableViewController: FirstTableViewCellDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setPlaylistImage() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Take Photo", style: .default) { action in
            self.camera()
        }
        let photosAction = UIAlertAction(title: "Choose Photo", style: .default) { action in
            self.takePhoto()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func takePhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    private func camera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            self.image = image
            tableView.reloadRows(at: [cellOneIndexPath], with: .automatic)
            dismiss(animated: true, completion: nil)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Table View Cells
class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var playlistImageView: UIImageView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
            playlistImageView.isUserInteractionEnabled = true
            playlistImageView.addGestureRecognizer(gesture)
            playlistImageView.contentMode = .scaleAspectFill
            playlistImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var playlistNameTextView: UITextView! {
        didSet {  playlistNameTextView.textColor = UIColor.lightGray }
    }
    
    weak var delegate: FirstTableViewCellDelegate?
    
    @objc private func imageViewTapped(_ sender: UITapGestureRecognizer) {
        delegate?.setPlaylistImage()
    }
}

class SecondTableViewCell: UITableViewCell {
    @IBOutlet weak var playlistDescriptionTextView: UITextView! {
        didSet {  playlistDescriptionTextView.textColor = UIColor.lightGray }
    }
}

protocol FirstTableViewCellDelegate: class {
    func setPlaylistImage()
}


//MARK: - Text View Delegate
extension NewPlaylistTableViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.tag == 0 {
            playlistName = textView.text
        } else {
            playlistDescription = textView.text
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 0 {
            if textView.text.isEmpty {
                textView.text = "Playlist Name"
                textView.textColor = UIColor.lightGray
                textView.resignFirstResponder()
            } else {
                playlistName = textView.text
            }
        } else {
            if textView.text.isEmpty {
                textView.text = "Description"
                textView.textColor = UIColor.lightGray
                textView.resignFirstResponder()
            } else {
                playlistDescription = textView.text
            }
        }
    }
}



// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
