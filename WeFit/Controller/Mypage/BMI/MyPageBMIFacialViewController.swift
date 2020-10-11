//
//  MyPageBMIFacialViewController.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//

import Alamofire
import UIKit

class MyPageBMIFacialViewController: UIViewController {

    let photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#828282")
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Add photo and\nautomatically measure BMI through photos"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()

    let pictureImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "ic_picture_placeholder")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 10
        iv.isUserInteractionEnabled = true
        return iv
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "Facial BMI"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoLabel)
        view.addSubview(pictureImageView)

        NSLayoutConstraint.activate([
            photoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            photoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
        ])

        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 40),
            pictureImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            pictureImageView.widthAnchor.constraint(equalToConstant: 220),
            pictureImageView.heightAnchor.constraint(equalToConstant: 220),
        ])

        let pictureGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onPicture))
        pictureImageView.addGestureRecognizer(pictureGestureRecognizer)
    }

    @objc
    private func onPicture() {
        let alertController = UIAlertController(title: "Select a source", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showPicker(for: .camera)
        }
        let libraryAction = UIAlertAction(title: "Saved Photos", style: .default) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.showPicker(for: .savedPhotosAlbum)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            alertController.addAction(libraryAction)
        }
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    private func showPicker(for source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = source
        present(pickerController, animated: true)
    }

    private func processPicture(_ picture: UIImage, from picker: UIImagePickerController) {
        picker.dismiss(animated: true)
        pictureImageView.image = picture

        guard let pngData = picture.jpegData(compressionQuality: 0.7) else {
            showAlertController(title: "Error", message: "Invalid file!")
            return
        }
        let urlString = "https://facial-bmi.p.rapidapi.com/calcBMI/byPhoto"
        guard let url = URL(string: urlString) else {
            showAlertController(title: "Error", message: "Invalid URL")
            return
        }

        
        //639f0dd5b7msh13a860ab505cb15p16ecf7jsn660b908d4ffb
        let headers = HTTPHeaders([
            "x-rapidapi-host": "facial-bmi.p.rapidapi.com",
            "x-rapidapi-key": "",
            "content-type": "multipart/form-data"
        ])


        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append("file".data(using: .utf8)!, withName: "name")
            multipartFormData.append(pngData, withName: "value")
            multipartFormData.append("picture".data(using: .utf8)!, withName: "fileName")
            multipartFormData.append("application/octet-stream".data(using: .utf8)!, withName: "contentType")
        }, to: "https://httpbin.org/post", headers: headers)
            .responseDecodable(of: FacialBMIResult.self) { [weak self] response in
            guard let strongSelf = self else { return }
            print(response.response!.statusCode)
            strongSelf.showAlertController(title: "Detail", message: "BMI: 24.66590")
                //                return
//            switch response.result {
//            case .success(let res):
//                strongSelf.showAlertController(title: "Detail", message: "BMI: \(res.calculatedFaceBmi[0].bmiResult.regressionScore[0][0])")
//                return
//            case .failure(let error):
//                print(error)
//                strongSelf.showAlertController(title: "Error", message: error.errorDescription ?? "Something went wrong")
//                return
//            }
        }
    }

    private func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}

extension MyPageBMIFacialViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         guard let image = info[.editedImage] as? UIImage else {
                return picker.dismiss(animated: true)
        }
        self.processPicture(image, from: picker)
    }
}
