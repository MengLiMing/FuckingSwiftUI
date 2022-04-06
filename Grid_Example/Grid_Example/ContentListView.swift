//
//  ContentListView.swift
//  Grid_Example
//
//  Created by Ming on 2022/4/1.
//

import SwiftUI

struct ContentListView: View {
    var body: some View {
        NavigationView {
            List {
                fixed
                flexible
                adaptive
                mix
            }
            .navigationTitle("Grid")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var fixed: some View {
        Section("Fixed") {
            RowView(title: "fixed") {
                FixedView()
            }
            
            RowView(title: "fixed + fixed") {
                Fixed_Fixed()
            }
        }
    }
    
    var flexible: some View {
        Section("Flexible") {
            RowView(title: "flexible") {
                Flexible()
            }
            
            RowView(title: "flexible + flexible") {
                Flexible_Flexible()
            }
        }
    }
    
    var adaptive: some View {
        Section("Adaptive") {
            RowView(title: "adaptive") {
                Adaptive()
            }
            
            RowView(title: "adaptive + adaptive") {
                Adaptive_Adaptive()
            }
        }
    }
    
    var mix: some View {
        Section("Mix") {
            RowView(title: "flexible + fixed + flexible") {
                Flexible_Fixed_Flexible()
            }
            
            RowView(title: "flexible + fixed + adaptive + fixed") {
             Flexible_Fixed_Adaptive_Fixed()
            }
        }
    }
    
}

extension ContentListView {
    struct RowView<Content>: View where Content: View {
        let title: String
        
        @ViewBuilder var destination: () -> Content
        
        var body: some View {
            NavigationLink {
                destination()
            } label: {
                Text(title)
                    .font(.headline)
            }
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView()
    }
}
