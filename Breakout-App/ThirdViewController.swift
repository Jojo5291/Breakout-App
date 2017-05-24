//
//  ThirdViewController.swift
//  Breakout-App
//
//  Created by student8 on 5/23/17.
//  Copyright © 2017 John Hersey High School. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var dynamicAnimator: UIDynamicAnimator!
    
    var pushBehavior: UIPushBehavior!
    
    var secondPushBehavior: UIPushBehavior!
    
    var collisionBehavior: UICollisionBehavior!
    
    var ballDynamicBehavior: UIDynamicItemBehavior!
    
    var paddleDynamicBehavior: UIDynamicItemBehavior!
    
    var blockDynamicBehavior: UIDynamicItemBehavior!
    
    @IBOutlet weak var blockOne: UIView!
    
    @IBOutlet weak var blockTwo: UIView!
    
    @IBOutlet weak var blockThree: UIView!
    
    @IBOutlet weak var blockFour: UIView!
    
    @IBOutlet weak var blockFive: UIView!
    
    @IBOutlet weak var blockSix: UIView!
    
    @IBOutlet weak var blockSeven: UIView!
    
    @IBOutlet weak var blockEight: UIView!
    
    @IBOutlet weak var blockNine: UIView!
    
    @IBOutlet weak var THEBLOCK: UIView!
    
    @IBOutlet weak var ballView: UIView!
    
    @IBOutlet weak var paddleView: UIView!
    
    var newBall = UIView(frame: CGRect(x: 153, y: 205, width: 25, height: 25))
    
    var blockArrayWithoutTheBlock = [UIView]()
    
    var blockArray = [UIView]()
    
    var count = 0
    
    var isdone = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        THEBLOCK.backgroundColor = UIColor.yellow
        
        ballView.layer.cornerRadius = 15
        
        
        
        blockArray = [blockOne,blockTwo,blockThree,blockFour,blockFive,blockSix,blockSeven,blockEight,blockNine,THEBLOCK]
        
        blockArrayWithoutTheBlock = [blockOne,blockTwo,blockThree,blockFour,blockFive,blockSix,blockSeven,blockEight,blockNine]
        
        self.dynamicAnimatorStuffs()
        
    }
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        
        paddleView.center = CGPoint(x: sender.location(in: self.view).x, y: paddleView.center.y)
        dynamicAnimator.updateItem(usingCurrentState: newBall)
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
        
        for block in blockArrayWithoutTheBlock
        {
            
            block.backgroundColor = UIColor.brown
            
            dynamicAnimatorStuffs()
            
        }
        
        
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        
        if ballView.center.y > paddleView.center.y
        {
            ballView.backgroundColor = UIColor.white
            
            newBall.backgroundColor = UIColor.white
            
             makeTheAlert()
        }
        
        if newBall.center.y > paddleView.center.y
        {
            ballView.backgroundColor = UIColor.white
            
            newBall.backgroundColor = UIColor.white
            
            makeTheAlert()
        }
        
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        
        UIView.animate(withDuration: 0.2) {
            
            
            
            
            for block in self.blockArray
            {
                if block == item2 as! UIView
                {
                    if block.backgroundColor == UIColor.brown
                    {
                        block.backgroundColor = UIColor.orange
                    }
                        
                        
                    else if block.backgroundColor == UIColor.orange
                    {
                        
                        self.collisionBehavior.removeItem(block)
                        
                        block.removeFromSuperview()
                        
                        self.count += 1
                        
                        
                    }
                    
                    else if block.backgroundColor == UIColor.yellow
                    {
                    self.makeNewBall()
                        
                    block.removeFromSuperview()
                        
                    self.collisionBehavior.removeItem(block)
                        
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
        self.ballView.backgroundColor = UIColor.green
        
        self.paddleView.center = CGPoint(x: 58, y: 615)
        
        
        self.count = 0
        
        self.newBall.removeFromSuperview()
        
        for block in blockArray
        {
            self.view.addSubview(block)
            
             collisionBehavior.addItem(block)
        }
        
        for block in blockArrayWithoutTheBlock
        {
            block.backgroundColor = UIColor.brown
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
        
        
        collisionBehavior = UICollisionBehavior(items: [ballView, paddleView, blockOne, blockTwo, blockThree, blockFour, blockFive, blockSix, blockSeven, blockEight, blockNine, THEBLOCK])
        
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
        
        blockDynamicBehavior = UIDynamicItemBehavior(items: [blockOne,blockTwo,blockThree,blockFour,blockFive,blockSix,blockSeven,blockEight,blockNine,THEBLOCK])
        
        blockDynamicBehavior.allowsRotation = false
        
        blockDynamicBehavior.density = 9000.1
        
        blockDynamicBehavior.elasticity = 1
        
        blockDynamicBehavior.resistance = 0
        
        blockDynamicBehavior.friction = 0
        
        dynamicAnimator.addBehavior(blockDynamicBehavior)
    }
    
    func makeNewBall()
    {
        

        
        self.view.addSubview(newBall)
        
        newBall.backgroundColor = UIColor.green

        newBall.layer.cornerRadius = 12.0
        
        secondPushBehavior = UIPushBehavior(items: [newBall], mode: UIPushBehaviorMode.instantaneous)
        
        secondPushBehavior.pushDirection = CGVector(dx: 0.5, dy: 1.0)
        
        secondPushBehavior.active = true
        
        secondPushBehavior.magnitude = 0.3
        
        dynamicAnimator.addBehavior(secondPushBehavior)
        
        collisionBehavior.addItem(newBall)
        
        dynamicAnimator.addBehavior(collisionBehavior)
        
        ballDynamicBehavior.addItem(newBall)
        
        dynamicAnimator.addBehavior(ballDynamicBehavior)
        
    }
    
    
    
}



