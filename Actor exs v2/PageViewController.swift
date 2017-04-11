//
//  PageViewController.swift
//  Actor exs v2
//
//  Created by Vlad on 09.03.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import UIKit

final class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var onIndexChanged: ((Int?) -> Void)?
    
    private var index: Int?
    private var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        guard let index = index else { return }
        guard let firstVC = contentController(for: index) else { return }
        setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
    }
    
    func configureWith(articles: [Article]?, initialIndex: Int?) {
        
        self.articles = articles
        self.index = initialIndex
    }

    private func contentController(for index: Int) -> ContentViewController? {
        guard let articles = articles else { return nil }
        guard index >= 0 && index < articles.count else { return nil }
        
        let contentVC = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController
        contentVC?.article = articles[index]
        contentVC?.index = index
        return contentVC
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = index else { return nil }
        
        return contentController(for: index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = index else { return nil }

        return contentController(for: index + 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentViewController = viewControllers?.first as? ContentViewController else { return }
        index = currentViewController.index
        onIndexChanged?(currentViewController.index)
    }
}

