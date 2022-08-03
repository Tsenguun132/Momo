//
//  HomeView.swift
//  Momo
//
//  Created by Tsenguun on 2/8/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HeaderView()
            
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
            CardView().previewLayout(.sizeThatFits)
        }
    }
}


struct HeaderView: View {
    
    
    var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text("Good afternoon,")
                        .font(.system(.subheadline, design: .default))
                    
                    Text("Tsenguun")
                        .font(.system(.title2))
                        .fontWeight(.semibold)
                }
                .padding()
                Spacer()
                
                Image(systemName: "bell")
                    .font(.title)
    //                .foregroundColor(.white)
            }
    }
}


struct CardView: View {
    
    
    var body: some View {
        Text("Card View")
    }
}
