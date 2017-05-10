//
//  NextViewController.swift
//  Breakout-App
//
//  Created by student8 on 5/9/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var dynamicAnimator: UIDynamicAnimator!
    
    var pushBehavior: UIPushBehavior!
    
    var collisionBehavior: UICollisionBehavior!
    
    var ballDynamicBehavior: UIDynamicItemBehavior!
    
    var paddleDynamicBehavior: UIDynamicItemBehavior!
    
    var blockDynamicBehavior: UIDynamicItemBehavior!
    
    
    @IBOutlet weak var leftEye: UIView!
    
    @IBOutlet weak var rightEye: UIView!
    
    @IBOutlet weak var nose: UIView!
    
    @IBOutlet weak var mouth1: UIView!
    
    @IBOutlet weak var mouth2: UIView!
    
    @IBOutlet weak var mouth3: UIView!
    
    @IBOutlet weak var mouth5: UIView!
    
    @IBOutlet weak var mouth6: UIView!
    
    @IBOutlet weak var mouth7: UIView!
    
    @IBOutlet weak var mouth8: UIView!
    
    @IBOutlet weak var mouth9: UIView!
    
    @IBOutlet weak var mouth10: UIView!
    
    @IBOutlet weak var mouth11: UIView!
    
    @IBOutlet weak var mouth12: UIView!
    
    @IBOutlet weak var ballView: UIView!
    
    @IBOutlet weak var paddleView: UIView!
    
    var blockArray = [UIView]()
    
    var count = 0
    
    var isdone = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ballView.layer.cornerRadius = 15
        
        
        blockArray = [leftEye,rightEye,nose,mouth1,mouth2,mouth3,mouth5,mouth6,mouth7,mouth8,mouth9,mouth10,mouth11,mouth12]


    
    }

    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    
    
    

 

}
