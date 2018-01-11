//
//  Item.swift
//  TodoeyUserDefaults
//
//  Created by Kajal on 1/9/18.
//  Copyright © 2018 Kajal. All rights reserved.
//

import Foundation
class Item: Encodable, Decodable{
    var title : String = ""
    var done : Bool = false
}
