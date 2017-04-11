//
//  ArticalViewController.swift
//  Actor exs v2
//
//  Created by Vlad on 17.02.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import UIKit
import Foundation
import SideMenuController

final class ArticleViewController: UIViewController {
    
    var articles: [Article]?
    var index: Int? {
        didSet { handleIndexChange() }
    }
    
    private var pageViewController: PageViewController?
    
    var article: Article? {
        guard let articles = articles else { return nil }
        guard let index = index else { return nil }
        guard index >= 0 && index < articles.count else { return nil }
        
        return articles[index]
    }
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var entireView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomBar.backgroundColor = Constants.Color.background
        bottomBar.layer.borderColor = Constants.Color.split.cgColor
        bottomBar.layer.borderWidth = 0.5
        
        // Отключение вызова бокового меню в сцене ArticleView
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: nil)
        entireView.addGestureRecognizer(swipeGestureRecognizer)
        
        handleIndexChange()
    }
    
    @IBAction func tapFavoriteButton(_ sender: UIBarButtonItem) {
        guard let article = article else { return }
        
        article.starred = !article.starred
        updateFavouriteButton()
    }
    
    private func handleIndexChange() {
        
        updateFavouriteButton()
        updateTitle()
        updatePositionLabel()
        updateStoredAppState()
    }
    
    
    private func updateFavouriteButton() {
        
        if article?.starred == true {
            favoriteButton.image = UIImage(named: "Star Filled")
        } else {
            favoriteButton.image = UIImage(named: "Star")
        }
    }
    
    private func updateTitle() {
        navigationItem.title = article?.articleName
    }
    
    private func updatePositionLabel() {
        guard let articlesCount = articles?.count else { return }
        guard let index = index else { return }
        
        positionLabel.text = "\(index + 1) из \(articlesCount)"
    }
    
    private func updateStoredAppState() {
        
        // Для перезапуска приложения с последней статьи
        UserDefaults.standard.set(article?.chapter, forKey: "LastViewedChapter")
        UserDefaults.standard.set(index, forKey: "LastViewedIndex")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is PageViewController {
            
            pageViewController = segue.destination as? PageViewController
            pageViewController?.configureWith(articles: articles, initialIndex: index)
            pageViewController?.onIndexChanged = { [weak self] newIndex in
                self?.index = newIndex
            }
        }
    }
}
