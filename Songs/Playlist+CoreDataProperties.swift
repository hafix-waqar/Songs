//
//  Playlist+CoreDataProperties.swift
//  Songs
//
//  Created by Hafiz Waqar Mustafa on 10/15/17.
//  Copyright © 2017 Hafiz Waqar Mustafa. All rights reserved.
//
//

import Foundation
import CoreData


extension Playlist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Playlist> {
        return NSFetchRequest<Playlist>(entityName: "Playlist")
    }

    @NSManaged public var playlistDescription: String?
    @NSManaged public var playlistImage: NSData?
    @NSManaged public var playlistName: String?
    @NSManaged public var songs: [String]

}
