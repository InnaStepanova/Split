//
//  CalculateViewController.swift
//  Split
//
//  Created by Лаванда on 23.02.2023.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var split: SplitCalculator!
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return view
    }()
    
    private lazy var totalLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Strings.totalPerPerson
        label.textColor = .gray
        label.font = UIFont(name: "Helvetica", size: 30)
        return label
    }()
    
    private lazy var qtyMoneyLabel: UILabel = {
        let label = UILabel()
        label.text = "55.78"
        label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        return label
    }()
    
    private lazy var detailInformation: UILabel = {
        let label = UILabel()
        label.text = "Split between N people, with 10% tip"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        return label
    }()
    
    private lazy var recalculateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Resources.Strings.recalculateButton, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30)
        button.addTarget(self, action: #selector(recalculateButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        layoutConstreints()
        qtyMoneyLabel.text = String(format: "%.2f", split.summ )
        detailInformation.text = "Split between \(String(format: "%.0f", split.qtyPerson)) people, with \(split.tip)% tip"
    }
    
    @objc private func recalculateButtonPressed() {
        dismiss(animated: true)
    }

}

private extension CalculateViewController {
    func addViews() {
        view.addSubview(topView)
        view.addSubview(totalLabel)
        view.addSubview(qtyMoneyLabel)
        view.addSubview(detailInformation)
        view.addSubview(recalculateButton)
    }
    
    func layoutConstreints() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        qtyMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        detailInformation.translatesAutoresizingMaskIntoConstraints = false
        recalculateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        topView.topAnchor.constraint(equalTo: view.topAnchor),
        topView.bottomAnchor.constraint(equalTo: qtyMoneyLabel.bottomAnchor, constant: 30),
        
        totalLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        totalLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        qtyMoneyLabel.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 20),
        qtyMoneyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        detailInformation.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30),
        detailInformation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        detailInformation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        recalculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        recalculateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        recalculateButton.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
