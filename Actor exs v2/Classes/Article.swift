//
//  Article.swift
//  Actor exs v2
//
//  Created by Vlad on 03.04.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import Foundation

final class Article {
    
    var chapter = 0
    var index = 0
    var id: String
    var articleName: String
    var fileName: String?
    var videoLink: String?
    
    var starred: Bool {
        
        get { return UserDefaults.standard.bool(forKey: id) }
        set { UserDefaults.standard.set(newValue, forKey: id) }
    }

    init(dictionary: [AnyHashable: Any]) {

        id = dictionary["ID"] as? String ?? ""
        articleName = dictionary["Article name"] as? String ?? ""
        articleName = dictionary["Article name"] as? String ?? ""
        fileName = dictionary["File name"] as? String
        videoLink = dictionary["Video link"] as? String
    }
}
