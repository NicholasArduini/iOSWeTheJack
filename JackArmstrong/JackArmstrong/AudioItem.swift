//
//  AudioItem.swift
//  JackArmstrong
//
//  Created by Nicholas Arduini on 4/17/19.
//  Copyright © 2019 Nicholas Arduini. All rights reserved.
//

import Foundation

struct AudioItem {
    var fileName : String
    var title: String
    
    init(fileName : String, title : String){
        self.fileName = fileName
        self.title = title
    }
}

