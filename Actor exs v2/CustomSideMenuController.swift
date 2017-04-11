//
//  CustomSideMenuController.swift
//  Actor exs v2
//
//  Created by Vlad on 20.02.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import Foundation
import SideMenuController

final class CustomSideMenuController: SideMenuController {
    
    var chapter = 0
    var chapterName = ""
    var initialLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lastViewedChapter = UserDefaults.standard.integer(forKey: "LastViewedChapter")
        if lastViewedChapter == 0 {
            performSegue(withIdentifier: "Show Wellcome", sender: nil)
        } else {
            chapter = lastViewedChapter
            performSegue(withIdentifier: "Show article list", sender: nil)
        }
        
        performSegue(withIdentifier: "Load side menu", sender: nil)
        initialLoad = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "List")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 235
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
        SideMenuController.preferences.animating.transitionAnimator = FadeAnimator.self
        
        super.init(coder: aDecoder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        switch identifier {
        case "Show article list":
            
            let destinationVC = segue.destination as! UINavigationController
            let ArticleListTableVC = destinationVC.visibleViewController as! ArticleListTableViewController
            ArticleListTableVC.chapter = chapter
            ArticleListTableVC.navigationItem.title = chapterName
            
            if initialLoad {
                
                let lastRow = UserDefaults.standard.integer(forKey: "LastViewedIndex")
                let indexPath = IndexPath(row: lastRow, section: 0)
            
                
                ArticleListTableVC.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
                ArticleListTableVC.performSegue(withIdentifier: "Show Article", sender: ArticleListTableVC)
                ArticleListTableVC.tableView.deselectRow(at: indexPath, animated: false)
            }
            
        case "Show Wellcome":
            
            let articlesService = ArticlesService.sharedInstance
            let destinationVC = segue.destination as! UINavigationController
            let articleVC = destinationVC.visibleViewController as! ArticleViewController
            
            guard let welcomeArticle = articlesService.welcomeArticle() else { return }
            articleVC.articles = [welcomeArticle]
            articleVC.index = 0
        default: break
        }
    }
}
