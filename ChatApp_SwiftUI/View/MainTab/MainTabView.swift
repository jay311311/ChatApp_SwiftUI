//
//  MainTabView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-24.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @EnvironmentObject var container: DiContainer
    @State private var selecteItem: MainTabType = .house

    var body: some View {
        TabView(selection: $selecteItem){
            ForEach(MainTabType.allCases, id: \.self) { tab in
                
                Group {
                    switch tab{
                    case .house:
                        HomeView(viewModel: .init(container: container, userId: authViewModel.userId ?? ""))
                    case .message:
                        MessageView()
                    case .phone:
                        CallView()
                    }
                }.tabItem {
                    Label(tab.title, systemImage: tab.imageName(selected: selecteItem == tab) )
                }
                .tag(tab)
            }
        }.tint(.lineApp)
    }
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.greyFix)
    }
}

#Preview {
    MainTabView()
}
