//
//  PreferencePanelManager.swift
//  wordpressDocumentMaker
//
//  Created by Guillaume Escrivant on 17/04/2016.
//  Copyright © 2016 ___moxsoft___. All rights reserved.
//

import Foundation
import AppKit

class WDMPreferenceWindowManager: NSWindowController {
    @IBOutlet weak var gameOptionPopUpButton: NSPopUpButton!
    @IBOutlet weak var addGameButton: NSButton!
    @IBOutlet weak var newGameName: NSTextField!
    @IBOutlet weak var newGameButton: NSButton!
    
    private var userDefaults: NSUserDefaults!
    
/*
    convenience init() {
        Swift.print(#file, #function)
        self.init(windowNibName: "PreferenceWindow")
    }

    override var windowNibName: String? {
        Swift.print(#file, #function)
        return "PreferenceWindow"
    }

    override init(window: NSWindow!)
    {
        super.init(window: window)
        Swift.print(#file, #function)
    }
    
    required init?(coder: (NSCoder!))
    {
        super.init(coder: coder)
        Swift.print(#file, #function)
    }
*/
    override func windowDidLoad() {
        userDefaults = NSUserDefaults.standardUserDefaults()
        super.windowDidLoad()
        Swift.print(#file, #function)
    }

    override func showWindow(sender: AnyObject?) {
        addGameButton.bordered=true
        newGameButton.hidden=true
        newGameName.hidden=true
        let fileManager = NSFileManager()
        
        //ApplicationSupportDirectory
        if let url = fileManager.URLsForDirectory(.DownloadsDirectory, inDomains: .LocalDomainMask).first {
            let identifier = NSBundle.mainBundle().bundleIdentifier!
            let appSupportDirectory = url.URLByAppendingPathComponent(identifier)
            let resourceKeys = [NSURLNameKey, NSURLIsDirectoryKey]
            let directoryEnumerator = fileManager.enumeratorAtURL(url, includingPropertiesForKeys: resourceKeys, options: [.SkipsHiddenFiles], errorHandler: nil)!
            
            var fileURLs: [NSURL] = []
            for case let fileURL as NSURL in directoryEnumerator {
                guard let resourceValues = try? fileURL.resourceValuesForKeys(resourceKeys),
                    let isDirectory = resourceValues[NSURLIsDirectoryKey] as? Bool,
                    let name = resourceValues[NSURLNameKey] as? String
                    else {
                        continue
                }
                
                if isDirectory {
                    if name == "_extras" {
                        directoryEnumerator.skipDescendants()
                    }
                } else {
                    fileURLs.append(fileURL)
                }
            }        }
        
        super.showWindow(self)
    }

    @IBAction func SelectGame(sender: AnyObject) {
        window!.setIsVisible(false)
    }
    
    @IBAction func ShowNewGameOption(sender: AnyObject) {
        addGameButton.bordered=false
        newGameName.hidden=false
        newGameButton.hidden=false
   }
    
    @IBAction func CreateGame(sender: NSButton) {
        window!.setIsVisible(false)        
    }
    
}