//
//  TabViewPage.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct TabViewPage: View {
    var body: some View {
        List {
            ContentRow(title: "default").navigationLink {
                automatic
            }
            
            ContentRow(title: "page").navigationLink {
                page
            }
        }
        .navigationTitle("TabView")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var automatic: some View {
        TabView {
            Text("1")
                .tabItem {
                    Label("1", systemImage: "1.circle")
                }
            Text("2")
                .tabItem {
                    Label("2", systemImage: "2.circle")
                }
        }
        .tabViewStyle(.automatic)
    }
    
    var page: some View {
        TabView {
            ForEach(0..<10) { index in
                Rectangle()
                    .fill(Color.random)
                    .overlay(
                        Text(String(index)).foregroundColor(.white)
                    )
                    .tag(index)
                    .tabItem {
                        Label("\(index)", systemImage: "\(index).circle")
                    }
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}


struct TabViewPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TabViewPage()
        }
    }
}
