//
//  NewsListController.swift
//  NewsReader
//
//  Created by 滕施男 on 19/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class NewsListController: UITableViewController {
    
    var newsList: NSMutableArray?
    let newsURL: String = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20feed%20where%20url=%27www.abc.net.au%2Fnews%2Ffeed%2F51120%2Frss.xml%27&format=json"

    override func viewDidLoad() {
        super.viewDidLoad()
        newsList = NSMutableArray()
        
        downloadNewsData()
    }
    
    /*
     When the view loads, it will begin to download the data.
     This method will send the actual request to the webserver create a session.
     If everything goes well, then it will execute the parseNewJSON method.
     */
    func downloadNewsData() {
        let url: NSURL = NSURL(string: newsURL)!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {
            (data, response, error) in
            if (error != nil) {
                let alert = UIAlertController(title: "Sorry!", message: "We may lost network connection:(", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            } else {
                self.parseNewsJSON(data!)
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
    
    /*
     This method will help us find the information we want, then store them in the NSMutableArray.
     */
    func parseNewsJSON(newsJSON: NSData) {
        do {
            let result = try NSJSONSerialization.JSONObjectWithData(newsJSON, options: NSJSONReadingOptions.MutableContainers)
            //Find the data we want.
            let newsArray = result.objectForKey("query")?.objectForKey("results")?.objectForKey("item") as! NSArray
            NSLog("Found \(newsArray.count) new news!")
            for realNews in (newsArray as NSArray as! [NSDictionary]) {
                let news = News(realNews: realNews)
                //Store the object we created in the NSMutableArray.
                newsList!.addObject(news)
            }
        } catch {
            print("JSON Serialization error")
        }
    }
    
    /*
     Set the image and value of labels in every cell.
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as! NewsCell
        
        // Configure the cell...
        let news: News = newsList![indexPath.row] as! News
        if (news.thumbnail != nil) {
            let imageURL: String = news.thumbnail!
            let url = NSURL(string: imageURL)
            let data = NSData(contentsOfURL: url!)
            if data != nil {
                cell.imageV.image = UIImage(data: data!)
            }
        }
        if (news.title != nil) {
            cell.titleL.text = news.title
        }
        if (news.desc != nil) {
            let s1: String = news.desc!
            let s2: String = s1.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
            let s3: String = s2.stringByReplacingOccurrencesOfString("<p>", withString: "")
            let s4: String = s3.stringByReplacingOccurrencesOfString("</p>", withString: "")
            cell.descL.text = s4
        }
        return cell
    }
    
    /*
     Before the showNewsDetailSegue has been triggered, system will prepare for a "URL of news detail"
     and pass it to the ShowNewsDetailController.
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showNewsDetailSegue") {
            let controller: ShowNewsDetailController = segue.destinationViewController as! ShowNewsDetailController
            let news: News = self.newsList![(self.tableView.indexPathForSelectedRow?.row)!] as! News
            controller.currString = news.link
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /*
     There is only one section in the tableView, so we return 1.
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (newsList?.count)!
    }
}
