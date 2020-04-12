//
//  Constants.swift
//  RealmSwiftDemoRepo
//
//  Created by Abhishek Kashyap on 05/04/20.
//  Copyright © 2020 Abhishek Kashyap. All rights reserved.
//

import Foundation
struct Constants {
    
    // **** address of your ROS server, e.g.: "http://127.0.0.1:9080" and "realm://127.0.0.1:9080"

    static let MY_INSTANCE_ADDRESS = "127.0.0.1:9080" // <- update this

    static let AUTH_URL  = URL(string: "http://\(MY_INSTANCE_ADDRESS)")!
    static let REALM_URL = URL(string: "realms://\(MY_INSTANCE_ADDRESS)/RealmSwiftDemoRepo")!
}

