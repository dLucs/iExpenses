//
//  ContentView.swift
//  iExpenses
//
//  Created by Lucas on 26/1/24.
//

import SwiftUI

// Create the expense item
struct expenseItem{
    let name: String
    let type: String
    let amount: Double
}
//Create expenses class
@Observable
class Expenses {
    var items = [expenseItem]()
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    
    var body: some View {
        NavigationStack {
            //Iterate over all the items in expenses
            List{
                ForEach(expenses.items, id: \.name) {
                    item in Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpenses")
            .toolbar{
                //Add new expense item to expenses
                Button("Add Expense", systemImage: "plus"){
                    let expense  = expenseItem(name: "Test", type: "personal", amount: 6)
                    expenses.items.append(expense)
                }
            }
        }
        
    }
    //remove items at specific offsets
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
