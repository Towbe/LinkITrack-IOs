//
//  ViewController.swift
//  LinkITrack
//
//  Created by Baltagih2 on 09/28/2020.
//  Copyright (c) 2020 Baltagih2. All rights reserved.
//

import UIKit
import LinkITrack

class ViewController: UIViewController {
    
    var clientTrackingMap: LNKTClientTracking? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LNKTClientTracking.setApiKey(apiKey: "s770KcORul14KtRDrRonfnoR8xC8PMtFDrVm8pCn")
        
        clientTrackingMap = LNKTClientTracking(view: self.view)
        
        clientTrackingMap?.watchJob(jobId: "83b83540-143e-eb11-a2e2-ef819a435c14")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
