//
//  ChatListViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

class ConversationsViewController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "conversationCell"
    var conversations = [Conversation]()
    
    private func fetchConversations() {
        ChatService.fetchConversations { conversations in
            self.conversations = conversations
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chats"
        collectionView.register(ConversationCell.self, forCellWithReuseIdentifier: cellId)
        fetchConversations()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let chatVC = ChatViewController(user: conversations[indexPath.item].user)
        chatVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return conversations.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ConversationCell
        cell.conversation = conversations[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.bounds.width, height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}
