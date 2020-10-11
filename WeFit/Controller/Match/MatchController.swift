//
//  MatchController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

class MatchController: BaseListController, UICollectionViewDelegateFlowLayout, MatchCellDelegate {
    
    func matchCellDidTap(accept match: Match) {
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        MatchService.matchRoomEnter(myId: String(id), match: match) { (canStart, duringMatch, err) in
            if canStart {
                guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
                ChatService.fetchUser(withUid: String(id)) { (my) in
                    ChatService.fetchUser(withUid: String(match.fromId)) { opponent in
                        let setupVC = SetupMatchViewController(me: my)
                        setupVC.opponent = FriendListViewModel(id: opponent.id, email: opponent.email, nickName: opponent.nickName, avatar_url: opponent.avatar)
                        setupVC.modalPresentationStyle = .fullScreen
                        setupVC.modalTransitionStyle = .crossDissolve
                        setupVC.match = match
                        setupVC.setupLoadingState()
                        setupVC.setupCounterState()
                        self.present(setupVC, animated: true)
                    }
                }
            }
        }
    }
    
    
    let recordCellId = "recordCellId"
    let matchCellId = "matchCellId"
    let headerId = "headerId"
    
    var waitList = [Match]()
    var records = [Record]()
    
    lazy var startBtn: UIButton = {
        let btn = UIButton(type: .system)
        
        btn.backgroundColor = .init(246, 29, 68)
        btn.setTitle("Start Match", for: .normal)
        btn.layer.cornerRadius = 23
        btn.titleLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        btn.setTitleColor(.white, for: .normal)
        
        collectionView.addSubview(btn)
        btn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        btn.centerXInSuperview()
        btn.constrainWidth(constant: 154)
        btn.constrainHeight(constant: 46)
        return btn
    }()
    
    @objc func logout() {
        let prefs = UserDefaults.standard
        prefs.setValue(nil, forKey: "accessToken")
        globalToken = nil
        let vc = LoginViewController()
        presentViewControllerAsRootVC(with: vc)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBtn = UIBarButtonItem(image: UIImage(named: "bell"), style: .plain, target: self, action: #selector(logout))
        self.navigationItem.rightBarButtonItem = rightBtn
        collectionView.register(RecordCell.self, forCellWithReuseIdentifier: recordCellId)
        collectionView.register(MatchCell.self, forCellWithReuseIdentifier: matchCellId)
        collectionView.register(MatchHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        startBtn.addTarget(self, action: #selector(startMatch), for: .touchUpInside)
        startBtn.addShadow(x:0, y: 3)
//        let testUser = User(id: 2, email: "lex910806@gmail.com", name: "이지훈", nickName: "지훈짱", weight: 75, height: 180, age: 30, stats: 160, avatar_url: "https://avatars1.githubusercontent.com/u/20150653?s=460&u=54925c33d5efb357536061f72d72b71c6a2d83b2&v=4")
//        let testOpponent = Record.Opponent(id: 1, avatar_url: "https://avatars3.githubusercontent.com/u/9365651?s=460&u=96ab6a3065754ac1744970df333b02305114f79a&v=4", value: 40)
//        let testRecord = Record(me: testUser, winnerId: 2, date: Date(), value: 16000, kind: 0, opponent: testOpponent)
//        
////        waitList.append(Match())
//        records.append(testRecord)
        fetchMatches()
    }
    
    func fetchMatches() {
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        MatchService.fetchMatchs { matches in
            self.waitList = matches.filter { $0.fromId != id }
            self.collectionView.reloadData()
        }
    }
    
    @objc func startMatch(sender: UIButton) {
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        ChatService.fetchUser(withUid: String(id)) { (my) in
            let setupVC = SetupMatchViewController(me: my)
            setupVC.modalPresentationStyle = .fullScreen
            setupVC.modalTransitionStyle = .crossDissolve
            
            self.present(setupVC, animated: true)
        }
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        if waitList.count > 0 {
            return 2
        }
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if waitList.count > 0 && section == 0 {
            return waitList.count
        }
        return records.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if waitList.count > 0 && indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: matchCellId, for: indexPath) as! MatchCell
            cell.delegate = self
            cell.match = waitList[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recordCellId, for: indexPath) as! RecordCell
        cell.record = records[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if waitList.count > 0 && indexPath.section == 0 {
            return .init(width: collectionView.frame.width - 32, height: 124)
        }
        return .init(width: collectionView.frame.width - 32, height: 89)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .zero
        }
        return .init(top: 0, left: 0, bottom: 80, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
}



//MARK: Headers
extension MatchController {
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! MatchHeader
        
        if waitList.count > 0 && indexPath.section == 0 {
            header.title.text = "Match Waitlist"
            header.segmentedTitle = []
        } else {
            header.title.text = "Match Records"
            header.segmentedTitle = ["All", "Pushup", "Squat","Lunge", "Crunch"]
        }
        
        return header
    }
    
    // 3
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if waitList.count > 0 && section == 0 {
            return .init(width: view.frame.width, height: 60)
        }
        return .init(width: view.frame.width, height: 106)
    }
}
