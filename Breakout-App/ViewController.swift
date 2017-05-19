//
//  ViewController.swift
//  Breakout-App
//
//  Created by student8 on 4/28/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    
    @IBOutlet weak var ballView: UIView!
    
    @IBOutlet weak var paddleView: UIView!
    
    var dynamicAnimator: UIDynamicAnimator!
    
    var pushBehavior: UIPushBehavior!
    
    var collisionBehavior: UICollisionBehavior!
    
    var ballDynamicBehavior: UIDynamicItemBehavior!
    
    var paddleDynamicBehavior: UIDynamicItemBehavior!
    
    var blockDynamicBehavior: UIDynamicItemBehavior!
    
    
    var View1: UIView!
    
    var View2: UIView!
    
    var View3: UIView!
    
    var View4: UIView!
    
    var View5: UIView!
    
    var View6: UIView!
    
    var View7: UIView!
    
    var View8: UIView!
    
    var View9: UIView!
    
    var View10: UIView!
    
    var blockArray = [UIView!]()
    
    var count = 0
    
    var isdone = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ballView.layer.cornerRadius = 15
        
        blockArray = [View1,View2,View3,View4,View5,View6,View7,View8,View9,View10]

    }
    
    
    
    
    @IBAction func padGesture(_ sender: UIPanGestureRecognizer) {
        
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
        
        
        
        for block in blockArray
        {
            block!.backgroundColor = UIColor.cyan
            
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
                if block == item2 as? UIView
                {
                    if block!.backgroundColor == UIColor.cyan
                    {
                        block!.backgroundColor = UIColor.purple
                    }
                        
                    else if block!.backgroundColor == UIColor.purple
                    {
                        
                        self.collisionBehavior.removeItem(block!)
                        
                        block!.removeFromSuperview()
                        
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
        
        
        self.count = 0
        
           for block in blockArray
         {
         view.addSubview(block!)
         
         block?.backgroundColor  = UIColor.cyan
         
         collisionBehavior.addItem(block!)
         }
        
        self.dynamicAnimatorStuffs()
        
    }
    
    func dynamicAnimatorStuffs()
    {
        ballView.layer.cornerRadius = 12.0
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        pushBehavior = UIPushBehavior(items: [ballView], mode: UIPushBehaviorMode.instantaneous)
        
        ballView.center = CGPoint(x: 67, y: 250)
        
        pushBehavior.pushDirection = CGVector(dx: 0.5, dy: 1.0)
        
        pushBehavior.active = true
        
        pushBehavior.magnitude = 0.4
        
        dynamicAnimator.addBehavior(pushBehavior)
        
        collisionBehavior = UICollisionBehavior(items: [ballView, paddleView, View1,View2,View3,View4,View5,View6,View7,View8,View9,View10])
        
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
        
        blockDynamicBehavior = UIDynamicItemBehavior(items: [View1,View2,View3,View4,View5,View6,View7,View8,View9,View10])
        
        blockDynamicBehavior.allowsRotation = false
        
        blockDynamicBehavior.density = 9000.1
        
        blockDynamicBehavior.elasticity = 1
        
        blockDynamicBehavior.resistance = 0
        
        blockDynamicBehavior.friction = 0
        
        dynamicAnimator.addBehavior(blockDynamicBehavior)
        
        
    }
    
    
}

