//
//  NavigationLinkView.swift
//  FuckingSwiftUI
//
//  Created by Ming on 2022/3/24.
//

import SwiftUI

struct NavigationLinkView: View {
    var body: some View {
        VStack {
            NavigationLink {
                SecondView()
            } label: {
                Text("点我push")
            }
        }
        .navigationTitle("NavigationLink")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    SecondView()
                } label: {
                    Text("push")
                }
            }
        }
    }
    
    struct SecondView: View {
        @Environment(\.presentationMode) var presentation
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            Button {
                dismiss()
            } label: {
                Text("点我pop")
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("pop") {
                        presentation.wrappedValue.dismiss()
                    }
                }
            }
            
        }
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NavigationLinkView()
        }
    }
}
