//
//  SideMenuTableViewController.swift
//  Actor exs v2
//
//  Created by Vlad on 21.02.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import UIKit

final class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var sideMenuTable: UITableView!
    
    // MARK: - Предварительная настройка бокового меню
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenuTable.tableFooterView = UIView(frame: CGRect.zero)
        sideMenuTable.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Paper Apple"))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return 1
        case 1: return 5
        case 2: return 1
        default: return 0
        }
    }
    
    // MARK: - Выбор пунктов бокового меню
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let csmc = sideMenuController as? CustomSideMenuController
        
        // Приветствие
        if indexPath.section == 0 {
            csmc?.chapter = 0 // indexPath.section + indexPath.row
            csmc?.performSegue(withIdentifier: "Show Wellcome", sender: nil)
        }
        
        // Разделы книги
        if indexPath.section == 1 {
            csmc?.chapter = indexPath.section + indexPath.row
            csmc?.chapterName = (sideMenuTable.cellForRow(at: indexPath)?.textLabel?.text)!
            csmc?.performSegue(withIdentifier: "Show article list", sender: nil)
        }
        
        // Запись на курс
        if indexPath.section == 2 && indexPath.row == 0 {
            csmc?.performSegue(withIdentifier: "Show registration", sender: nil)
        }
        
    }
}
