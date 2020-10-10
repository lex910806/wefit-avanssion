//
//  ChatViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//
import UIKit

class ChatViewController: BaseListController, UICollectionViewDelegateFlowLayout {

    var customInputViewBottomConstraint: NSLayoutConstraint!

    private lazy var chatWorkoutPickerController: ChatWorkoutPickerViewController = {
        let vc = ChatWorkoutPickerViewController()
        vc.delegate = self
        return vc
    }()
    
    private lazy var customInputView: CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.delegate = self
        return iv
    }()
    
    let cellId = "messageCell"
    let battleCell = "battleCell"
    private let user: User
    private var messages = [Message]()
    var fromCurrentUser = false
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    init(user: User){
        self.user = user
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = user.nickName
        startManagingKeyboard()
        view.addSubview(customInputView)
        addchatWorkoutPickerController()
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: "ChallengeCell")
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive

        customInputViewBottomConstraint = customInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        NSLayoutConstraint.activate([
            customInputViewBottomConstraint,
            customInputView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            customInputView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            customInputView.heightAnchor.constraint(equalToConstant: 50),
        ])
        customInputView.addActions()

        fetchMessages()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopManagingKeyboard()
    }

    private func addchatWorkoutPickerController() {
        addChild(chatWorkoutPickerController)
        chatWorkoutPickerController.willMove(toParent: self)
        chatWorkoutPickerController.view.translatesAutoresizingMaskIntoConstraints = false
        chatWorkoutPickerController.view.isHidden = true
        view.addSubview(chatWorkoutPickerController.view)
        NSLayoutConstraint.activate([
            chatWorkoutPickerController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            chatWorkoutPickerController.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            chatWorkoutPickerController.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
        chatWorkoutPickerController.didMove(toParent: self)
    }

    private func showWorkoutPicker() {
        guard chatWorkoutPickerController.view.isHidden else {
            hideWorkoutPicker(true)
            return
        }
        customInputView.renounceFocus()
        chatWorkoutPickerController.view.isHidden = false
        customInputViewBottomConstraint.constant = -CHAT_WORKOUT_PICKER_HEIGHT
        UIView.animate(
            withDuration: 0.25,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                self.view.layoutIfNeeded()
        })
    }

    private func hideWorkoutPicker(_ forced: Bool = false) {
        chatWorkoutPickerController.view.isHidden = true
        if forced {
            customInputViewBottomConstraint.constant = -40
            UIView.animate(
                withDuration: 0.25,
                delay: 0,
                options: .curveEaseOut,
                animations: {
                    self.view.layoutIfNeeded()
            })
        }
    }
    
    func fetchMessages(){
        ChatService.fetchMessages(forUser: user) { (messages) in
            self.messages = messages
            self.collectionView.reloadData()
            self.collectionView.scrollToItem(at: [0, self.messages.count - 1], at: .bottom, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if messages[indexPath.item].messageType == .battle {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChallengeCell", for: indexPath) as! ChallengeCell
            cell.message = messages[indexPath.row]
            cell.message?.user = user
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
            cell.message = messages[indexPath.row]
            cell.message?.user = user
            return cell
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        var estimatedSizeCell: MessageCell
        if messages[indexPath.item].messageType == .battle {
            estimatedSizeCell = ChallengeCell(frame: frame)
        } else {
            estimatedSizeCell = MessageCell(frame: frame)
        }
            
        estimatedSizeCell.message = messages[indexPath.row]
        estimatedSizeCell.layoutIfNeeded()
        
        let targetSize = CGSize(width: view.frame.width, height: 1000)
        let estimatedSize = estimatedSizeCell.systemLayoutSizeFitting(targetSize)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}


extension ChatViewController: CustomInputAccessoryViewDelegate {
    
    func actionDidSelected(_ inputView: CustomInputAccessoryView) {
        showWorkoutPicker()
    }
    
    func inputView(_ inputView: CustomInputAccessoryView, wantsToSend message: String) {
         
        ChatService.uploadMessage(message, to: user) { (error) in
            if let error = error {
                print("DEBUG: Failed to upload message with error \(error.localizedDescription)")
                return
            }
            
            inputView.clearMessageText()
        }
    }
}

extension ChatViewController {

    func startManagingKeyboard() {
        _ = NotificationCenter
            .default
            .addObserver(forName: NSNotification.Name(UIResponder.keyboardWillShowNotification.rawValue),
                         object: nil,
                         queue: nil) { [weak self] notification in
                            guard let strongSelf = self else { return }
                            strongSelf.showKeyboard(show: true, withNotification: notification)
        }
        _ = NotificationCenter
            .default
            .addObserver(forName: NSNotification.Name(UIResponder.keyboardWillHideNotification.rawValue),
                         object: nil,
                         queue: nil) { [weak self] notification in
                            guard let strongSelf = self else { return }
                            strongSelf.showKeyboard(show: false, withNotification: notification)
        }
    }

    func stopManagingKeyboard() {
        NotificationCenter
            .default
            .removeObserver(self,
                            name: NSNotification.Name(UIResponder.keyboardWillShowNotification.rawValue),
                            object: nil)
        NotificationCenter
            .default
            .removeObserver(self,
                            name: NSNotification.Name(UIResponder.keyboardWillHideNotification.rawValue),
                            object: nil)
    }

    func showKeyboard(show: Bool, withNotification notification: Notification) {
        hideWorkoutPicker()
        let userInfo = notification.userInfo!
        let keyboardRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue
        let curve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey]! as AnyObject).uint32Value
        let convertedFrame = self.view.convert(keyboardRect!, from: nil)
        let options = UIView.AnimationOptions(rawValue: UInt(curve!) << 16 | UIView.AnimationOptions.beginFromCurrentState.rawValue)
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey]! as AnyObject).doubleValue

        customInputViewBottomConstraint.constant = show ? -convertedFrame.height : -40
        UIView.animate(
            withDuration: duration!,
            delay: 0,
            options: options,
            animations: {
                self.view.layoutIfNeeded()
        })
    }
}

extension ChatViewController: ChatWorkoutPickerViewControllerDelegate {
    func didSelectWorkout(at exercise: Exercise) {
        guard let token = globalToken, let id = Jwt.decode(token)["id"] as? Int else { return }
        ChatService.fetchUser(withUid: String(id)) { (my) in
            MatchService.challengeMatch(exercise: exercise.rawValue, name: my.nickName, user: self.user) { (err) in
                if let err = err {
                    self.toast("Challenge Err")
                }
            }
        }
    }
}
