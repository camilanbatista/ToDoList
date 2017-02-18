//
//  DateExtension.swift
//  TodoList
//
//  Created by ios on 18/02/17.
//  Copyright © 2017 com.fa7. All rights reserved.
//

import Foundation

extension Date{

    func toString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func toString(format:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func toDate(date:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.date(from: date)!
    }

}
