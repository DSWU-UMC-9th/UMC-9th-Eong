//
//  Router.swift
//  Megabox
//
//  Created by 권예원 on 10/3/25.
//

import SwiftUI
import Observation

@Observable
class Router {
    var path = NavigationPath()
    
    func push(_ route: Route){
        path.append(route)
    }
    
    func pop(){
        if path.isEmpty == false {
            path.removeLast()
        }
    }
    
    func reset(){
        path = NavigationPath()
    }
}

