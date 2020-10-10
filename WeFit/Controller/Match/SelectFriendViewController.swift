//
//  SelectFriendViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//

import UIKit

protocol SelectFriendViewControllerDelegate: class {
    func selectedFriend(_ friend: FriendListViewModel)
}

class SelectFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var delegate: SelectFriendViewControllerDelegate?
    let cellId = "FriendSelectionCell"
    let closeBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        return btn
    }()
    
    @objc func closeVC() {
        self.dismiss(animated: true)
    }
    
    var friends = [FriendListViewModel]()
    
    private func fetchFriendList() {
        guard let token = globalToken else { return }
        FriendService.queryMyFriends(token: token) { (pagedRes, err) in
            if let pagedRes = pagedRes {
                self.friends = pagedRes.friends
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendSelectionCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        fetchFriendList()
        
    }
    let label = UILabel(text: "Choose your\nnext opponent", font: .systemFont(ofSize: 28, weight: .semibold), numberOfLines: 2)
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        
        return tv
    }()
    
    @objc func selectHandler(sender: UIButton) {
        guard let friend = selectedFriend else { return }
        delegate?.selectedFriend(friend)
        closeVC()
    }
    
    let nextBtn: UIButton = {
        let btn = UIButton(title: "Next")
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor(130, 130, 130).cgColor
        btn.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        btn.tintColor = .init(130, 130, 130)
        btn.isEnabled = false
        btn.addTarget(self, action: #selector(selectHandler), for: .touchUpInside)
        return btn
    }()
    
    var selectedFriend: FriendListViewModel? {
        didSet {
            if selectedFriend != nil {
                nextBtn.isEnabled = true
                
                nextBtn.layer.borderWidth = 0
                nextBtn.backgroundColor = .init(246, 29, 68)
                nextBtn.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
                nextBtn.tintColor = .white
                
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        let border = UIView()
        border.backgroundColor = .init(224, 224, 224)
        view.addSubview(closeBtn)
        view.addSubview(label)
        view.addSubview(border)
        view.addSubview(tableView)
        view.addSubview(nextBtn)
        
        closeBtn.setDimensions(height: 40, width: 40)
        closeBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                        leading: view.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 0,right: 0))
        
        label.anchor(top: closeBtn.bottomAnchor, leading: closeBtn.leadingAnchor, padding: .init(top: 5, left: 5, bottom: 0, right: 0))
        
        border.anchor(top: label.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,
                      padding: .init(top: 15, left: 0, bottom: 0, right: 0),
                      size: .init(width: 0, height: 1))
        
        tableView.anchor(top: border.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
        
        nextBtn.anchor(top: tableView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,
                       padding: .init(top: 10, left: 16, bottom: 10, right: 16), size: .init(width: 0, height: 60))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let friend = friends[indexPath.item]
        selectedFriend = friend
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendSelectionCell
        cell.friend = friends[indexPath.item]
        return cell
    }
}
