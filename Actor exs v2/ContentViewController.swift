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
        guard let fileName = Bundle.main.url(forResource: article.fileName, withExtension: nil, subdirectory: nil, localization: nil) else { return }
        let fileExtension = fileName.pathExtension
        
        do {
            var attributedString: NSAttributedString?
            
            switch fileExtension {
            case "rtf":
                attributedString = try NSAttributedString(url: fileName, options: [NSDocumentTypeDocumentAttribute: NSRTFTextDocumentType], documentAttributes: nil)
                
            case "rtfd":
                attributedString = try NSAttributedString(url: fileName, options: [NSDocumentTypeDocumentAttribute: NSRTFDTextDocumentType], documentAttributes: nil)
                
            default:
                break
            }
            textView.attributedText = attributedString
        } catch {
            print(error.localizedDescription)
        }
    }
}
