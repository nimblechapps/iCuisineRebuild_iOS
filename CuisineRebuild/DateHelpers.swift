//
//  DateHelpers.swift
//  CuisineRebuild
//
//  Created by Rajiv Patil on 05/10/17.
//  Copyright © 2017 Rajiv Patil. All rights reserved.
//

import Foundation



class DateHelpers {
    
    
    class func getDateByAddingMinutes(minutes : Double) -> Date{
        return Date().addingTimeInterval(minutes * 60.0)
    }
    
    class func getFormattedTimeRemaining(dueDate : Date) -> (formattedTime : String , isComplete : Bool){
        
        let now = Date()
        let secondsRemaining = dueDate.timeIntervalSince(now)
        
        if Int(secondsRemaining) == 0{
            return (secondsRemaining.formattedTime, true)
        }
        return (secondsRemaining.formattedTime, false)
    }
    
    
    
    
    
    
    
    
}



