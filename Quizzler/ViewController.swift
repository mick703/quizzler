//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var currentQuestionIndex = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startOver()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if (sender.tag == 1) {
            pickedAnswer = true
        } else if (sender.tag == 2) {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        
        if (currentQuestionIndex < (allQuestions.list.count - 1)) {
            nextQuestion()
        } else {
            //Render an alert popup
            let alert = UIAlertController(title: "Awesome", message: "You've reach the end of the quize. Do you want to start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            
            present(alert, animated: true)
        }
        
        
    }
    
    
    func updateUI() {
        let questionTotal = allQuestions.list.count
        
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(currentQuestionIndex+1)/\(questionTotal)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(questionTotal)) * (CGFloat(currentQuestionIndex) + 1)
        
    }
    

    func nextQuestion() {
        currentQuestionIndex += 1
        questionLabel.text = allQuestions.list[currentQuestionIndex].questionText
        updateUI()
    }
    
    
    func checkAnswer() {
        if pickedAnswer == allQuestions.list[currentQuestionIndex].answer {
            score += 1
            ProgressHUD.showSuccess("Correct!")
        } else {
            ProgressHUD.showError("Wrong!")
        }
        
    }
    
    
    func startOver() {
        currentQuestionIndex = 0
        questionLabel.text = allQuestions.list[currentQuestionIndex].questionText
        score = 0
        updateUI()
        
    }
    

    
}
