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
        LNKTClientTracking.setApiKey(apiKey: "Test API Key")
        
        clientTrackingMap = LNKTClientTracking(view: self.view)
        
        clientTrackingMap?.watchJob(jobId: "8d62e37a-b44f-4ffc-bc3d-41ab6d5982ea")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
