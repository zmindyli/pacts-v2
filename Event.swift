//
//  EventType.swift
//  Pacts
//
//  Created by Angela Chen on 8/29/20.
//  Copyright © 2020 Angela Chen. All rights reserved.
//

import Foundation

class Event {
    
    var name: String
    
    //var imageString: String
    //for now string but later of type catagory
    //change
    var type: [String]!
    var time: String
    
    //change catagory type
    init(name: String, type: [String]!, time: String) {
        self.name = name
        self.type = type
        self.time = time
        
    }
}
