//
//  ContentView.swift
//  Momo
//
//  Created by Tsenguun on 2/8/22.
//

import SwiftUI
import CoreData

struct EntryView: View {
    init() {
        
        let image = UIImage.gradientImageWithBounds(
            bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 8),
            colors: [
                UIColor.clear.cgColor,
                UIColor.black.withAlphaComponent(0.1).cgColor
            ]
        )
        
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.systemGray6
        
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = image
        
        UITabBar.appearance().standardAppearance = appearance
    }
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var selection = 0

    var body: some View {
        
        ZStack {
            TabView(selection: $selection) {
                
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                StatisticView()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Stats")
                    }
                    .tag(1)
                
                
                if selection == 0 {
                    Spacer()
                }
                
                WalletView()
                    .tabItem {
                        Image(systemName: "creditcard")
                        Text("Wallet")
                    }
                    .tag(2)
                
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.square")
                        Text("Profile")
                    }
                    .tag(3)
                
            }
            .accentColor(Color(red: 84/255, green: 153/255, blue: 148/255)) // will be deprecated in ios 16 rgb(84, 153, 148)
            .onAppear() {
                UITabBar.appearance().backgroundColor = .white
            }
            
            if selection == 0 {
                VStack {
                    Spacer()
                    Button {
                        print("button pressed")
                    } label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .padding(15)
                            .background(Color(red: 84/255, green: 153/255, blue: 148/255))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                    }
                    .shadow(color: .gray, radius: 5)
                }
            }
        }
    }
    
}



struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


//
//private func addItem() {
//    withAnimation {
//        let newItem = Item(context: viewContext)
//        newItem.timestamp = Date()
//
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
//
//private func deleteItems(offsets: IndexSet) {
//    withAnimation {
//        offsets.map { items[$0] }.forEach(viewContext.delete)
//
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()
