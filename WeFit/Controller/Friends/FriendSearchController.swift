//
//  FriendSearchController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import UIKit


class FriendSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    fileprivate let cellId = "id1234"
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid = String(searchResults[indexPath.item].id)
        guard let token = globalToken else { return }
        ChatService.fetchUser(withUid: uid) { (user) in
            let sheet = UIAlertController(title: "Nickname: \(user.nickName)", message: "Would you like to register as a friend?", preferredStyle: .actionSheet)
            
            sheet.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
                FriendService.insertFriend(token: token, id: uid) { (user, error) in
                    if let err = error {
                        self.toast("Friend registration failure")
                    }
                }
            }))
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(sheet, animated: true)
            
        }
//        let appDetailController = AppDetailController(appId: appId)
//        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
        
//        fetchITunesApps()
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        // introduce some delay before performing the search
        // throttling the search
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            SearchUser.find(query: searchText) { (res, err) in
                if let err = err {
                    print("Failed to fetch apps:", err)
                    return
                }
                
                self.searchResults = res?.friends ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        })
    }
    
    fileprivate var searchResults = [UserSearchResult]()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 52)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = searchResults.count != 0
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.result = searchResults[indexPath.item]
        return cell
    }
    
}
