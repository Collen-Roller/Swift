//
//  AIMatchViewController.swift
//  Tic Tac Toe
//
//  Used this guide to implement the minimax algorithm for the AI
//  http://www.codebytes.in/2014/08/minimax-algorithm-tic-tac-toe-ai-in.html
//
//
//  Created by Collen Roller on 10/10/15.
//  Copyright © 2015 CrollerDev. All rights reserved.
//

import UIKit

class AIMatchViewController: UIViewController {
    
    //necessary structures
    struct Point {
        var x:Int
        var y:Int
        
        init(x: Int, y: Int){
            self.x = x
            self.y = y
        }
        
    }
    
    var board = [[0,0,0],[0,0,0],[0,0,0]]
    var computersMove = Point(x:0,y:0)
    
    @IBOutlet weak var aiMarkLabel: UILabel!
    @IBOutlet weak var playerMarkLabel: UILabel!
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var aiLabel: UILabel!
    @IBOutlet weak var currentTurnLabel: UILabel!
    @IBOutlet weak var replay: UIButton!
    @IBOutlet weak var quit: UIButton!
    
    var moveCount = 0
    
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button31: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button32: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button33: UIButton!
    
    var done:Bool = false
    
    var playersTurn:Bool = true
    var playersMark = "X"
    var aisMark = "O"
    
    let aiInt = 1
    let playerInt = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateWhoMovesFirst()
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
    
    func endGame(mark: String) -> Void {
        done = true
        lockButtons();
        if(mark == aisMark) {
            currentTurnLabel.text = "AI Won!"
        } else if(mark == playersMark){
            currentTurnLabel.text = "Player Won!"
        } else if(mark == "Draw"){
            currentTurnLabel.text = "Draw"
        } else {
            print("Unrecognized symbol in endGame function")
        }
        //drawAnimation()
        replay.hidden = false
        quit.hidden = false
    }
    
    func setPlayerMarkLabels() -> Void {
        aiMarkLabel.text = aisMark
        playerMarkLabel.text = playersMark
    }

    func generateWhoMovesFirst() -> Void {
        let selection = Int(arc4random_uniform(2))
        if(selection == 1) {
            playersTurn = false
            currentTurnLabel.text = "AI's Turn"
            playersMark = "O"
            aisMark = "X"
            
            
            let x = Int(arc4random_uniform(3))
            let y = Int(arc4random_uniform(3))
            placeAMove(Point(x:x, y:y), player: aiInt)
            showAIMove(Point(x:x, y:y))
            swapPlayer()
        }
        setPlayerMarkLabels()
    }
    
    func hasWon(target:Int) -> Bool {
        
        if((board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0] == target) || (board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2] == target)){
            return true
        }
        for var i = 0; i < 3; ++i {
            if ((board[i][0] == board[i][1] && board[i][0] == board[i][2] && board[i][0] == target)
            || (board[0][i] == board[1][i] && board[0][i] == board[2][i] && board[0][i] == target)){
                return true
            }
        }
        return false
    }
  
    
    func swapPlayer() -> Void {
        //check for a winner ofthe game
        moveCount++
        print(moveCount)
        if(moveCount > 4){
            if(moveCount == 9){
                //game is over
                if(hasWon(aiInt)){
                    endGame(aisMark)
                }else if(hasWon(playerInt)){
                    endGame(playersMark)
                }else{
                    endGame("Draw")
                }
            }else{
                if(hasWon(aiInt)){
                    endGame(aisMark)
                }else if(hasWon(playerInt)){
                    endGame(playersMark)
                }else{
                    print("No winner yet")
                }
            }
        }
        
        if(!done){
            playersTurn = !playersTurn
            if(playersTurn){
                currentTurnLabel.text = "Player's Turn"
            }else{
                currentTurnLabel.text = "AI's Turn"
            }
        }
    }
    
    func getAvailableStates() -> [Point]{
        var points = [Point]()
        for var row = 0; row < board.count; ++row {
            var columns = board[row]
            for var column = 0; column < columns.count; ++column {
                if(columns[column] == 0) {
                    points.append(Point(x:row,y:column))
                }
            }
        }
        //print(points)
        return points
    }
    
    
    func newMax(x: Int, y: Int) -> Int {
        if(x > y) {
            return x
        }
        return y
    }
    
    func newMin(x :Int, y: Int) -> Int {
        if(x < y) {
            return x
        }
        return y
    }
    
    func getPlayersMark(player:Int) -> String{
        if(player == 1){
            return playersMark
        }
        return aisMark
    }
    
    func placeAMove(point: Point, player:Int){
        board[point.x][point.y] = player
    }
    
    func minimax(depth: Int, turn: Int) -> Int {
        if(hasWon(aiInt)){ //ai
            return +1
        }
        if(hasWon(playerInt)){ //user
            return -1
        }
        
        let pointsAvailable:[Point] = getAvailableStates()
        //print("available point : \(pointsAvailable)")
        
        if(pointsAvailable.isEmpty){
            return 0
        }
        
        var max:Int = -2147483648  // minValue is equal to 0, and is of type UInt8
        
        var min:Int = 2147483647
        
        for var i = 0; i < pointsAvailable.count; ++i {
            let point:Point = pointsAvailable[i]
            if(turn == 1){
                placeAMove(point, player: aiInt)
                let currentScore = minimax(depth + 1, turn: playerInt)
                max = newMax(currentScore, y: max)
                
                if(depth == 0){
                    print("Score for positon \(i+1) = \(currentScore)")
                }
                if(currentScore >= 0){
                    if(depth == 0){
                        computersMove = point
                    }
                }
                if(currentScore == 1){
                    board[point.x][point.y] = 0
                    break
                }
                
                if(i == pointsAvailable.count-1 && max < 0){
                    if(depth == 0){
                        computersMove = point
                    }
                }
            } else if (turn == 2) {
                placeAMove(point, player: playerInt);
                let currentScore = minimax(depth + 1, turn: aiInt);
                min = newMin(currentScore, y: min);
                if(min == -1){
                    board[point.x][point.y] = 0;
                    break;
                }
            }
            board[point.x][point.y] = 0; //Reset this point
        }
        return turn == aiInt ? max : min;
    }
    
    func showAIMove(move: Point) -> Void {
        if(move.x == 0){
            if(move.y == 0){
                button13.setTitle(aisMark, forState: .Normal)
            }else if(move.y == 1){
                button23.setTitle(aisMark, forState: .Normal)
            }else if(move.y == 2){
                button33.setTitle(aisMark, forState: .Normal)
            }else {
                print("arrempting to show an ai move that isunrecognized (y:\(move.y)")
            }
        }else if(move.x == 1){
            if(move.y == 0){
                button12.setTitle(aisMark, forState: .Normal)
            }else if(move.y == 1){
                button22.setTitle(aisMark, forState: .Normal)
            }else if(move.y == 2){
                button32.setTitle(aisMark, forState: .Normal)
            }else {
                print("arrempting to show an ai move that isunrecognized (y:\(move.y)")
            }
        }else if(move.x == 2){
            if(move.y == 0){
                button11.setTitle(aisMark, forState: .Normal)
            }else if(move.y == 1){
                button21.setTitle(aisMark, forState: .Normal)
            }else if(move.y == 2){
                button31.setTitle(aisMark, forState: .Normal)
            }else {
                print("arrempting to show an ai move that isunrecognized (y:\(move.y)")
            }
        }else {
            print("attemping toshow an ai move that is unrecognized (x:\(move.x)")
        }
    }
    
    func moveAI() -> Void {
        
        lockButtons()
        minimax(0, turn: 1)
        placeAMove(computersMove, player: 1)
        showAIMove(computersMove)
        swapPlayer()
        unlockButtons()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func button11Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button11.titleLabel?.text {
                print(text)
            } else {
                button11.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:2,y:0), player: playerInt)
                swapPlayer()
                moveAI()
            }
        }
    }
    @IBAction func button21Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button21.titleLabel?.text {
                print(text)
            } else {
                button21.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:2,y:1), player: playerInt)
                swapPlayer()
                moveAI()
            }
        }
    }
    @IBAction func button31Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button31.titleLabel?.text {
                print(text)
            } else {
                button31.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:2,y:2), player: playerInt)
                swapPlayer()
                moveAI()
            }
        }
    }
    @IBAction func button12Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button12.titleLabel?.text {
                print(text)
            } else {
                button12.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:1,y:0), player: playerInt)
                swapPlayer()
                moveAI()
            }
        }
    }
    @IBAction func button22Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button22.titleLabel?.text {
                print(text)
            } else {
                button22.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:1,y:1), player: playerInt)
                swapPlayer()
                moveAI()
                
            }
        }
    }
    @IBAction func button32Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button32.titleLabel?.text {
                print(text)
            } else {
                button32.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:1,y:2), player: playerInt)
                swapPlayer()
                moveAI()
            
            }
        }
    }
    @IBAction func button13Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button13.titleLabel?.text {
                print(text)
            } else {
                button13.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:0,y:0), player: playerInt)
                swapPlayer()
                moveAI()
            }
        }
    }
    @IBAction func button23Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button23.titleLabel?.text {
                print(text)
            } else {
                button23.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:0,y:1), player: playerInt)
                swapPlayer()
                moveAI()
                
            }
        }
    }
    @IBAction func button33Action(sender: AnyObject) {
        if(playersTurn){
            if let text = button33.titleLabel?.text {
                print(text)
            } else {
                button33.setTitle(playersMark, forState: .Normal)
                placeAMove(Point(x:0,y:2), player: playerInt)
                swapPlayer()
                moveAI()
            }
        }
    }
    
    @IBAction func replay(sender: AnyObject) {
        replay.hidden = true
        quit.hidden = true
        board = [[0,0,0],[0,0,0],[0,0,0]]
        computersMove = Point(x: 0,y: 0)
        
        clearButtons()
        
        playersMark = "X"
        aisMark = "O"
        moveCount = 0
        playersTurn = true
        done = false
        
        currentTurnLabel.text = "Players Turn"
        generateWhoMovesFirst()
        unlockButtons()
    }
}
