//
//  KnightTourSolver.swift
//  KnightTour
//
//  Created by Peter Bournakas on 6/2/20.
//  Copyright © 2020 Peter Bournakas. All rights reserved.
//

import Foundation


public class KnightSolver {
    var knightPos: [Int]
    var targetPos: [Int]
    var n: Int
    var visit: [[Bool]]
    
    var visitPaths = [knightCell]()
    
    init(knightPos: [Int], targetPos: [Int], withBoardSize n: Int) {
    
        self.knightPos = knightPos
        self.targetPos = targetPos
        self.n = n
        
        visit = Array(repeating: Array(repeating: false, count: n+1), count: n+1)
    }
    
    func minStepsForTarget(knightPos: [Int], targetPos: [Int], withBoardSize n: Int) -> Int! {
        let dx =  [-2, -1, 1, 2, -2, -1, 1, 2 ]
        let dy =  [ -1, -2, -2, -1, 1, 2, 2, 1 ]
        
        var x: Int
        var y: Int
        
        var q = Queue()
        
        var kn = knightCell(x: knightPos[0], y: knightPos[1], distance: 0)
        
        q.enqueue(element: kn)
                
        visit[knightPos[0]][knightPos[1]] = true;
        
        while q.count != 0 {
            
            let t = q.dequeue()
            
            if t?.x == targetPos[0] && t?.y == targetPos[1] {
                return t?.distance
            }
            
            for index in 0...7 {
                
                x = (t?.x)! + dx[index]
                y = (t?.y)! + dy[index]
                
                if isValidMove(x: x, y: y, N: n) && !visit[x][y] {
                    visit[x][y] = true
                    
                    visitPaths.append(knightCell(x: x, y: y, distance: -1))
                    q.enqueue(element: knightCell(x: x, y: y, distance: t!.distance + 1))
                }
            }
            
        }
        
        return Int.max
        
    }
    
    func isValidMove(x: Int, y: Int, N: Int) -> Bool {
          
        if x >= 1 && x <= N && y >= 1 && y <= N {
            return true
        }
        else {
            return false
        }
    }
    
}

public struct knightCell {
    var x: Int
    var y: Int
    var distance: Int
}

struct Queue{
    
    var items:[knightCell] = []
    
    var count: Int {
        return items.count
    }
    
    mutating func enqueue(element: knightCell)
    {
        items.append(element)
    }
    
    mutating func dequeue() -> knightCell?
    {
        
        if items.isEmpty {
            return nil
        }
        else{
            let tempElement = items.first
            items.remove(at: 0)
            return tempElement
        }
    }
    
}
