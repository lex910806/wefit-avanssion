//
//  MyPageBMICalculatorViewController.swift
//  WeFit
//
//  Created by Florian LUDOT on 10/10/20.
//
import Alamofire
import AloeStackView
import UIKit

class MyPageBMICalculatorViewController: UIViewController {

    let stackView: AloeStackView = {
        let sv = AloeStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.hidesSeparatorsByDefault = true
        sv.rowInset = .zero
        return sv
    }()

    var heightInput: BMIInputView!
    var weightInput: BMIInputView!
    var ageInput: BMIInputView!

    let calculateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Calculate", for: .normal)
        button.backgroundColor = UIColor(hex: "#F61D44")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        button.layer.cornerRadius = 10
        return button
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        self.title = "BMI Calculator"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        setupViews()
    }

    private func setupViews() {
        setupHeightInput()
        setupWeightInput()
        setupAgeInput()
        setupCalculateButton()
    }

    private func setupHeightInput() {
        heightInput = BMIInputView()
        heightInput.configure(label: "Height", measure: "cm")
        stackView.addRow(heightInput)
        stackView.setInset(forRow: heightInput, inset: .init(top: 18, left: 0, bottom: 0, right: 0))
    }

    private func setupWeightInput() {
        weightInput = BMIInputView()
        weightInput.configure(label: "Weight", measure: "kg")
        stackView.addRow(weightInput)
        stackView.setInset(forRow: weightInput, inset: .init(top: 15, left: 0, bottom: 0, right: 0))
    }

    private func setupAgeInput() {
        ageInput = BMIInputView()
        ageInput.configure(label: "Age", measure: "old")
        stackView.addRow(ageInput)
        stackView.setInset(forRow: ageInput, inset: .init(top: 15, left: 0, bottom: 0, right: 0))
    }

    private func setupCalculateButton() {
        NSLayoutConstraint.activate([
            calculateButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        stackView.addRow(calculateButton)
        stackView.setInset(forRow: calculateButton, inset: .init(top: 27, left: 15, bottom: 0, right: 15))
        calculateButton.addTarget(self, action: #selector(onCalculate), for: .touchUpInside)
    }

    @objc
    private func onCalculate() {
        guard
            let heightValue = heightInput.inputTextfield.text,
            !heightValue.isEmpty else {
                showAlertController(title: "Error", message: "Please insert your height")
                return
        }
        guard
            let weightValue = weightInput.inputTextfield.text,
            !weightValue.isEmpty else {
                showAlertController(title: "Error", message: "Please insert your weight")
                return
        }
        guard
            let ageValue = ageInput.inputTextfield.text,
            !ageValue.isEmpty else {
                showAlertController(title: "Error", message: "Please insert your age")
                return
        }

        let urlString = "https://fitness-calculator.p.rapidapi.com/bmi?age=\(ageValue)&height=\(heightValue)&weight=\(weightValue)"
        guard let url = URL(string: urlString) else {
            showAlertController(title: "Error", message: "Invalid URL")
            return
        }

        let headers = HTTPHeaders([
            "x-rapidapi-host": "fitness-calculator.p.rapidapi.com",
            "x-rapidapi-key": "32fa0b2208mshf5f0a458abd503cp1f2368jsnf3a9dca45949"
        ])


        AF.request(url, headers: headers).responseDecodable(of: BMIResult.self) { [weak self] response in
            guard let strongSelf = self else { return }
            switch response.result {
            case .success(let res):
                strongSelf.showAlertController(title: "Detail", message: "BMI: \(res.bmi)\nHealth: \(res.health)\nRange: \(res.range)")
                return
            case .failure(let error):
                strongSelf.showAlertController(title: "Error", message: error.errorDescription ?? "Something went wrong")
                return
            }
        }
    }

    private func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
