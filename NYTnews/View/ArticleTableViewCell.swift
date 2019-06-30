//
//  ArticleTableViewCell.swift
//  NYTnews
//
//  Created by abdul khan on 27/06/19.
//  Copyright © 2019 abdul khan. All rights reserved.
//

import UIKit
import AlamofireImage

class ArticleTableViewCell: UITableViewCell {

    private var articleUrl : String?
    private var viewModel : NewsViewModel?
    
    @IBOutlet weak var viewContainer: UIStackView!
    @IBOutlet weak var articleImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewModel = NewsViewModel()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func shareButtonDidPress(_ sender: Any) {
    }
    
    @IBAction func openInBrowserBtnDidPress(_ sender: Any) {
    }
    
    func setArticleUrl(url: String) {
        self.articleUrl = url
    }
    
    func getArticleUrl() -> String {
        if let url = self.articleUrl {
            return url
        }
        return ""
    }
    
    func setImage() -> Void {
        viewModel?.fetchImage(withUrlStr: getArticleUrl(), completion: { img in
            if let img = img {
                DispatchQueue.main.async {
                    self.articleImgView.image = img
                }
            }
        })
    }
    
    func configure(withArticle article: Article) {
        setArticleUrl(url: article.multimedia![article.multimedia!.count - 1].url!)
        setImage()
        titleLabel.text = article.title
        abstractLabel.text = article.abstract
        byLineLabel.text = article.byline
    }
}
