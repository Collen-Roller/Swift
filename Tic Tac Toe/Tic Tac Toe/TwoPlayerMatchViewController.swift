//
//  TwoPlayerMatchViewController.swift
//  Tic Tac Toe
//
//  Created by Collen Roller on 10/10/15.
//  Copyright © 2015 CrollerDev. All rights reserved.
//

import UIKit

class TwoPlayerMatchViewController: UIViewController {
    
    let winningCombos = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    var currentBoard = [["-","-","-"],["-","-","-"],["-","-","-"]]
    
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button31: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button32: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button33: UIButton!
    
    @IBOutlet weak var quit: UIButton!
    @IBOutlet weak var replay: UIButton!
    
    @IBOutlet weak var player1MarkLabel: UILabel!
    @IBOutlet weak var player2MarkLabel: UILabel!
    
    @IBOutlet weak var currentTurnLabel: UILabel!
    var done:Bool = false
    var player1Turn:Bool = true
    var player1Mark = "X"
    var player2Mark = "O"
    var moveCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateWhoMovesFirst()
    }
    
    func setPlayerMarkLabels() -> Void {
        player1MarkLabel.text = player1Mark
        player2MarkLabel.text = player2Mark
    }
    
    func generateWhoMovesFirst() -> Void {
        let selection = Int(arc4random_uniform(2))
        if(selection == 1) {
            player1Turn = false
            currentTurnLabel.text = "Player 2's Turn"
            player1Mark = "O"
            player2Mark = "X"
        }
        setPlayerMarkLabels()
    }
    
    func lockButtons() -> Void {
        button11.enabled = false
        button21.enabled = false
        button31.enabled = false
        button12.enabled = false
        button22.enabled = false
        button32.enabled = false
        button13.enabled = false
        button23.enabled = false
        button33.enabled = false
    }
    
    func unlockButtons() -> Void {
        button11.enabled = true
        button21.enabled = true
        button31.enabled = true
        button12.enabled = true
        button22.enabled = true
        button32.enabled = true
        button13.enabled = true
        button23.enabled = true
        button33.enabled = true
    }
    
    func clearButtons(){
        
        button11.titleLabel?.text = nil
        button21.titleLabel?.text = nil
        button31.titleLabel?.text = nil
        button12.titleLabel?.text = nil
        button22.titleLabel?.text = nil
        button32.titleLabel?.text = nil
        button13.titleLabel?.text = nil
        button23.titleLabel?.text = nil
        button33.titleLabel?.text = nil
        
        button11.setTitle("", forState: .Normal)
        button21.setTitle("", forState: .Normal)
        button31.setTitle("", forState: .Normal)
        button12.setTitle("", forState: .Normal)
        button22.setTitle("", forState: .Normal)
        button32.setTitle("", forState: .Normal)
        button13.setTitle("", forState: .Normal)
        button23.setTitle("", forState: .Normal)
        button33.setTitle("", forState: .Normal)
        
    }

    @IBAction func replay(sender: AnyObject) {
        replay.hidden = true
        quit.hidden = true
        currentBoard = [["-","-","-"],["-","-","-"],["-","-","-"]]

        clearButtons()
        
        player1Mark = "X"
        player2Mark = "O"
        moveCount = 0
        player1Turn = true
        done = false
        currentTurnLabel.text = "Player 1's Turn"
        generateWhoMovesFirst()
        unlockButtons()
    }
    
    func endGame(mark: String) -> Void {
        done = true
        lockButtons();
        if(mark == player1Mark) {
            currentTurnLabel.text = "Player 1 Won!"
        } else if(mark == player2Mark){
            currentTurnLabel.text = "Player 2 Won!"
        } else if(mark == "Draw"){
            currentTurnLabel.text = "Draw"
        } else {
            print("Unrecognized symbol in endGame function")
        }
        
        replay.hidden = false
        quit.hidden = false
    }

    func checkForWinner() -> Void {
        
        var player1Result = ["-","-","-","-","-","-","-","-","-"]
        var player2Result = ["-","-","-","-","-","-","-","-","-"]
        //create comparable array of results
        for var i = 0; i < currentBoard.count; i++ {
            let temp = currentBoard[i]
            for var j = 0; j < temp.count; j++ {
                if(temp[j] == player1Mark){
                    player1Result[j+(i*3)] = temp[j]
                }else if(temp[j] == player2Mark){
                    player2Result[j+(i*3)] = temp[j]
                }
            }
        }
        print("Player 1...")
        print(player1Result)
        
        print("Player 2...")
        print(player2Result)
        
        for var i = 0; i < winningCombos.count; i++ {
            let currentWinningCombo = winningCombos[i]
            //now go through the current winning combo and check for a winner
            if((player1Result[currentWinningCombo[0]-1] == player1Mark) &&
                (player1Result[currentWinningCombo[1]-1] == player1Mark) &&
                (player1Result[currentWinningCombo[2]-1] == player1Mark)){
                    //player has beaten AI!
                    endGame(player1Mark)
            }
            else if((player2Result[currentWinningCombo[0]-1] == player2Mark) &&
                (player2Result[currentWinningCombo[1]-1] == player2Mark) &&
                (player2Result[currentWinningCombo[2]-1] == player2Mark)){
                    endGame(player2Mark)
            }
        }
        
        //if no winner exists ensure that moveCount is not 9
        if(moveCount == 9) {
            endGame("Draw")
        }
    }
    
    func swapPlayer() -> Void {
        //check for a winner ofthe game
        moveCount++
        if(moveCount > 4){
            checkForWinner()
            //if theres a winner then were done
        }
        
        if(!done){
            player1Turn = !player1Turn
            if(player1Turn){
                currentTurnLabel.text = "Player 1's Turn"
            }else{
                currentTurnLabel.text = "Player 2's Turn"
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func button11Action(sender: AnyObject) {
        print(button11.titleLabel?.text)
        if let text = button11.titleLabel?.text {
            print(text)
        } else {
            button11.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[0]
            temp = [player1Turn ? player1Mark : player2Mark,temp[1],temp[2]]
            currentBoard[0] = temp
            swapPlayer()
        }
    }
    @IBAction func button21Action(sender: AnyObject) {
        if let text = button21.titleLabel?.text {
            print(text)
        } else {
            button21.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[0]
            temp = [temp[0],player1Turn ? player1Mark : player2Mark,temp[2]]
            currentBoard[0] = temp
            swapPlayer()
        }
    }
    @IBAction func button31Action(sender: AnyObject) {
        if let text = button31.titleLabel?.text {
            print(text)
        } else {
            button31.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[0]
            temp = [temp[0],temp[1],player1Turn ? player1Mark : player2Mark]
            currentBoard[0] = temp
            swapPlayer()
        }
    }
    @IBAction func button12Action(sender: AnyObject) {
        if let text = button12.titleLabel?.text {
            print(text)
        } else {
            button12.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[1]
            temp = [player1Turn ? player1Mark : player2Mark,temp[1],temp[2]]
            currentBoard[1] = temp
            swapPlayer()
        }
    }
    @IBAction func button22Action(sender: AnyObject) {
        if let text = button22.titleLabel?.text {
            print(text)
        } else {
            button22.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[1]
            temp = [temp[0],player1Turn ? player1Mark : player2Mark,temp[2]]
            currentBoard[1] = temp
            swapPlayer()
        }
    }
    @IBAction func button32Action(sender: AnyObject) {
        if let text = button32.titleLabel?.text {
            print(text)
        } else {
            button32.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[1]
            temp = [temp[0],temp[1],player1Turn ? player1Mark : player2Mark]
            currentBoard[1] = temp
            swapPlayer()
        }
    }
    @IBAction func button13Action(sender: AnyObject) {
        if let text = button13.titleLabel?.text {
            print(text)
        } else {
            button13.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[2]
            temp = [player1Turn ? player1Mark : player2Mark,temp[1],temp[2]]
            currentBoard[2] = temp
            swapPlayer()
        }
    }
    @IBAction func button23Action(sender: AnyObject) {
        if let text = button23.titleLabel?.text {
            print(text)
        } else {
            button23.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[2]
            temp = [temp[0],player1Turn ? player1Mark : player2Mark,temp[2]]
            currentBoard[2] = temp
            swapPlayer()
        }
    }
    @IBAction func button33Action(sender: AnyObject) {
        if let text = button33.titleLabel?.text {
            print(text)
        } else {
            button33.setTitle(player1Turn ? player1Mark : player2Mark, forState: .Normal)
            var temp = currentBoard[2]
            temp = [temp[0],temp[1],player1Turn ? player1Mark : player2Mark]
            currentBoard[2] = temp
            swapPlayer()
        }
    }
}
