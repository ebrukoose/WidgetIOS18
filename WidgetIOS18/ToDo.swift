//
//  ToDo.swift
//  WidgetIOS18
//
//  Created by EBRU KÖSE on 31.10.2024.
//

import Foundation

struct ToDo: Identifiable{
    
    var id: String = UUID().uuidString
    var name: String = ""
    var isCompleted: Bool = false
}

class SharedDatas : ObservableObject{
    static let shared = SharedDatas()
    
    @Published var  toDos : [ToDo] = [
        .init(name: "ebru"),
        .init(name: "kose"),
        .init(name: "taylor")
    ]
}
