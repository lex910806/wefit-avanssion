//
//  FriendsContoller.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

class FriendListViewController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "friendCell"
    var friends = [FriendListViewModel]()
    
    //TODO: fetch friend list
    private func fetchFriendList() {
        guard let token = globalToken else { return }
        FriendService.queryMyFriends(token: token) { (pagedRes, err) in
            if let pagedRes = pagedRes {
                self.friends = pagedRes.friends
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFriendList()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Friends"
        collectionView.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        vc.addAction(UIAlertAction(title: "Profile", style: .default, handler: { _ in
            //TODO: Show friends profile
        }))
        vc.addAction(UIAlertAction(title: "Chat", style: .default, handler: { _ in
            let id = self.friends[indexPath.item].id
            guard let token = globalToken else { return }
            FriendService.queryMyFriend(token: token, id: String(id)) { (user, err) in
                if let user = user {
                    DispatchQueue.main.async {
                        let chatVC = ChatViewController(user: User(usr: user))
                        chatVC.hidesBottomBarWhenPushed = true
                        self.navigationController?.pushViewController(chatVC, animated: true)
                    }
                }
            }
            
        }))
        vc.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(vc, animated: true)
//        let chatVC = ChatViewController(user: friends[indexPath.item])
//        self.navigationController?.pushViewController(chatVC, animated: true)
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FriendCell
        cell.friend = friends[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}
