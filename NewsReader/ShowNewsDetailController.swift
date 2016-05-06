//
//  ShowNewsDetailController.swift
//  NewsReader
//
//  Created by 滕施男 on 19/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class ShowNewsDetailController: UIViewController {

    @IBOutlet var webV: UIWebView!
    
    var currString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWebView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     Load the information via web request. (System will receive the URL when this view loads.)
     */
    func displayWebView() {
        let url = NSURL (string: currString!);
        let requestObj = NSURLRequest(URL: url!);
        webV.loadRequest(requestObj);
    }
}
