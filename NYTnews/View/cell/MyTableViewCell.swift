//
//  MyTableViewCell.swift
//  NYTnews
//
//  Created by abdul khan on 30/06/19.
//  Copyright © 2019 abdul khan. All rights reserved.
//

import UIKit
import AlamofireImage

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    private var article : Article?
    private var viewModel : NewsViewModel?
    private var articleImgUrl : String?

    @IBOutlet weak var articleImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.viewModel = NewsViewModel()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
    func setArticleImgUrl(url: String) {
        self.articleImgUrl = url
    }
    
    func getArticleImgUrl() -> String {
        if let url = self.articleImgUrl {
            return url
        }
        return ""
    }
    
    
    func setImage(ind : Int) -> Void {
        viewModel?.fetchImage(withUrlStr: self.getArticleImgUrl(), completion: { img in
            if let img = img {
                if(self.tag == ind){
                    self.articleImgView.image = img
                }
            }
        })
    }
    
    func configure(withArticle article: Article, ind: Int) {
        self.article = article
        self.articleImgView.image = UIImage(imageLiteralResourceName: "img-placeholder")
        if let multimedia = article.multimedia {
            let count = multimedia.count
            if count > 0 {
                if let imgUrl = multimedia[ multimedia.count - 1 ].url {
                    setArticleImgUrl(url: imgUrl)
                    setImage(ind : ind)
                }
            }
        }else {
            self.imageView?.isHidden = true
            
        }
        titleLabel.text = article.title
        abstractLabel.text = article.abstract
        byLineLabel.text = article.byline
    
    }
    
}
