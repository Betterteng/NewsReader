//
//  New.swift
//  NewsReader
//
//  Created by 滕施男 on 19/04/2016.
//  Copyright © 2016 TENG. All rights reserved.
//

import UIKit

class News: NSObject {
    
    var link: String?
    var title: String?
    var desc: String?
    var pubDate: String?
    var thumbnail: String?

    init(realNews: NSDictionary) {
        self.link = realNews.objectForKey("link") as? String
        self.title = realNews.objectForKey("title") as? String
        self.desc = realNews.objectForKey("description") as? String
        self.pubDate = realNews.objectForKey("pubDate") as? String
        //Get the string we want.
        self.thumbnail = realNews.objectForKey("group")?.objectForKey("thumbnail")?.objectForKey("url") as? String
    }
}
