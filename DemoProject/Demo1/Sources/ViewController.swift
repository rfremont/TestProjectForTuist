//
//  ViewController.swift
//  appTest
//
//  Created by Rudy Frémont on 11/9/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let label = UILabel(frame: self.view.bounds)
        label.text = "DEMO1"
        label.font = UIFont.systemFont(ofSize: 30.0)
        self.view.addSubview(label)
        label.contentMode = .center
        label.textAlignment = .center
    }
}

