//
//  ArticlesService.swift
//  Actor exs v2
//
//  Created by Vlad on 05.03.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import Foundation

final class ArticlesService {
    
    static let sharedInstance = ArticlesService()
    private var articles: [Article] = []
    
    private func loadFromPlist() {
        guard let pathToFile = Bundle.main.path(forResource: "Contents", ofType: ".plist") else { return }
        guard let chapterArray = NSArray(contentsOfFile: pathToFile) else { return }
        
        for (chapterIndex, elemChapter) in chapterArray.enumerated() {
            
            for (articleIndex, elemArticle) in (elemChapter as! NSArray).enumerated() {
                guard let articleDictonary = elemArticle as? [AnyHashable: Any] else { return }
                
                let article = Article(dictionary: articleDictonary)
                article.chapter = chapterIndex
                article.index = articleIndex
                articles.append(article)
            }
        }
    }
    
    private init() {
        loadFromPlist()
    }
    
    func firstArticleIn(chapter: Int ) -> Article? {
        return articles.first(where: { $0.chapter == chapter })
    }
    
    func articlesIn(chapter: Int) -> [Article] {
        return articles.filter { $0.chapter == chapter }
    }
    
    func starredArticles() -> [Article] {
        return articles.filter { $0.starred }
    }
}
