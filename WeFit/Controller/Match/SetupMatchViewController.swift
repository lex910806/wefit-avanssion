//
//  SetupMatchViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import UIKit
import Firebase

class SetupMatchViewController: UIViewController {
    let currentUser: User
    var opponent: FriendListViewModel? {
        didSet {
            if let urlStr = opponent?.avatar_url, let url = URL(string: urlStr) {
                let img = try? UIImage(data: Data(contentsOf: url))
                centerCard.iconImage.setImage(img, for: .normal)
            } else {
                centerCard.iconImage.setImage(UIImage(named: "person"), for: .normal)
            }
        }
    }
    var exercise: Exercise = .pushup
    
    lazy var centerCard: SetupMatchView = {
        let v = SetupMatchView(me: currentUser)
        return v
    }()
    let closeBtn = UIButton(type: .system)
    let startMatchBtn = UIButton(title: "Start Match")
    let matchlabel = UILabel(text: "Match", font: .systemFont(ofSize: 28, weight: .semibold))

    // Loading State
    let workoutTag: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.isHidden = true
        button.backgroundColor = .init(23, 193,96)
        button.setDimensions(height: 31, width: 104)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.layer.cornerRadius = 31/2
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        return button
    }()

    let battleBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setDimensions(height: 76, width: 224)
        view.backgroundColor = .init(85, 85, 85)
        view.isHidden = true
        view.layer.cornerRadius = 10
        return view
    }()

    let battleOpponentImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isHidden = true
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.cgColor
        iv.backgroundColor = .lightGray
        return iv
    }()

    let battleVSLabel: UILabel = {
        let label = UILabel(text: "VS", font: UIFont.systemFont(ofSize: 24).boldItalic)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = .white
        
        return label
    }()

    let battleUserImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "person"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isHidden = true
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.borderWidth = 1
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()

    let loadingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 52).boldItalic
        label.textColor = .white
        label.text = "Waiting for opponent.."
        label.isHidden = true
        return label
    }()

    // Counter State
    let opponentNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.isHidden = true
        label.text = "Bill Anderson"
        return label
    }()

    let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 86, weight: .semibold).italic
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    let counterDetailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    // Contest State
    let contestHeaderBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(85, 85, 85)
        view.isHidden = true
        return view
    }()

    let contestOpponentImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isHidden = true
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        return iv
    }()

    let contestOpponentScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .white
        label.isHidden = true
        label.text = "Score"
        return label
    }()

    let contestOpponentScoreCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 36).boldItalic
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    let contestWorkoutTag: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        button.isHidden = true
        button.setDimensions(height: 31, width: 104)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = .init(23, 193, 96)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.layer.cornerRadius = 31/2
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    let contestMyScoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.isHidden = true
        label.text = "My Score"
        return label
    }()

    let workoutCounterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 130, weight: .heavy).italic
        label.textColor = .white
        label.isHidden = true
        return label
    }()

    let giveUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        button.backgroundColor = .init(207, 207, 207)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        button.setDimensions(height: 60, width: 143)
        button.layer.cornerRadius = 60 / 2
        button.setTitle("Give up", for: .normal)
        return button
    }()

    enum State {
        case initial
        case loading
        case counter
        case contest
        case result
    }

    var state: State {
        didSet {
            setupState(state)
        }
    }

    init(me: User) {
        self.state = .initial
        self.currentUser = me
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(51, 51, 51)
        setupState(state)
    }
    
    @objc func closeVC() {
        self.dismiss(animated: true)
    }

    func setupState(_ state: State) {
        switch state {
        case .initial:
            setupInitialState()
        case .loading:
            setupLoadingState()
        case .counter:
            setupCounterState()
        case .contest:
            setupContestState()
        case .result:
            setupResultState()
        }
    }

    private func setupInitialState() {
        //MARK: Close btn
        closeBtn.setDimensions(height: 40, width: 40)
        closeBtn.setImage(UIImage(named: "close"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        closeBtn.tintColor = .white
        view.addSubview(closeBtn)
        closeBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, padding: .init(top:8,left:8,bottom:0,right:0))

        //MARK: Card (center)
        centerCard.backgroundColor = .init(117,117,117)
        centerCard.layer.cornerRadius = 20
        centerCard.delegate = self

        view.addSubview(centerCard)
        centerCard.constrainHeight(constant: 218)
        centerCard.anchor(leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        centerCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true

        //MARK: label
        matchlabel.textColor = .white
        view.addSubview(matchlabel)
        matchlabel.anchor(bottom: centerCard.topAnchor, padding: .init(top: 0, left: 0, bottom: 72, right: 0))
        matchlabel.centerXInSuperview()

        //MARK: start match
        startMatchBtn.backgroundColor = .init(246, 29, 68)
        startMatchBtn.layer.cornerRadius = 10
        startMatchBtn.setTitleColor(.white, for: .normal)
        startMatchBtn.titleLabel?.font = .systemFont(ofSize: 24, weight: .semibold)
        view.addSubview(startMatchBtn)
        startMatchBtn.anchor(top: centerCard.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 82, left: 16, bottom: 0, right: 16))
        startMatchBtn.centerXInSuperview()
        startMatchBtn.constrainHeight(constant: 60)
        startMatchBtn.addTarget(self, action: #selector(onStartMatch), for: .touchUpInside)
    }

    private func setupLoadingState() {
        guard let opponentId = opponent?.id else {
            setupState(.initial)
            return
        }
        
        [closeBtn, centerCard ,matchlabel, startMatchBtn].forEach { $0.isHidden = true }
        [workoutTag, battleBackground, battleVSLabel, battleOpponentImageView, battleUserImageView, loadingLabel].forEach { $0.isHidden = false }
        view.addSubview(loadingLabel)
        view.addSubview(workoutTag)
        view.addSubview(battleBackground)
        view.addSubview(battleVSLabel)
        view.addSubview(battleOpponentImageView)
        view.addSubview(battleUserImageView)
        NSLayoutConstraint.activate([
            loadingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            battleBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            battleBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
        ])
        NSLayoutConstraint.activate([
            battleVSLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            battleVSLabel.centerYAnchor.constraint(equalTo: battleBackground.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            battleOpponentImageView.centerYAnchor.constraint(equalTo: battleBackground.centerYAnchor),
            battleOpponentImageView.rightAnchor.constraint(equalTo: battleVSLabel.leftAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            battleUserImageView.centerYAnchor.constraint(equalTo: battleBackground.centerYAnchor),
            battleUserImageView.leftAnchor.constraint(equalTo: battleVSLabel.rightAnchor, constant: 10),
        ])
        NSLayoutConstraint.activate([
            workoutTag.bottomAnchor.constraint(equalTo: battleBackground.topAnchor, constant: -10),
            workoutTag.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        workoutTag.setTitle(exercise.name(), for: .normal)
        
        
        ChatService.fetchUser(withUid: String(opponentId)) { opponentUser in
            let matchId = MatchService.challengeMatch(exercise: self.exercise.rawValue,
                                        name: self.currentUser.nickName,
                                        user: opponentUser) { _ in }
            
            let data = ["exercise": self.exercise.rawValue,
                        "fromName": self.currentUser.nickName,
                        "fromId": String(self.currentUser.id),
                        "toId": String(opponentId),
                        "timestamp": Timestamp(date: Date()),
                        "matchId": matchId] as [String: Any]
            
            MatchService.matchRoomEnter(myId: String(self.currentUser.id), match: Match(data)) { (canStart, err) in
                if canStart {
                    self.setupState(.counter)
                }
            }
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
//            guard let strongSelf = self else { return }
//            strongSelf.setupState(.counter)
//        }
    }

    private func setupCounterState() {
        [loadingLabel].forEach { $0.isHidden = true }
        [counterLabel, counterDetailLabel].forEach { $0.isHidden = false }
        view.addSubview(counterLabel)
        view.addSubview(counterDetailLabel)
        NSLayoutConstraint.activate([
            counterDetailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterDetailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counterLabel.bottomAnchor.constraint(equalTo: counterDetailLabel.topAnchor, constant: -30),
        ])
        var counter = 5
        counterLabel.text = "\(counter)"
        counterDetailLabel.text = counter != 1 ? "Get Ready" : "Go"

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            counter -= 1
            if counter > 0 {
                strongSelf.counterLabel.text = "\(counter)"
                strongSelf.counterDetailLabel.text = counter != 1 ? "Get Ready" : "Go"
            }

            if counter == 0 {
                timer.invalidate()
                strongSelf.state = .contest
            }
        }
    }

    private func setupContestState() {
        [counterLabel, counterDetailLabel, battleBackground, battleVSLabel, battleUserImageView, workoutTag, battleOpponentImageView].forEach { $0.isHidden = true }
        [workoutCounterLabel, opponentNameLabel, contestHeaderBackground, contestOpponentScoreLabel, contestOpponentScoreCountLabel, contestWorkoutTag, contestOpponentImageView, contestMyScoreLabel, giveUpButton].forEach { $0.isHidden = false }
        view.addSubview(contestHeaderBackground)
        view.addSubview(contestOpponentImageView)
        view.addSubview(opponentNameLabel)
        view.addSubview(contestOpponentScoreLabel)
        view.addSubview(contestOpponentScoreCountLabel)
        view.addSubview(contestWorkoutTag)
        view.addSubview(contestMyScoreLabel)
        view.addSubview(workoutCounterLabel)
        view.addSubview(giveUpButton)
        contestOpponentScoreCountLabel.text = "12"
        contestWorkoutTag.setTitle("Pushup", for: .normal)
        NSLayoutConstraint.activate([
            contestHeaderBackground.topAnchor.constraint(equalTo: view.topAnchor),
            contestHeaderBackground.leftAnchor.constraint(equalTo: view.leftAnchor),
            contestHeaderBackground.rightAnchor.constraint(equalTo: view.rightAnchor),
            contestHeaderBackground.heightAnchor.constraint(equalToConstant: 140),
        ])
        battleOpponentImageView.removeConstraints(battleOpponentImageView.constraints)
        NSLayoutConstraint.activate([
            contestOpponentImageView.bottomAnchor.constraint(equalTo: contestHeaderBackground.bottomAnchor, constant: -16),
            contestOpponentImageView.leftAnchor.constraint(equalTo: contestHeaderBackground.leftAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            opponentNameLabel.centerYAnchor.constraint(equalTo: contestOpponentImageView.centerYAnchor),
            opponentNameLabel.leftAnchor.constraint(equalTo: contestOpponentImageView.rightAnchor, constant: 10),
        ])
        NSLayoutConstraint.activate([
            contestOpponentScoreCountLabel.bottomAnchor.constraint(equalTo: contestHeaderBackground.bottomAnchor, constant: -10),
            contestOpponentScoreCountLabel.rightAnchor.constraint(equalTo: contestHeaderBackground.rightAnchor, constant: -10),
        ])
        NSLayoutConstraint.activate([
            contestOpponentScoreLabel.bottomAnchor.constraint(equalTo: contestOpponentScoreCountLabel.topAnchor, constant: -2),
            contestOpponentScoreLabel.rightAnchor.constraint(equalTo: contestOpponentScoreCountLabel.rightAnchor),
        ])
        NSLayoutConstraint.activate([
            contestWorkoutTag.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contestWorkoutTag.bottomAnchor.constraint(equalTo: contestMyScoreLabel.topAnchor, constant: -22),
        ])
        NSLayoutConstraint.activate([
            contestMyScoreLabel.bottomAnchor.constraint(equalTo: workoutCounterLabel.topAnchor, constant: -25),
            contestMyScoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            workoutCounterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workoutCounterLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            giveUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            giveUpButton.topAnchor.constraint(equalTo: workoutCounterLabel.bottomAnchor, constant: 150),
        ])
        var counter = 0
        workoutCounterLabel.text = "\(counter)"

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            counter += 1
            strongSelf.workoutCounterLabel.text = "\(counter)"

            if counter == 8 {
                timer.invalidate()
                strongSelf.state = .result
            }
        }
    }

    private func setupResultState() {
        [workoutCounterLabel, opponentNameLabel, contestHeaderBackground, contestOpponentScoreLabel, contestOpponentScoreCountLabel, contestWorkoutTag, contestOpponentImageView, contestMyScoreLabel, giveUpButton].forEach { $0.isHidden = true }
        [closeBtn].forEach { $0.isHidden = false }
    }

    @objc
    private func onStartMatch() {
        self.state = .loading
    }
}

extension SetupMatchViewController: SetupMatchViewDelegate {
    func setupMatch(_ view: SetupMatchView, exercise button: UIButton) {
        let transitioningDelegate = BottomSheetTransitioningDelegate(
            contentHeights: [532],
            useSafeAreaInsets: true
        )
        let viewController = BottomSheetViewController()
        viewController.transitioningDelegate = transitioningDelegate
        viewController.modalPresentationStyle = .custom
        viewController.makeExerciseView()
        viewController.exerciseHandler = { exercise in
            button.backgroundColor = exercise.color()
            button.setTitle(exercise.name(), for: .normal)
            viewController.dismiss(animated: false)
            self.exercise = exercise
        }
        present(viewController, animated: true)
    }
    
    func setupMatch(_ view: SetupMatchView, user button: UIButton) {
        let transitioningDelegate = BottomSheetTransitioningDelegate(
            contentHeights: [333]
            ,useSafeAreaInsets: true
        )
        let viewController = BottomSheetViewController()
        viewController.transitioningDelegate = transitioningDelegate
        viewController.modalPresentationStyle = .custom
        viewController.makeOpponentView()
        viewController.opponentHandler = { tag in
            viewController.dismiss(animated: false)
            switch tag {
            case 0:
                let vc = SelectFriendViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.delegate = self
                self.present(vc, animated: true)
                print("friends")
            case 1:
                ChatService.fetchAllUsers { users in
                    let randomId = Int.random(in: 0 ..< users.count)
                    let user = users[randomId]
                    self.opponent = FriendListViewModel(id: user.id, email: user.email, nickName: user.nickName, avatar_url: user.avatar)
                }
                print("random")
            default:
                break
            }
        }
        present(viewController, animated: true)
    }
    
    
}
extension SetupMatchViewController: SelectFriendViewControllerDelegate {
    func selectedFriend(_ friend: FriendListViewModel) {
        self.opponent = friend
    }
}
