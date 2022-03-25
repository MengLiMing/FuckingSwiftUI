//
//  NavigationViewPage.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/25.
//

import SwiftUI

struct NavigationViewPage: View {
    var body: some View {
        List {
            Text("Hello World")
            TextField("--", text: .constant(""))
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Navigation-Toolbar")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    
                } label: {
                    Image(systemName: "archivebox")
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Spacer()
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Text("Leading")
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("Trailing")
            }

            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    
                    Button("Done") {
                        hideKeyboard()
                    }
                }
            }
        }
    }
}

struct NavigationViewPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationViewPage()
        }
    }
}
