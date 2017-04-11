//
//  ContentViewController.swift
//  Actor exs v2
//
//  Created by Vlad on 09.03.17.
//  Copyright © 2017 Владислав Самохин. All rights reserved.
//

import UIKit

final class ContentViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var article: Article?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextView()
        setArticleText()
    }
    
    private func configureTextView() {
        
        textView.backgroundColor = Constants.Color.background
        textView.isEditable = false
    }
    
    private func setArticleText() {
        
        guard let article = article else { return }
        guard let rtf = Bundle.main.url(forResource: article.fileName, withExtension: "rtf", subdirectory: nil, localization: nil) else { return }
        
        do {
            let attributedString = try NSAttributedString(url: rtf, options: [NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType], documentAttributes: nil)
            textView.attributedText = attributedString
        } catch {
            print(error.localizedDescription)
        }
    }
}
