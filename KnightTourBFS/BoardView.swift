//
//  BoardView.swift
//  KnightTourBFS
//
//  Created by Peter Bournakas on 6/2/20.
//  Copyright © 2020 Peter Bournakas. All rights reserved.
//

import UIKit

class BoardView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var squareCon = CGFloat(0)
    
    var startPosXY: [Int]!
    var targetPosXY: [Int]!
    
    override func draw(_ rect: CGRect) {
        
        squareCon = self.frame.width / 8 //calculate to fit from width for 8 size board
        
        drawBoard()
        
    }
    
    
   func drawBoard() {
        drawTwoRowsAt(y: 0 * squareCon)
        drawTwoRowsAt(y: 2 * squareCon)
        drawTwoRowsAt(y: 4 * squareCon)
        drawTwoRowsAt(y: 6 * squareCon)
    }
    
    func drawTwoRowsAt(y: CGFloat) {
        drawSquareAt(x: 1 * squareCon, y: y)
        drawSquareAt(x: 3 * squareCon, y: y)
        drawSquareAt(x: 5 * squareCon, y: y)
        drawSquareAt(x: 7 * squareCon, y: y)
        
        drawSquareAt(x: 0 * squareCon, y: y + squareCon)
        drawSquareAt(x: 2 * squareCon, y: y + squareCon)
        drawSquareAt(x: 4 * squareCon, y: y + squareCon)
        drawSquareAt(x: 6 * squareCon, y: y + squareCon)
    }
    
    func drawSquareAt(x: CGFloat, y: CGFloat) {
        let path = UIBezierPath(rect: CGRect(x: x, y: y, width: squareCon, height: squareCon))
        
        UIColor.lightGray.setFill()
        path.fill()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            print(position)
            
            let res = findXLocationOnChess(touchPosition: position)
            
            if startPosXY == nil {
                startPosXY = res
                NotificationCenter.default.post(name: NSNotification.Name("start"), object: nil)
            }
            else {
                targetPosXY = res
                NotificationCenter.default.post(name: NSNotification.Name("target"), object: nil)
            }
            
            
            print("x: \(res[0]) y : \(res[1])")
        }
    }
    
    func findXLocationOnChess(touchPosition: CGPoint) -> [Int] {
        
        var x = CGFloat(0)
        var y = CGFloat(0)
        var yConSquareCon = CGFloat(self.frame.height / 8)
        
        
        var xy = [0,0]
        
        for index in 1...8 {
            x += squareCon
            
            if x > touchPosition.x {
                xy[0] = index
                break
            } else {
                continue
            }
        }
        
        for index in 1...8 {
            y += yConSquareCon
            
            if y > touchPosition.y {
                xy[1] = index
                break
            } else {
                continue
            }
        }
        
        return xy
    }
    
}
