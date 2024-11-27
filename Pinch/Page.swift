//
//  Page.swift
//  Pinch
//
//  Created by milad marandi on 11/27/24.
//

import Foundation


struct Page:Identifiable {
    var id:Int
    var imagName:String
}


extension Page{
    var thumbnailName:String {
        return "thumb-" + imagName
    }
}

