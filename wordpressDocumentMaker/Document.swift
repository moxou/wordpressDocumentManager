//
//  Document.swift
//  wordpressDocumentMaker
//
//  Created by Guillaume Escrivant on 09/04/2016.
//  Copyright © 2016 ___moxsoft___. All rights reserved.
//

import Cocoa
import WebKit

class Document: NSPersistentDocument , NSTabViewDelegate, WebFrameLoadDelegate {
    @IBOutlet var HTMLView: WebView!
    @IBOutlet var HTMLOpenBalise: NSTextFieldCell!
    @IBOutlet var HTMLValue: NSTextFieldCell!
    @IBOutlet var HTMLCloseBalise: NSTextFieldCell!

    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }
    
    func tabView(_tabView: NSTabView, didSelectTabViewItem tabViewItem: NSTabViewItem?) {
//        Swift.print("new tabView : \(tabViewItem?.label)")
        self.displayHTML()
        
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }
    
    func displayHTML() {
        let HTMLString = HTMLValue.stringValue
        HTMLView.mainFrame.loadHTMLString(HTMLString, baseURL: nil)
    }

    func webView(sender: WebView!, didFinishLoadForFrame frame: WebFrame!) {
        Swift.print("webView(sender: WebView!, didFinishLoadForFrame frame: WebFrame!)")
        let myDOMDocument = sender.mainFrameDocument
        let htmlContent1 = sender.stringByEvaluatingJavaScriptFromString("document.documentElement.innerHTML;")
        let htmlContent2 = sender.stringByEvaluatingJavaScriptFromString("document.body.innerHTML;")
        let htmlContent3 = sender.stringByEvaluatingJavaScriptFromString("document.body.innerText;")
        let runFunctionResult = sender.stringByEvaluatingJavaScriptFromString("myFunction();")
        
        
//        Swift.print("\(htmlContent1)")
//        Swift.print("\(htmlContent2)")
//        Swift.print("\(htmlContent3)")
//        Swift.print("\(runFunctionResult)")

    }
    func webView(webView: WebView!, didCreateJavaScriptContext context:JSContext!, forFrame frame: WebFrame!)    {
        Swift.print("WebFrameLoadDelegate.webView(_: WebView!, didCreateJavaScriptContext: JSContext!, forFrame: WebFrame!))")
        let block : @convention(block) (NSDictionary) -> Void = { (dict : NSDictionary) -> Void in
            Swift.print("login data : \(dict.description)")
        }
        context.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: "sendObjcLoginAction")
    }
    
}
