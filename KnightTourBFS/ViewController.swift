//
//  ViewController.swift
//  KnightTourBFS
//
//  Created by Peter Bournakas on 6/2/20.
//  Copyright © 2020 Peter Bournakas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var knSolveR: KnightSolver!
    
    @IBOutlet weak var chessViewBoard: BoardView!
    
    @IBOutlet weak var lblTargetPosition: UILabel!
    @IBOutlet weak var lblStartPosition: UILabel!
    @IBOutlet weak var txtResults: UITextView!
    
    var startPosXY: [Int]!
    var targetPosXY: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(startReceived), name: NSNotification.Name("start"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(targetReceived), name: NSNotification.Name("target"), object: nil)
    }

    @objc private func startReceived() {
        
        startPosXY = chessViewBoard!.startPosXY
        
        lblStartPosition.text! += " x:\(startPosXY![0]-1) y:\(startPosXY![1]-1)"
        
    }
    
    @objc private func targetReceived() {
        
        targetPosXY = chessViewBoard!.targetPosXY
        
        
        lblTargetPosition.text! += " x:\(targetPosXY![0]-1) y:\(targetPosXY![1]-1)"
        
    }

    @IBAction func reset_action(_ sender: Any) {
        
        startPosXY = nil
        targetPosXY = nil
        
        if let board = chessViewBoard {
            board.startPosXY = nil
            board.targetPosXY = nil
        }
        
        lblTargetPosition.text! = "Knight Target Position: "
        lblStartPosition.text! = "Knight Start Position: "
        txtResults.text! = ""
        
    }
    
    @IBAction func calculate_action(_ sender: Any) {
        
        guard let startPos = startPosXY else {
            let alertController = UIAlertController(title: "Alert", message: "Start Position Not Selected", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(action1)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        guard let targetPos = targetPosXY else {
            let alertController = UIAlertController(title: "Alert", message: "Target Position Not Selected", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Close", style: .default)
            alertController.addAction(action1)
            
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        
        let knightPos = [startPosXY[0]-1,startPosXY[1]-1]
        let targetPost = [targetPosXY[0]-1,targetPosXY[1]-1]
              
        knSolveR = KnightSolver(knightPos: knightPos, targetPos: targetPost, withBoardSize: 8)
        let result = knSolveR.minStepsForTarget(knightPos: knightPos, targetPos: targetPost, withBoardSize: 8)
        
        if (result! > 3) {
            txtResults.text = "No Feasible Result for 3 Steps"
        } else {
            txtResults.text = "Steps on Range: \(result!) \n\r";
            
            txtResults.text! += "Available Paths : \r\n";
            
            for cell in knSolveR.visitPaths {
                txtResults.text! += "x:\(cell.x), y:\(cell.y) \n\r"
            }
        }
        
        
        
    }
    
}

