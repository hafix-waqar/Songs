//
//  ChooseSongsTableViewController.swift
//  Songs
//
//  Created by Hafiz Waqar Mustafa on 10/14/17.
//  Copyright © 2017 Hafiz Waqar Mustafa. All rights reserved.
//

import UIKit

class ChooseSongsTableViewController: UITableViewController {
    
    var selectedSongs = [String]()
    var songs = [String]()

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songs = FileSystem.songs()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseSongsCell", for: indexPath)
        // Configure the cell...
        let song = songs[indexPath.row]
        cell.textLabel?.text = song
        if selectedSongs.contains(song) {
            cell.accessoryType = .checkmark
        } else { cell.accessoryType = .none }
        
        cell.textLabel?.numberOfLines = 3
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.highlightedTextColor = UIColor.black
        cell.textLabel?.minimumScaleFactor = 6
        cell.textLabel?.textColor = UIColor.colorFrom(RGBValue: Constants.Colors.AntiqueWhite)
        //cell.detailTextLabel?.text = "album"
        cell.imageView?.image = #imageLiteral(resourceName: "musicIcon60")
        cell.selectionStyle = .blue

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let selectedSong = songs[indexPath.row]
            if selectedSongs.contains(selectedSong) {
                if let index = selectedSongs.index(where: { $0 == selectedSong }) {
                    selectedSongs.remove(at: index)
                    print("\(selectedSong) at index \(index) is removed")
                }
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
                selectedSongs.append(selectedSong)
            }
        }
    }
}
