//
//  ContentView.swift
//  iExpenses
//
//  Created by Lucas on 26/1/24.
//

import SwiftUI

// Create the expense item that follows the Identifiable and Codable protocol
struct expenseItem: Identifiable, Codable{
    let name: String
    let type: String
    let amount: Double
    var id = UUID()
}
//Create expenses class with JSON encoder
@Observable
class Expenses {
    var items = [expenseItem](){
        didSet {
            if let encoded =  try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
                
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([expenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showAddExpense = false
    
    var body: some View {
        NavigationStack {
            //Iterate over all the items in expenses
            List{
                ForEach(expenses.items) {
                    item in HStack{
                        VStack(alignment: .leading){
                            Text(item.name)
                                .font(.headline)
                            
                            item.type == "Personal" ?
                            Text(item.type) .foregroundColor(.blue) : Text(item.type).foregroundColor(.orange)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "EUR"))
                    }
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
