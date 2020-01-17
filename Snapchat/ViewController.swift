//
//  ViewController.swift
//  Snapchat
//
//  Created by Matheus Rodrigues Araujo on 17/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }


}

