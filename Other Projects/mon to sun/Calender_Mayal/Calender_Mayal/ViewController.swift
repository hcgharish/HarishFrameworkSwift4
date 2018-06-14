//
//  ViewController.swift
//  Calender_Mayal
//
//  Created by Avinash somani on 11/04/17.
//  Copyright © 2017 Kavyasoftech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CalenderViewDelegate {
    func calenderDateClicked(_ btn: CalenderButton) {
        print("date-\(btn.date)-")
    }

    @IBOutlet var viewCalender: CalenderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCalender.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func currentMonthYear (_ monthYear:String, _ view:CalenderView) {
        lblMonthName.text = monthYear
    }
    
    @IBOutlet var lblMonthName: UILabel!
    
    @IBAction func actionPreviousMonth(_ sender: Any) {
        viewCalender.showPreviousMonth ()
    }
    
    @IBAction func actionNextMonth(_ sender: Any) {
        viewCalender.showNextMonth ()
    }
}










