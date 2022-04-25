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
                `operator`

                publisher
                                
                example
            }
            .navigationTitle("FuckingCombine")
        }
        /// 使用stack-style，否则退出页面后倒计时未结束
        .navigationViewStyle(.stack)
    }
    
    var `operator`: some View {
        Section("Operator") {
            Cell(title: "操作符") {
                OperatorView()
            }
        }
    }
    
    var example: some View {
        Section("Example") {
            Cell(title: "网络") {
                NetworkView()
            }
            
            Cell(title: "权限") {
                ContactStoreView()
            }
            
            Cell(title: "登录") {
                LoginView()
            }
            
            Cell(title: "通知") {
                NotificationView()
            }
            
            Cell(title: "SwiftUI监听Publisher") {
                OnReceiveView()
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
            
            Cell(title: "Record") {
                RecordView()
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

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
