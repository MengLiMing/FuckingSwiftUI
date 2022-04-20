//
//  RootView.swift
//  FuckingCombine
//
//  Created by Ming on 2022/4/19.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            List {
                publisher
                
                `operator`
                
                example
            }
            .navigationTitle("FuckingCombine")
        }
        /// 使用stack-style，否则退出页面后倒计时未结束
        .navigationViewStyle(.stack)
    }
    
    var example: some View {
        Section("Example") {
            Cell(title: "Network") {
                NetworkView()
            }
            
            Cell(title: "权限") {
                ContactStoreView()
            }
        }
    }
    
    var `operator`: some View {
        Section("Operator") {
            Cell(title: "Share") {
                ShareView()
            }
            
            Cell(title: "Multicast") {
                MulticastView()
            }
            
            Cell(title: "MeasureInterval") {
                MeasureIntervalView()
            }
        }
    }
    
    var publisher: some View {
        Section("Publisher") {
            Cell(title: "Just") {
                JustView()
            }
            
            Cell(title: "Future") {
                FutureView()
            }
            
            Cell(title: "Deferred") {
                DeferredView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

extension RootView {
    struct Cell<Content: View>: View {
        var title: String
        
        @ViewBuilder let content: () -> Content
        
        var body: some View {
            NavigationLink {
               content()
            } label: {
                Text(title)
                    .font(.headline)
            }
        }
    }
}