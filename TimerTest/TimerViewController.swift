//
//  ViewController.swift
//  TimerTest
//
//  Created by Ислам on 21.11.2024.
//

import UIKit

class TimerViewController: UIViewController {

    private var timer: Timer?
    private var timeRemaining: Int = 30 {
        didSet {
            timeLabel.text = "Обновление через: \(timeRemaining) сек."
        }
    }

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Обновление через: \(timeRemaining) сек."
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Обновить сейчас", for: .normal)
        button.addTarget(self, action: #selector(refreshNow), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTimer()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(timeLabel)
        view.addSubview(refreshButton)

        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            refreshButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.timeRemaining -= 1
            
            if self.timeRemaining <= 0 {
                self.refreshContent()
                self.timeRemaining = 30
            }
        }
    }

    private func refreshContent() {
        print("Контент обновлен!")
    }

    @objc private func refreshNow() {
        refreshContent()
        timeRemaining = 30
    }

    deinit {
        timer?.invalidate()
    }
}
