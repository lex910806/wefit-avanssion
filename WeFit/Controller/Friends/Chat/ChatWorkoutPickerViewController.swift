//
//  ChatWorkoutPickerViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

protocol ChatWorkoutPickerViewControllerDelegate: class {
    func didSelectWorkout(at exercise: Exercise)
}

class ChatWorkoutPickerViewController: UIViewController {

    weak var delegate: ChatWorkoutPickerViewControllerDelegate?
    let exercise: [Exercise] = [.pushup, .squat, .lunge, .crunch]
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Match"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.dataSource = self
        cv.delegate = self
        cv.backgroundColor = .clear
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        view.addSubview(headerLabel)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 11),
            headerLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14),
            headerLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -11),
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: 120),
        ])

        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
        ])
    }
}

extension ChatWorkoutPickerViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercise.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let iv = UIImageView(image: exercise[indexPath.item].smallImage())
        cell.contentView.addSubview(iv)
        iv.fillSuperview()
        cell.contentView.layer.cornerRadius = 12
        cell.clipsToBounds = true
        return cell
    }
}

extension ChatWorkoutPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectWorkout(at: exercise[indexPath.item])
    }
}

extension ChatWorkoutPickerViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 100)
    }
}
