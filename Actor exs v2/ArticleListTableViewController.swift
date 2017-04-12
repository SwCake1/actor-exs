//
//  ArticleListTableViewController.swift
//  Actor exs v2
//
//  Created by Vlad on 16.02.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import UIKit
import SideMenuController

final class ArticleListTableViewController: UITableViewController {
    
    var chapter = 0
    var selectedArticles: [Article] = []
    let articlesService = ArticlesService.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureContent()
    }

    // Обновление списка избранного
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if chapter == 5 {
            
            selectedArticles = articlesService.starredArticles()
            tableView.reloadData()
        }
    }
    
    func configureUI() {
        
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = Constants.Color.background
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func configureContent() {
        
        // Загрузка списка разделов для конкретной главы fullArticleList из viewDidLoad()
//        if chapter <= 5 {
            selectedArticles = articlesService.articlesIn(chapter: chapter)
//        }
    }

    // MARK: - Table view functions
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArticles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleListCell", for: indexPath)
        
        cell.backgroundColor = Constants.Color.background
        cell.textLabel?.text = selectedArticles[indexPath.row].articleName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        
        if identifier == "Show Article" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let destinationVC = segue.destination as! ArticleViewController
            destinationVC.index = indexPath.row
            destinationVC.articles = selectedArticles
        }
    }
}
