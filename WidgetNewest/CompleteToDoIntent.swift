//
//  CompleteToDoIntent.swift
//  WidgetNewestExtension
//
//  Created by EBRU KÖSE on 5.11.2024.
//

import Foundation
import AppIntents
import UIKit
import WidgetKit

struct CompleteToDoIntent : AppIntent{
    
    
    static var title: LocalizedStringResource =  "Complete To Do "
    @Parameter(title: "to do id ")
    var id : String
 
    init(){
        
    }
    init (id: String){
        self.id = id
    }
    @MainActor
    func perform() async throws -> some IntentResult {
        print("Perform function called with id: \(id)")
        if let index = SharedDatas.shared.toDos.firstIndex(where: { $0.id == id }) {
            SharedDatas.shared.toDos[index].isCompleted.toggle()
            print("Database updated at index \(index)")
            
            // Widget'ı güncelle
            WidgetCenter.shared.reloadAllTimelines()
            print("Widget timelines reloaded")
        } else {
            print("Error: ToDo item not found")
        }
        return .result()
    }

    
}

