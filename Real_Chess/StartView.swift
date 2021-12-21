//
//  StartView.swift
//  Real_Chess
//
//  Created by Supreme Leader on 17.12.2021.
//

import Foundation
import SwiftUI

struct StartView: View {
    var body: some View {
        //Text("😁")
        NavigationView{
            ZStack{
                Color.pink.ignoresSafeArea()
                VStack{
                    NavigationLink(destination: ContentView(aiEnabled: false).navigationBarHidden(true)) {
                        Text("Friend")
                    }
                    
                    NavigationLink(destination: ContentView(aiEnabled: true).navigationBarHidden(true)) {
                        Text("Computer")
                    }
                }
            }
            //.background(Color.purple)
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
