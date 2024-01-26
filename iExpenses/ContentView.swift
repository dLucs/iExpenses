//
//  ContentView.swift
//  iExpenses
//
//  Created by Lucas on 26/1/24.
//

import SwiftUI

// Create the expense item that follows the Identifiable protocol
struct expenseItem: Identifiable{
    let name: String
    let type: String
    let amount: Double
    let id = UUID()
}
//Create expenses class
@Observable
class Expenses {
    var items = [expenseItem]()
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationStack {
            //Iterate over all the items in expenses
            List{
                ForEach(expenses.items) {
                    item in Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpenses")
            .toolbar{
                //Add new expense item to expenses
                Button("Add Expense", systemImage: "plus"){
                    showAddExpense = true
                }
            }
            .sheet(isPresented: $showAddExpense ){
               AddView(expenses: expenses)
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
