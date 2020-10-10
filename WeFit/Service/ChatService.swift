//
//  ChatService.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Firebase

struct ChatService {
    
    static func fetchAllUsers(completion: @escaping([User]) -> Void){
        
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            var users = [User]()
            
            snapshot?.documents.forEach({ (document) in
                let dictionary  = document.data()
                let user = User(dictionary)
                users.append(user)
            })
            
            completion(users)
        }
    }
    
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void){
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary)
            completion(user)
        }
    }
    
    static func fetchMessages(forUser user: User, completion: @escaping([Message]) -> Void){
        var messages = [Message]()
//        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        let query = COLLECTION_MESSAGES.document(String(id)).collection(String(user.id)).order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ (change) in
                if change.type == .added {
                    let dictionary  = change.document.data()
                    messages.append(Message(dictionary))
                    completion(messages)
                }
            })
        }
    }
    
    static func fetchConversations(completion: @escaping([Conversation]) -> Void){
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        let query = COLLECTION_MESSAGES.document(String(id)).collection("recent-message").order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            var conversations = [Conversation]()
            snapshot?.documents.forEach({ document in
                let dictionary = document.data()
                let message = Message(dictionary)
                
                self.fetchUser(withUid: String(message.toId)) { (user) in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    completion(conversations)
                }
            })
        }
    }
    
    static func uploadMessage(_ message: String, to user: User, type: Message.MessageType = .text, exercise: Exercise = .pushup, completion: ((Error?) -> Void)?) {
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        let data = ["text": message,
                    "fromId": String(id),
                    "toId": String(user.id),
                    "messageType": type.rawValue,
                    "exercise": exercise.rawValue,
                    "timestamp": Timestamp(date: Date())] as [String: Any]
        
        COLLECTION_MESSAGES.document(String(id)).collection(String(user.id)).addDocument(data: data) { _ in
            COLLECTION_MESSAGES.document(String(user.id)).collection(String(id)).addDocument(data: data, completion: completion)
            
            COLLECTION_MESSAGES.document(String(id)).collection("recent-message").document(String(user.id)).setData(data)
            
            COLLECTION_MESSAGES.document(String(user.id)).collection("recent-message").document(String(id)).setData(data)
        }
    }
}
