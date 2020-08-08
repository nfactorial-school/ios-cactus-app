//
//  LearnViewController.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/3/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var articles = [Article]()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Learn"
        collectionView.collectionViewLayout = layoutForCollectionView()
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        
        loadInitial()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "article_cell", for: indexPath) as! ArticleCollectionViewCell
        
        let article = articles[indexPath.row]
        cell.configure(with: article)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showArticle", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == articles.count - 2 {
            loadMore()
        }
    }
    
    func layoutForCollectionView() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .estimated(279))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 16
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let articleVC = segue.destination as? ArticleViewController {
            let selectedIndexPath = collectionView.indexPathsForSelectedItems![0]
            let selectedArticle = articles[selectedIndexPath.row]
            articleVC.article = selectedArticle
        }
    }
    
    // MARK: - Loading
    
    func loadInitial() {
        activityIndicator.isHidden = false
        
        loadArticles(offset: 0) { (articles) in
            self.activityIndicator.isHidden = true
            
            guard let articles = articles else {
                return
            }
            
            self.articles = articles
            self.collectionView.reloadData()
        }
    }
    
    @objc func reload() {
        isLoadingMore = false
        loadArticles(offset: 0) { (articles) in
            self.refreshControl.endRefreshing()
            
            guard let articles = articles else {
                return
            }
            
            self.articles = articles
            self.collectionView.reloadData()
            
            self.lastOffset = 0
            self.allArticlesAreLoaded = false
        }
    }
    
    var lastOffset = 0
    var isLoadingMore = false
    var allArticlesAreLoaded = false
    
    func loadMore() {
        if allArticlesAreLoaded || isLoadingMore {
            return
        }

        isLoadingMore = true
        
        let offset = lastOffset + 10
        loadArticles(offset: offset) { (newArticles) in
            self.isLoadingMore = false
            
            guard let newArticles = newArticles else {
                return
            }
            
            self.lastOffset = offset

            if newArticles.isEmpty {
                self.allArticlesAreLoaded = true
                return
            }
            
            let startIndex = self.articles.count
            let endIndex = self.articles.count + newArticles.count - 1
            let indexPathsToAdd: [IndexPath] = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
            
            self.articles.append(contentsOf: newArticles)
            
            self.collectionView.insertItems(at: indexPathsToAdd)
        }
    }
    
    var dataTask: URLSessionDataTask?
    
    func loadArticles(offset: Int, completion: @escaping ([Article]?) -> Void) {
        dataTask?.cancel()
        
        let url = URL(string: "https://ios-cactus-app.herokuapp.com/learn?offset=\(offset)&limit=10")!
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            self.dataTask = nil
            
            if let data = data {
                do {
                    let learnResponse = try JSONDecoder().decode(LearnResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(learnResponse.articles)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        self.showError(error)
                        completion(nil)
                    }
                }
                
                return
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.showError(error)
                }
            }
            
            DispatchQueue.main.async {
                completion(nil)
            }
        }
        
        dataTask?.resume()
    }
    
    func showError(_ error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: false, completion: nil)
    }
}
