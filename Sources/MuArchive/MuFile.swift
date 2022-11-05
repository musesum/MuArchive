//
//  MuFile.swift
//  MuseSky
//
//  Created by warren on 9/23/19.
//  Copyright © 2019 DeepMuse All rights reserved.
//

import UIKit
import Compression
import ZIPFoundation

class MuFile {
    
    static let shared = MuFile()
    private let fileManager = FileManager.default
    private let documentURL: URL
    private let libraryURL: URL
    private var fileURLs: [URL]

    init() {
        documentURL = FileManager.default.urls(for: .documentDirectory,
                                          in: .userDomainMask).first!

        libraryURL = FileManager.default.urls(for: .libraryDirectory,
                                          in: .userDomainMask).first!
        
        fileURLs = fileManager.contentsOf(ext: nil)
        printFileURLs()
    }
    func printFileURLs() {
        for url in fileURLs {
            print(url)
        }
    }
    func saveFile(_ name: String, script: String) {
        let filename = documentURL.appendingPathComponent(name)
        do {
            try script.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("🚫 \(error)")
        }
    }
    func saveFile(_ name: String, image: UIImage) -> Bool {

        let filename = documentURL.appendingPathComponent(name)

        do {
            if name.hasSuffix("jpg") {
                if let data = image.jpegData(compressionQuality: 1)  {
                    try data.write(to: filename)
                }
            } else {
                if let data = image.pngData() {
                    try data.write(to: filename)
                }
            }
        }
        catch {
            print("🚫 \(error)")
            return false
        }
        return true
    }
    func saveFile(_ name: String, data: Data) -> Bool {

        let filename = documentURL.appendingPathComponent(name)

        do { try data.write(to: filename) }

        catch {
            print("🚫 \(error)")
            return false
        }
        return true
    }
    /**
     Get creation date from file. This is explicitely set and should match between devices.
     */
    func getFileTime(_ fileName: String, _ path: String) -> TimeInterval {

        let filePath = path + "/" + fileName
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            let fileDate = (fileAttributes[FileAttributeKey.creationDate] as? NSDate)!
            let fileTime = fileDate.timeIntervalSince1970
            //Log("⧉ \(#function) \(fileTime)")
            return fileTime
        }
        catch let err as NSError {
            print("🚫 getFileTime(\(fileName)) error: \(err.localizedFailureReason ?? "")")
        }
        return 0
    }
    public func documentDate(_ fileName: String) -> TimeInterval {
        return getFileTime( fileName, documentURL.path)
    }
    public func libraryDate(_ fileName: String) -> TimeInterval {
        return getFileTime( fileName, libraryURL.path)
    }
}
