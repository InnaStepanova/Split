//
//  ViewController.swift
//  Split
//
//  Created by Лаванда on 22.02.2023.
//

import UIKit

class MaineViewController: UIViewController {
    
    private var currentTip = 0
    private var splitBrain = SplitCalculatorBrain()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.topLabel
        label.textColor = .gray
        label.font = UIFont(name: "Helvetica", size: 30)
        return label
    }()
    
    private lazy var billTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = Resources.Strings.textPlaceholder
        textField.keyboardType = .decimalPad
        textField.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        textField.font = UIFont(name: "Helvetica-Bold", size: 30)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.tipLabel
        label.textColor = .gray
        label.font = UIFont(name: "Helvetica", size: 30)
        return label
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 50
        return stack
    }()
    
    private lazy var chooseSplitLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.chooseSplit
        label.textColor = .gray
        label.font = UIFont(name: "Helvetica", size: 30)
        return label
    }()
    
    private lazy var qtySplitLabel: UILabel = {
        let label = UILabel()
        label.text = String(format: "%.0f", stepper.value)
        label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        return label
    }()
    
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 2
        stepper.minimumValue = 1
        stepper.maximumValue = 100
        stepper.addTarget(self, action: #selector(clickStepper), for: .touchUpInside)
        return stepper
    }()
    
    private lazy var calculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Resources.Strings.calculateButton, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
        button.addTarget(self, action: #selector(calculateButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        addViews()
        addLayout()
    }
    
    private func getButtonsStack() {
        for percent in [0, 10, 20] {
            let button = UIButton(type: .system)
            button.setTitle(" \(percent)% ", for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            button.addTarget(self, action: #selector(tipButtonPressed), for: .touchUpInside)
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
            button.tag = percent
            button.layer.cornerRadius = 5
            buttonsStack.addArrangedSubview(button)
        }
    }
    
    @objc private func tipButtonPressed(_ sender: UIButton) {
        clearBackgroundCelectedButton()
        sender.setTitleColor(.white, for: .normal)
        sender.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        currentTip = sender.tag
    }
    
    @objc private func clickStepper(_ sender: UIStepper) {
        qtySplitLabel.text = Int(sender.value).description
    }
    
    @objc private func calculateButtonPressed() {
        
        guard let billSummString = billTextField.text else {return}
        guard let billSummDouble = Double(billSummString) else {return}
        let split = splitBrain.calculateSplitSumma(qtyPerson: stepper.value, summ: billSummDouble, tip: currentTip)
        
        
        let calculateVC = CalculateViewController()
        calculateVC.split = split
        present(calculateVC, animated: true)
        
    }
    
    private func clearBackgroundCelectedButton() {
        for button in buttonsStack.arrangedSubviews {
            if button.backgroundColor == #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) {
                let button2 = button as! UIButton
                button2.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                button2.setTitleColor(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), for: .normal)
            }
        }
    }
}

private extension MaineViewController {
    func addViews() {
        view.addSubview(topView)
        topView.addSubview(topLabel)
        topView.addSubview(billTextField)
        view.addSubview(tipLabel)
        view.addSubview(buttonsStack)
        view.addSubview(chooseSplitLabel)
        view.addSubview(qtySplitLabel)
        view.addSubview(stepper)
        view.addSubview(calculateButton)
        getButtonsStack()
    }
    
    func addLayout() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        billTextField.translatesAutoresizingMaskIntoConstraints = false
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        chooseSplitLabel.translatesAutoresizingMaskIntoConstraints = false
        qtySplitLabel.translatesAutoresizingMaskIntoConstraints = false
        stepper.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
        topView.topAnchor.constraint(equalTo: view.topAnchor),
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        topView.bottomAnchor.constraint(equalTo: billTextField.bottomAnchor, constant: 30),
        
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        billTextField.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30),
        billTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        billTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        billTextField.heightAnchor.constraint(equalToConstant: 50),
        
        tipLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30),
        tipLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        buttonsStack.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: 20),
        buttonsStack.leadingAnchor.constraint(equalTo: tipLabel.leadingAnchor),
        buttonsStack.trailingAnchor.constraint(equalTo: tipLabel.trailingAnchor),
        buttonsStack.heightAnchor.constraint(equalToConstant: 40),
        
        chooseSplitLabel.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 30),
        chooseSplitLabel.leadingAnchor.constraint(equalTo: tipLabel.leadingAnchor),
        chooseSplitLabel.trailingAnchor.constraint(equalTo: tipLabel.trailingAnchor),
        
        qtySplitLabel.topAnchor.constraint(equalTo: chooseSplitLabel.bottomAnchor, constant: 20),
        qtySplitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
        
        stepper.centerYAnchor.constraint(equalTo: qtySplitLabel.centerYAnchor),
        stepper.leadingAnchor.constraint(equalTo: qtySplitLabel.trailingAnchor, constant: 20),
        
        calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        calculateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        calculateButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
