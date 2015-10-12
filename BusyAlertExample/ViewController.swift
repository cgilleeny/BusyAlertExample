//
//  ViewController.swift
//  BusyAlertExample
//
//  Created by Caroline Gilleeny on 10/12/15.
//  Copyright © 2015 aValanche eVantage. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BusyAlertDelegate {

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var timerSecondsLabel: UILabel!
    @IBOutlet weak var startTimerButton: UIButton!
    
    var timer: NSTimer?

    lazy var busyAlertController: BusyAlert = {
        let busyAlert = BusyAlert(title: "Lengthy Transaction", message: "Please wait...", presentingViewController: self)
        busyAlert.delegate = self
        return busyAlert
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Control Handlers
    
    @IBAction func startTimerButtonHandler(sender: UIButton) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerTicked", userInfo: nil, repeats: true)
        busyAlertController.display()
    }

    @IBAction func stepperButtonHandler(sender: UIStepper) {
        timerSecondsLabel.text = String(Int(sender.value) as Int!)
        if stepper.value > 0 {
            startTimerButton.enabled = true
        } else {
            startTimerButton.enabled = false
        }
    }

    // MARK: - Notification Handlers
    
    @objc func timerTicked() {
        stepper.value--
        dispatch_async(dispatch_get_main_queue(), {
            self.timerSecondsLabel.text = String(Int(self.stepper.value) as Int!)
        })

        if stepper.value == 0 {
            timer?.invalidate()
            startTimerButton.enabled = false
            busyAlertController.dismiss()
        }
    }
    
    // MARK: - BusyAlertDelegate
    
    func didCancelBusyAlert() {
        timer?.invalidate()
        if stepper.value == 0 {
            startTimerButton.enabled = false
        }
    }

}

