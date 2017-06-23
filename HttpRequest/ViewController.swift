//
//  ViewController.swift
//  HttpRequest
//
//  Created by JIN on 2017/6/22.
//  Copyright © 2017年 JIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        TestNet.loadData(params: nil, success: {model in
            //成功
        }, failture: {
            error in
            //失败
        })

        
        JTestNet.loadData(params: nil, success: { (model) in
            
        }) { (error) in
            
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

