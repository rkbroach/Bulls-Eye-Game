//
//  ViewController.swift
//  BullsEye
//
//  Created by Rohan Kevin Broach on 6/12/19.
//  Copyright © 2019 rkbroach. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // Slider
  @IBOutlet weak var slider: UISlider!
  var currentValue = Int()
  
  // Score
  @IBOutlet weak var score: UILabel!
  var totalScore = Int()
  var points = Int()
  
  // Rounds
  @IBOutlet weak var round: UILabel!
  var roundValue = Int ()
  
  // Target
  @IBOutlet weak var target: UILabel!
  var targetValue = Int()
  
  // View Loaded
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Slider UI Code
    let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
    slider.setThumbImage(thumbImageNormal, for: .normal)
    let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
    slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
    
    let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    
    let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
    let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
    slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
    let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
    let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
    slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    
    // Start New Game
    startNewGame()
    
  }
  
  func startNewGame() {
    // reset all parameters
    currentValue = Int(slider.value.rounded())
    points = 0
    totalScore = 0
    roundValue = 0
    
    startNextRound()
  }
  
  // New Round Started
  func startNextRound () {
    
    // update target
    targetValue = Int.random(in: 1...100) // get new target value
    target.text = String(targetValue)
    
    // update slider
    currentValue = 50 // reset slider
    slider.setValue(50.0, animated: true)
    
    // update score
    score.text = String(totalScore)
    
    // update round
    roundValue += 1
    round.text = String(roundValue)
  }
  
  // Show alert when Hit Me is pressed
  @IBAction func showAlert(_ sender: UIButton) {
    
    // Decide message according to points earned
    points = calculatePoints()
    let title : String
    if points == 100 {
      title = "PERFECT SCORE! You get bonus 50 points 😍"
      points += 50
    } else if points == 99 {
      title = "Well played, my friend. You get bonus 20 points 😘"
      points += 20
    } else if points > 95 {
      title = "Ouhh... that was pretty close 😱"
    } else if points > 75 {
      title = "Better luck in next round 😊"
    } else {
      title = "That wasn't even close 😂"
    }
    totalScore += points
    
    
    // Alert for end of round
    let alert = UIAlertController(title: "You picked \(currentValue)" + "\n\(title).", message: "You scored \(points) in this round", preferredStyle: .alert)
    
    let action = UIAlertAction(title: "Go to next round", style: .default, handler: {
      action in self.startNextRound()
      
    })
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
  }
  
  
  @IBAction func sliderMoved(_ sender: UISlider) {
    currentValue = Int(sender.value.rounded())
  }
  
  
  func calculatePoints () -> Int {
    return 100 - abs(targetValue - currentValue)
  }
  
  
  @IBAction func restart(_ sender: UIButton) {
    
    let restartAlert = UIAlertController(title: "Woah!", message: "Do you really want to restart?", preferredStyle: .alert)
    
    let restartAction = UIAlertAction(title: "Yes, please", style: .default, handler: {
      restartAction in self.startNewGame()
    })
    
    restartAlert.addAction(restartAction)
    present(restartAlert, animated: true, completion: nil)
    
    
  }
 
  
  
}
