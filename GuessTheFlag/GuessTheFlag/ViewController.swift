//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Hasan Basri Komser on 23.03.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstFlagButton: UIButton!
    @IBOutlet var secondFlagButton: UIButton!
    @IBOutlet var thirdFlagButton: UIButton!
    var scoreLabel: UILabel!
    var questionCountLabel: UILabel!
    
    var countries = [String]()
    var score = 0
    var questionCount = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        scoreLabel = UILabel()
        questionCountLabel = UILabel()
        scoreLabel.text = "Score: \(score)"
        questionCountLabel.text = "\(questionCount)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: scoreLabel)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: questionCountLabel)
        super.viewDidLoad()
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]

        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2) //Between zero and two inclusive so it could be zero or two
        firstFlagButton.setImage(UIImage(named: countries[0]), for: .normal)
        secondFlagButton.setImage(UIImage(named: countries[1]), for: .normal)
        thirdFlagButton.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
        questionCount += 1
        if questionCount > 10 {
            questionCountLabel.isHidden = true
        } else {
            questionCountLabel.text = "\(questionCount)"
        }
    }
    
    func restartGame(action: UIAlertAction! = nil) {
        score = 0
        questionCount = 0
        questionCountLabel.isHidden = false
        scoreLabel.text = "Score: \(score)"
        questionCountLabel.text = "\(questionCount)"
        askQuestion()
    }
    func exitTheGame(action: UIAlertAction! = nil){
        exit(0)
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.tag == correctAnswer {
            score += 1
        } else {
            let ac = UIAlertController(title: "Wrong", message: "That was the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(ac,animated: true)
            score -= 1
        }
        scoreLabel.text = "Score: \(score)"
        if questionCount == 10 {
            let ac = UIAlertController(title: "Game Over", message: "Total Score: \(score) Do you want play again?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "No", style: .cancel,handler:exitTheGame))
            ac.addAction(UIAlertAction(title: "Yes", style: .default,handler: restartGame))
            present(ac,animated: true)
        }
        askQuestion()
    }
    

}

