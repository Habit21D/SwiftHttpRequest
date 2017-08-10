//
//  ViewController.swift
//  HttpRequest
//
//  Created by JIN on 2017/6/22.
//  Copyright © 2017年 JIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var jtestModel : JTestModel?
    var testModel : TestModel?
    
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
            self.jtestModel = model as? JTestModel
            self.handleJModel(self.jtestModel)
        }) { (error) in
            
        }
        
        ViewModel.loadData(params: nil, success: { (model) in
         self.testModel = model as? TestModel
           self.handleModel(self.testModel)
        }) { (error) in
            
        }
        
    }

    func handleJModel(_ model: JTestModel?) {
        
    }
    
    func handleModel(_ model: TestModel?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

