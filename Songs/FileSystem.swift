//
//  File.swift
//  Songs
//
//  Created by Hafiz Waqar Mustafa on 9/8/17.
//  Copyright © 2017 Hafiz Waqar Mustafa. All rights reserved.
//

import Foundation

final class FileSystem {
    
    private init() {
    }
    
    private static var URLsOfAllFilesInDocumentsDirectory = [URL]()
    
    static let documentsDirectoryUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static func URLs() -> [URL] {
        do {
            URLsOfAllFilesInDocumentsDirectory = try FileManager.default.contentsOfDirectory (
                at: documentsDirectoryUrl,
                includingPropertiesForKeys: nil,
                options: FileManager.DirectoryEnumerationOptions()
            )
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return URLsOfAllFilesInDocumentsDirectory
    }
    
    static func mp3URLs() -> [URL] {
        let mp3FileURLs = URLs().filter { $0.pathExtension == "mp3" }
        return mp3FileURLs
    }
    
    static func songs() -> [String] {
        let mp3FileNames = mp3URLs().map { $0.lastPathComponent }
        return mp3FileNames
    }
    
    //    static let shared = Songs()

}
