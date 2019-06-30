//
//  ViewController.swift
//  NYTnews
//
//  Created by abdul khan on 27/06/19.
//  Copyright © 2019 abdul khan. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController {
   
    private let cellIdentifier = "cell"
    private var viewModelObj: NewsViewModel!
    private let refreshControl = UIRefreshControl()
    private var isAlertVisible : Bool = false
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.setBorderWidth(0.5)
        SVProgressHUD.setForegroundColor(.orange)
        self.viewModelObj = NewsViewModel()
        
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        tableView.addSubview(refreshControl)
        let nib = UINib(nibName: "MyTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 600
        self.fetchData()
    }
    
    @objc func refreshTableView(refreshControl: UIRefreshControl) {
        fetchData()
        refreshControl.endRefreshing()
    }
    
    func fetchData() -> Void {
        self.showLoader(withMsg: "Fetching articles")
        viewModelObj.fetchArticles(completion: { isData in
            if (isData){
                self.hideLoader()
                self.showAlert(withTitle: "Done", withMsg: "article fetched successfully", isErr: false)
                self.tableView.reloadData()
            }else{
                self.hideLoader()
                self.showAlert(withTitle: "Network error!", withMsg: "Unable to fetch articles, Please try again.", isErr: true)
            }
        })
    }
    
    func showAlert(withTitle title : String, withMsg msg: String, isErr: Bool) -> Void {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) -> Void in
            self.isAlertVisible = false
        })
        alert.addAction(alertAction)
        if isErr {
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (UIAlertAction) -> Void in
                self.isAlertVisible = false
                self.fetchData()
            })
            alert.addAction(retryAction)
        }
        isAlertVisible = true
        present(alert, animated: true)
    }
    
    
    /// If there is any error show it to the user
    /// - Returns: Void
    /// - Parameter msg: String -> message to show to user
    
    func showLoader(withMsg msg : String) {
        if (!SVProgressHUD.isVisible()){
            SVProgressHUD.show(withStatus: "\(msg)")
        }
    }
    
    func showLoader() -> Void {
        if (!SVProgressHUD.isVisible()){
            SVProgressHUD.show()
        }
    }
    
    func hideLoader() -> Void {
        if (SVProgressHUD.isVisible()){
            SVProgressHUD.dismiss()
        }
    }
    
    
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelObj.getArticleCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MyTableViewCell
        cell.tag = indexPath.row
        let article = viewModelObj.getArticles()[indexPath.row]
        cell.configure(withArticle: article, ind: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let readMoreAction = UIContextualAction(style: .normal, title:  "Open in safari", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let article = self.viewModelObj.getArticles()[indexPath.row]
            UIApplication.shared.open(URL(string: (article.url!))!)
            success(true)
        })
        readMoreAction.image = UIImage(named: "external-link")
        readMoreAction.backgroundColor = .clear
        
        return UISwipeActionsConfiguration(actions: [readMoreAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let readMoreAction = UIContextualAction(style: .normal, title:  "Share via", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let article = self.viewModelObj.getArticles()[indexPath.row]
            let url = URL(string: (article.url!))!
            
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
            self.present(vc, animated: true)
            success(true)
        })
        readMoreAction.image = UIImage(named: "share-icon")
        readMoreAction.backgroundColor = .clear
        
        return UISwipeActionsConfiguration(actions: [readMoreAction])
    }
    
    
}
