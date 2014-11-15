//
//  ListOfFacts.swift
//  FunFacts
//
//  Created by Collen Roller on 11/2/14.
//  Copyright (c) 2014 Collen Roller. All rights reserved.
//

import Foundation
import Darwin

class ListOfFacts {
    
    var factList  : [String]
    
    var position : Int
    
    init(){
        self.factList = []
        self.position = 0
        self.readInFile()
        position = factList.count-1
    }

    //read in facts
    func readInFile(){
        let path = NSBundle.mainBundle().pathForResource("ListOfFacts", ofType: "dat")
        var possibleContent = String(contentsOfFile:path!, encoding: NSUTF8StringEncoding, error: nil)
        
        if let content = possibleContent {
            factList = content.componentsSeparatedByString("\n")
            
            //println(factList)
        }
    }
    
    
    func getRandomFact() -> String {
        position++
        while(factList[position-1].isEmpty && position < factList.count){
            if(position == factList.count-1){
                shuffle()
            }
            position++
        }
        return factList[position-1]
    }
    
    func needsShuffle() -> Bool {
        if(position == factList.count-1){
            return true
        }
        return false
    }
    
    func shuffle() {
        factList = shuffle(factList)
        position = 0
    }
    
    func shuffle(var list : [String]) -> [String] {
        for i in 0..<(list.count - 1){
            let j = Int(arc4random_uniform(UInt32(list.count - i))) + i
            swap(&list[i], &list[j])
        }
        return list
    }
    
    
    
}


