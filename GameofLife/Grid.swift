//
//  Grid.swift
//  GameofLife
//
//  Created by Michael K on 9/9/16.
//  Copyright © 2016 Waxy Watermelon. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    
    /* Grid array dimensions */
    let rows = 8
    let columns = 10
    
    /* Individual cell dimension, calculated in setup */
    var cellWidth = 0
    var cellHeight = 0
    
    /* Counters */
    var generation = 0
    var population = 0
    
    /* Creature array */
    var gridArray = [[Creature]]()
    
    func addCreatureAtGrid(x x: Int, y: Int) {
        /* Add a new creature at grid position */
        
        /* New creature object */
        let creature = Creature()
        
        /* Calculate position on screen */
        let gridPositon = CGPoint(x: x*cellWidth, y: y*cellHeight)
        creature.position = gridPositon
        
        /* set Default isAlive */
        creature.isAlive = false
        
        /* Add creature to grid node */
        addChild(creature)
        
        /* Add creature to grid array */
        gridArray[x].append(creature)
    }
    
    func populateGrid() {
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Initialize empty column */
            gridArray.append([])
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Create a new creature at row / column position */
                addCreatureAtGrid(x: gridX, y: gridY)
            }
        }
    }
    
    func countNeighbors() {
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Grab current creature */
                let currentCreature = gridArray[gridX][gridY]
                
                /* Reset neighbor count */
                currentCreature.neighborCount = 0
                
                /* Loop through all adjacent creatures to current creature */
                for innerGridX in (gridX - 1)...(gridX + 1) {
                    
                    /* Ensure inner grid column is inside array */
                    if innerGridX<0 || innerGridX >= columns { continue }
                    
                    for innerGridY in (gridY - 1)...(gridY + 1) {
                        
                        /* Ensure inner grid column is inside array */
                        if innerGridY<0 || innerGridY >= rows { continue }
                        
                        /* Creature can't count itself as a neighbore */
                        if innerGridX == gridX && innerGridY == gridY { continue }
                        
                        /* Grab adjacent creature reference */
                        let adjacentCreature: Creature = gridArray[innerGridX][innerGridY]
                        
                        /* Only interested in living creatures */
                        if adjacentCreature.isAlive {
                            currentCreature.neighborCount += 1
                        }
                    }
                }
            }
        }
    }
    
    func updateCreatures() {
        /* Process array and update creature status */
        
        /* Reset population counter */
        population = 0
        
        /* Loop through columns */
        for gridX in 0..<columns {
            
            /* Loop through rows */
            for gridY in 0..<rows {
                
                /* Grab current creature */
                let currentCreature = gridArray[gridX][gridY]
                
                /* Check against game of life rules */
                switch currentCreature.neighborCount {
                case 3:
                    currentCreature.isAlive = true
                    break;
                case 0...1, 4...8:
                    currentCreature.isAlive = false
                    break;
                    
                default:
                    break;
                }
                
                /*  Refresh population counter */
                if currentCreature.isAlive { population += 1 }
                
                
                /* Less good code to implement above switch statement */
                
                /*
                if currentCreature.neighborCounter > 2 {
                    currentCreature.isAlive = false
                }
                
                if currentCreature.neighborCounter > 3 {
                    currentCreature.isAlive = false
                }
                
                if currentCreature.isAlive && (currentCreature.neighborCounter == 2 || currentCreature.neighborCounter == 3) {
                    currentCreature.isAlive = true
                }
                
                if !currentCreature.isAlive && currentCreature.neighborCounter ==3 {
                    currentCreature.isAlive = true
                }
                */
 
            }
        }
    }
    
    func evolve() {
        /* Updated the grid to the next state in the game of life */
        
        /* Update all creature neighbor counts */
        countNeighbors()
        
        /* Calculate all creatures dead or alive */
        updateCreatures()
        
        /* Increment generation counter */
        generation += 1
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when touch begins */
        
        /* There will only be one touch as multitouch is not enabled by default */
        for touch in touches {
            
            /* Grab position of touch relative to the grid */
            let location = touch.locationInNode(self)
            let gridX = Int(location.x) / cellWidth
            let gridY = Int(location.y) / cellHeight
            
            /* Toggle creature visibility */
            let creature = gridArray[gridX][gridY]
            creature.isAlive = !creature.isAlive
        }
    }


    /* You are required to impliment this for your subclass to work */
    required init?( coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Enable own touch inplementation for this node */
        userInteractionEnabled = true
        
        /* Calculate individual cell dimensions */
        cellWidth = Int(size.width) / columns
        cellHeight = Int(size.height) / rows
        
        /* Populate grid with creatures */
        populateGrid()
    }
}
