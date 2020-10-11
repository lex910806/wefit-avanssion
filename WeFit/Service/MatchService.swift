//
//  MatchService.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Firebase
import Alamofire
import SwiftyJSON

struct MatchService {
    struct Statistics: Decodable {
        var statistics: [Record]
    }
    static func queryResultList(token: String, completion: @escaping (Statistics?, Error?) -> Void) {
        guard let id = Jwt.decode(token)["id"] as? Int else { return }
        let url = URL(string: "http://20.188.108.21/api/v1/match/\(id)")!
        
        AF.request(url,
                   headers: HTTPHeaders([HTTPHeader.init(name: "access-token", value: token)]))
            .responseDecodable (of: Statistics.self) { res in
                
                switch res.result {
                case .success(let value):
                    completion(value, nil)
                case .failure(let err)
                }completion(nil, err)
            }
            
    }
    static func fetchAllUsers(completion: @escaping([User]) -> Void){
        COLLECTION_MATCH.getDocuments { (snapshot, error) in
            var users = [User]()
            
            snapshot?.documents.forEach({ (document) in
                let dictionary  = document.data()
                let user = User(dictionary)
                users.append(user)
            })
            
            completion(users)
        }
    }
    
    static func fetchMatchs(completion: @escaping([Match]) -> Void){
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        let query = COLLECTION_MATCH.document(String(id)).collection("recent-match").order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            var matches = [Match]()
            snapshot?.documents.forEach({ document in
                
                let dictionary = document.data()
                let match = Match(dictionary)
                matches.append(match)
            })
            completion(matches)
        }
    }
    
    static func increaseValue(myId: String, match: Match, value: Int) {
        if String(match.fromId) == myId {
            COLLECTION_DURINGMATCH.document(match.matchId).updateData(["myValue":value])
        } else {
            COLLECTION_DURINGMATCH.document(match.matchId).updateData(["opponentValue":value])
        }
    }

    static func clearRecentMatch(myId: String, match: Match) {
        COLLECTION_MATCH.document(String(match.toId))
            .collection("recent-match")
            .whereField("matchId", in: [match.matchId])
            .getDocuments { (snapshot, err) in
                snapshot?.documents.forEach { $0.reference.delete() }
            }
        
        COLLECTION_MATCH.document(String(match.fromId))
            .collection("recent-match")
            .whereField("matchId", in: [match.matchId])
            .getDocuments { (snapshot, err) in
                snapshot?.documents.forEach { $0.reference.delete() }
            }
        
    }
    static func matchRoomEnter(myId: String, match: Match, completion: @escaping(Bool, DuringMatch, Error?) -> Void) {
        clearRecentMatch(myId: myId, match: match)
        
        let query = COLLECTION_DURINGMATCH.document(match.matchId)
        query.addSnapshotListener { (snapshot, error) in
            if let dictionary = snapshot?.data() {
                
                let duringMatch = DuringMatch(dictionary)
                
                if duringMatch.myId == myId {
                    COLLECTION_DURINGMATCH.document(match.matchId).updateData(["amIOnline": true])
                    completion(duringMatch.isOpponentOnline,duringMatch, nil)
                    
                } else {
                    COLLECTION_DURINGMATCH.document(match.matchId).updateData(["isOpponentOnline": true])
                    completion(duringMatch.amIOnline,duringMatch, nil)
                }
            }
        }
    }
    
    static func leaveMatchRoom(myId: String, match: Match, completion: @escaping(Error?) -> Void) {
        
        COLLECTION_DURINGMATCH.document(match.matchId).getDocument { (snapshot, error) in
            if let dictionary = snapshot?.data() {
                
                let duringMatch = DuringMatch(dictionary)
                
                if duringMatch.myId == myId {
                    COLLECTION_DURINGMATCH.document(match.matchId).updateData(["amIOnline": false])
                } else {
                    COLLECTION_DURINGMATCH.document(match.matchId).updateData(["isOpponentOnline": false])
                }
            }
        }
    }
    
//    static func createMatch(myId: Int, opponentId: Int) -> String {
//        let uuid = UUID().uuidString
//        
//        let matchData = [
//            "myId": String(myId),
//            "opponentId": String(opponentId),
//        ]
//        
//        COLLECTION_DURINGMATCH.document(uuid).setData(matchData)
//        return uuid
//    }
    
    static func challengeMatch(exercise: Int, name: String, user: User, completion: @escaping(Error?) -> Void) -> String {
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return "" }
        let matchId = UUID().uuidString
        let data = ["exercise": exercise,
                    "fromName": name,
                    "fromId": String(id),
                    "toId": String(user.id),
                    "timestamp": Timestamp(date: Date()),
                    "matchId": matchId] as [String: Any]
        
        COLLECTION_MATCH.document(String(id)).collection(String(user.id)).addDocument(data: data) { _ in
            COLLECTION_MATCH.document(String(user.id)).collection(String(id)).addDocument(data: data, completion: completion)
            
            COLLECTION_MATCH.document(String(id)).collection("recent-match").document(String(user.id)).setData(data)
            
            COLLECTION_MATCH.document(String(user.id)).collection("recent-match").document(String(id)).setData(data)
        }
        let matchData = [
            "myId": String(id),
            "opponentId": String(user.id),
        ]
        COLLECTION_DURINGMATCH.document(matchId).setData(matchData)
//        createMatch(myId: <#T##Int#>, opponentId: <#T##Int#>)
        ChatService.uploadMessage("Challege", to: user, type: .battle, exercise: Exercise(rawValue: exercise) ?? .pushup) { _ in }
        return matchId
    }
}
