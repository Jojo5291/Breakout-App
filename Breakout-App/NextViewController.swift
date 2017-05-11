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

        dynamicAnimatorStuffs()

    
    }
    
    @IBAction func panThing(_ sender: UIPanGestureRecognizer)
    {
        paddleView.center = CGPoint(x: sender.location(in: self.view).x, y: paddleView.center.y)
        
        dynamicAnimator.updateItem(usingCurrentState: paddleView)
        
        
        
        
        if ballView.center.y > paddleView.center.y
        {
            ballView.backgroundColor = UIColor.white
        }
        
        
        if ballView.backgroundColor == UIColor.white || blockArray.count == 0
        {
           
            makeTheAlert()
            
        }
        
        
    }
    
    

    override func viewDidAppear(_ animated: Bool) {
        
        dynamicAnimatorStuffs()
        
        for block in blockArray
        {

        dynamicAnimatorStuffs()
            
        }
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        
        if ballView.center.y > paddleView.center.y
        {
            ballView.backgroundColor = UIColor.white
            
            makeTheAlert()
        }
        
 
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        
        UIView.animate(withDuration: 0.2) {
            
            
            
            
            for block in self.blockArray
            {
                if block == item2 as! UIView
                {
                    if block.backgroundColor == UIColor.red
                    {
                        block.backgroundColor = UIColor.orange
                    }
                        
                    else if block.backgroundColor == UIColor.orange
                    {
                        block.backgroundColor = UIColor.yellow
                    }
                        
                    else if block.backgroundColor == UIColor.yellow
                    {
                        
                        self.collisionBehavior.removeItem(block)
                        
                        block.removeFromSuperview()
                        
                        self.count += 1
                        
                        
                    }
                    
                 
                    if self.count == 10
                    {
                        self.makeTheAlert()
                    }
                    
                }
            }
            
        }
        
    }
    
    func makeTheAlert()
    {
        let alert = UIAlertController(title: "GAME OVER", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "restart", style: UIAlertActionStyle.default) { (action) in
            
            self.reset()
        }
        
        let rageQuitAction = UIAlertAction(title: "rage quit", style: UIAlertActionStyle.default) { (action) in
            
            self.dismiss(animated: false, completion: nil)
            
        }
        
        
        
        
        
        alert.addAction(okAction)
        
        alert.addAction(rageQuitAction)
        
        
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func reset()
    {
        self.ballView.backgroundColor = UIColor.purple
        
        self.paddleView.center = CGPoint(x: 58, y: 615)
        
        
        self.count = 0
        
        
        for block in blockArray
        {
            self.view.addSubview(block)
            
            block.backgroundColor = UIColor.red
            
            collisionBehavior.addItem(block)
        }
        self.dynamicAnimatorStuffs()
        
    }
    
    func dynamicAnimatorStuffs()
    {
        ballView.layer.cornerRadius = 12.0
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        pushBehavior = UIPushBehavior(items: [ballView], mode: UIPushBehaviorMode.instantaneous)
        
        ballView.center = CGPoint(x: 16, y: 487)
        
        pushBehavior.pushDirection = CGVector(dx: 0.5, dy: 1.0)
        
        pushBehavior.active = true
        
        pushBehavior.magnitude = 0.3
        
        dynamicAnimator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [ballView, paddleView, leftEye,rightEye,nose,mouth1,mouth2,mouth3,mouth5,mouth6,mouth7,mouth8,mouth9,mouth10,mouth11,mouth12])
        
        collisionBehavior.collisionMode = UICollisionBehaviorMode.everything
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        collisionBehavior.collisionDelegate = self
        
        dynamicAnimator.addBehavior(collisionBehavior)
        
        ballDynamicBehavior = UIDynamicItemBehavior(items: [ballView])
        
        ballDynamicBehavior.allowsRotation = false
        
        ballDynamicBehavior.elasticity = 1.0
        
        ballDynamicBehavior.resistance = 0.0
        
        ballDynamicBehavior.friction = 0.0
        
        dynamicAnimator.addBehavior(ballDynamicBehavior)
        
        paddleDynamicBehavior = UIDynamicItemBehavior(items: [paddleView])
        
        paddleDynamicBehavior.allowsRotation = false
        
        paddleDynamicBehavior.density = 9000.1
        
        paddleDynamicBehavior.friction = 0.0
        
        dynamicAnimator.addBehavior(paddleDynamicBehavior)
        
        blockDynamicBehavior = UIDynamicItemBehavior(items: [leftEye,rightEye,nose,mouth1,mouth2,mouth3,mouth5,mouth6,mouth7,mouth8,mouth9,mouth10,mouth11,mouth12])
        
        blockDynamicBehavior.allowsRotation = false
        
        blockDynamicBehavior.density = 9000.1
        
        blockDynamicBehavior.elasticity = 1
        
        blockDynamicBehavior.resistance = 0
        
        blockDynamicBehavior.friction = 0
        
        dynamicAnimator.addBehavior(blockDynamicBehavior)
    }
 

}
