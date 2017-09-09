//
//  CustomSongsViewController.swift
//  Songs
//
//  Created by Hafiz Waqar Mustafa on 9/9/17.
//  Copyright © 2017 Hafiz Waqar Mustafa. All rights reserved.
//

import UIKit

class SongsTableViewCell: UITableViewCell {
}


class CustomSongsViewController: SongsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customSongsCell", for: indexPath)
        cell.textLabel?.text = songs[indexPath.row]
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "play", sender: indexPath)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: IndexPath) {
        if segue.identifier! == "play" {
            if let pvc = segue.destination as? MP3PlayerViewController {
                pvc.currentTrack = sender.row
            }
        }
    }


}
