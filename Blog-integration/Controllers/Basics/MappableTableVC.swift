//
//  MappableTableVC.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 05.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import UIKit
import ObjectMapper

class MappableTableVC: BasicVC, UITableViewDelegate, UITableViewDataSource {
    
    struct CellIdentifier {
        static let userCell = "UserCell"
        static let postCell = "PostCell"
    }

    @IBOutlet weak var tableView: UITableView!
    
    var mappables = [Mappable]()
    var apiManager = APIManager()
    
    // MARK: - Properties to override
    
    var interItemSpacing: CGFloat { return 0.0 }
    var pullToRefreshEnabled: Bool { return false }
    
    // MARK: - Refresh & Loadmore
    
    var refreshControl: UIRefreshControl?
    var loadMoreFooter: LoadMoreFooter?
    var loadMoreStatus = false
    var refreshStatus = false
    var currentPage = 1
    var isLastPage = false
    var pullToRefreshHandler: (()->())?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        if pullToRefreshEnabled {
            setPullToRefresh()
        }
        setFooterView()
    }
    
    // MARK: - Load data
    
    func loadDataFromServer(completionHandler: ((Error?)->())?) {
        // Override this in child classes
    }
    
    // MARK: - Set views
    
    func setTableView() {
        tableView?.registerNibs([CellIdentifier.postCell])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier.userCell)
    }
    
    func setPullToRefresh() {
        
        guard tableView != nil else { return }
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor(colorWithHexValue: 0x808080)
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        tableView.addSubview(refreshControl!)
        
        pullToRefreshHandler = { [unowned self] in
            self.currentPage = 1
            self.isLastPage = false
        }
        
    }
    
    func setFooterView() {
        
        loadMoreFooter = LoadMoreFooter(frame: .zero)
        tableView?.tableFooterView = loadMoreFooter
        tableView?.tableFooterView!.isHidden = true
    }
    
    // MARK: - Refreshing and LoadMore for Table View
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == self.tableView {
            
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
            let deltaOffset = maximumOffset - currentOffset
            
            if deltaOffset <= 0, !isLastPage, !loadMoreStatus, !refreshStatus {
                loadMore()
            }
            
        }
    }
    
    @objc func refresh() {
        
        guard tableView != nil else { return }
        
        if !refreshStatus {
            refreshStatus = true
            
            refreshBegin {
                self.tableView.reloadData()
                self.tableView.tableHeaderView?.layoutSubviews()
                self.refreshStatus = false
                self.refreshControl?.endRefreshing()
                
                if !self.mappables.isEmpty {
                    self.tableView.setContentOffset(CGPoint(x: 0, y: -self.tableView.contentInset.top), animated: true)
                }
            }
        }
    }
    
    func refreshBegin(refreshEnd: @escaping () -> ()) {
        
        if self.pullToRefreshHandler != nil {
            self.pullToRefreshHandler!()
        } else {
            self.currentPage = 1
            self.isLastPage = false
        }
        
        self.loadDataFromServer { _ in
            DispatchQueue.main.async {
                refreshEnd()
            }
        }
    }
    
    func loadMore() {
        
        guard tableView != nil else { return }
        
        if currentPage != 1, !isLastPage {
            if !loadMoreStatus {
                loadMoreStatus = true
                tableView.tableFooterView!.isHidden = false
                
                loadMoreBegin {
                    self.tableView.reloadData()
                    self.tableView.tableHeaderView?.layoutSubviews()
                    self.loadMoreStatus = false
                    self.tableView.tableFooterView!.isHidden = true
                }
            }
        }
    }
    
    func loadMoreBegin(loadMoreEnd: @escaping () -> ()) {
        print("loadmore")
        
        self.loadDataFromServer { _ in
            DispatchQueue.main.async {
                loadMoreEnd()
            }
        }
    }
    
    // MARK: - TableView DataSource
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return mappables.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let user = mappables[indexPath.section] as? ProfileModel {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.userCell) ?? UITableViewCell(style: .default, reuseIdentifier: CellIdentifier.userCell)
            
            cell.textLabel?.text = user.nickname
            
            return cell
        } else if let post = mappables[indexPath.section] as? PostModel {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.postCell, for: indexPath) as! PostCell
            
            cell.post = post
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if let post = mappables[indexPath.section] as? PostModel {
            return PostCell.height(for: post)
        }
        
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return interItemSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: interItemSpacing))
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

    }
    
}
