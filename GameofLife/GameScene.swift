//
//  GameScene.swift
//  GameofLife
//
//  Created by Michael K on 9/9/16.
//  Copyright (c) 2016 Waxy Watermelon. All rights reserved.
//

import SpriteKit

/* UI objects */

var stepButton: MSButtonNode!

var playButton: MSButtonNode!

var pauseButton: MSButtonNode!

var populationLabel: SKLabelNode!

var generationLabel: SKLabelNode!

var gridNode: Grid!


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Connect UI scene objects */
        
        /* Set reference to the pause button node */
        stepButton = self.childNodeWithName("stepButton") as! MSButtonNode
        
        /* Set reference to the play button node */
        playButton = self.childNodeWithName("playButton") as! MSButtonNode
        
        /* Set reference to the pause button node */
        pauseButton = self.childNodeWithName("pauseButton") as! MSButtonNode
        
        /* Set reference to the population label node */
        populationLabel = self.childNodeWithName("populationLabel") as! SKLabelNode
        
        /* Set reference to the generation label node */
        generationLabel = self.childNodeWithName("generationLabel") as! SKLabelNode
        
        /* Set reference to grid node */
        gridNode = self.childNodeWithName("gridNode") as! Grid
        
        /* Set up testing button selection handler */
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        
        /* Create an SKAction based timer, 0.5 second delay */
        let delay = SKAction.waitForDuration(0.5)
        
        /* Call the step simulation() method to advance the simulation */
        let callMethod = SKAction.performSelector(#selector(GameScene.stepSimulation), onTarget: self)
        
        /* Create the delay, step cycle */
        let stepSequence = SKAction.sequence([delay, callMethod])
        
        /* Create an infinite simulation loop */
        let simulation = SKAction.repeatActionForever(stepSequence)
        
        /* Run simulation action */
        self.runAction(simulation)
        
        /* Default simulation to pause state */
        self.paused = true
        
        /* Set up play button selection handler */
        playButton.selectedHandler = {
            self.paused = false
        }
        
        /* Set up pause button selection handler */
        pauseButton.selectedHandler = {
            self.paused = true
        }
 
    }
    
    func stepSimulation() {
        /* Step Simulation */
        
        /* Run  next step in simulation */
        gridNode.evolve()
        
        /* Update UI label objects */
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
