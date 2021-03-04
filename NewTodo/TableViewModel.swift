//
//  TableViewModel.swift
//  NewTodo
//
//  Created by Distillery on 2/27/21.
//

import Foundation

var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "toDoItemsKey");
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let arr = UserDefaults.standard.array(forKey: "toDoItemsKey") as? [[String: Any]] {
            return arr
        } else {
            return []
        }
    }
}

func addItem(item: String, isCompleted: Bool = false) {
    toDoItems.append(["name": item, "isCompleted": isCompleted]);
}

func removeItem(at index: Int) {
    toDoItems.remove(at: index)
}

func changeState(at index: Int) -> Bool{
    toDoItems[index]["isCompleted"] = !(toDoItems[index]["isCompleted"] as! Bool)
    return toDoItems[index]["isCompleted"] as! Bool
}

func changeOrder(fromIndex: Int, toIndex: Int) {
    let temp = toDoItems[fromIndex];
    toDoItems[fromIndex] = toDoItems[toIndex];
    toDoItems[toIndex] = temp;
}
