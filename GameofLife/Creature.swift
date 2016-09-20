//
//  Creature.swift
//  GameofLife
//
//  Created by Michael K on 9/9/16.
//  Copyright © 2016 Waxy Watermelon. All rights reserved.
//

import SpriteKit

class Creature: SKSpriteNode {
    
    /* Character side */
    var isAlive: Bool = false {
        didSet {
            /* Visibility */
            hidden = !isAlive
        }
    }
    
    /* Living neighbor counter */
    var neighborCount = 0
    
    init() {
        /* Initialize with 'bubble' asset */
        let texture = SKTexture(imageNamed: "bubble")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        
        /* Set Z-Position, ensure it's on top of the grid */
        zPosition = 1
        
        /* Set anchor point to bottom left */
        anchorPoint = CGPoint(x: 0, y: 0)
    }
    
    /* You are also required to impliment this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
