//
//  HomeView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-04-25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var container: DiContainer
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        
        NavigationStack(path: $container.navigator.destinations) {
            contentView
                .fullScreenCover(item: $viewModel.modalDestination) {
                    switch $0 {
                    case .myProfile:
                        MyProfileView(viewModel: .init(userId: viewModel.userId, container: container))
                    case let .otherProfile(userId):
                        OtherProfileView(viewModel: .init(userId: userId, container: container)) { otherUser in viewModel.send(action: .goToChat(otherUser))
                        }
                        
                    case .setting:
                        SettingView()
                    }
                }
                .navigationDestination(for: NavigatorDestination.self) {
                    NavigatorRoutingView(destination: $0)
                }
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch viewModel.phase {
        case .notRequested:
            PlaceholderView()
                .onAppear {
                    viewModel.send(action: .load)
                }
        case .loading:
            LoadingView()
        case .success:
            loadedView
                .toolbar {
                    Image(systemName: "bookmark")
                    Image(systemName: "bell")
                    Image(systemName: "person.badge.plus")
                    Button {
                        viewModel.send(action: .presentView(.setting))
                    } label: {
                        Image(systemName:"gearshape")
                            .tint(.black)
                    }
                }
        case .fail:
            ErrorView()
        }
    }
    
    var loadedView: some View {
        ScrollView {
            profileView
                .padding(.bottom, 30)
            
            NavigationLink(value: NavigatorDestination.search(userId: viewModel.userId)) {
                SearchButton()
            }
            .padding(.bottom, 24)
            
            HStack {
                Text("friend")
                    .font(.system(size: 14))
                    .foregroundColor(.bkText)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
            }
            .padding(.horizontal, 30)
            
            if viewModel.users.isEmpty {
                Spacer(minLength: 89)
                emptyView
            } else {
                LazyVStack {
                    ForEach(viewModel.users) { user in
                        HStack(spacing: 8) {
                            URLImageView(urlString: user.profileURL)
                                .foregroundStyle(.greyFix)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())

                            Text(user.name)
                                .font(.system(size: 12))
                                .foregroundColor(.bkText)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.send(action: .presentView(.otherProfile(user.id)))
                        }
//                        .accessibilityElement(children: .ignore)
//                        .accessibilityLabel(user.name)
//                        .accessibilityAddTraits(.isButton)
                    }
                    .padding(.horizontal, 30)
                }
            }
        }
    }
    
    var profileView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 7) {
                Text(viewModel.myUser?.name ?? "Name")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.bkText)
                Text(viewModel.myUser?.description ?? "Please enter a status message")
                    .font(.system(size: 12))
                    .foregroundColor(.greyDeep)
            }
            
            Spacer()
            
            URLImageView(urlString: viewModel.myUser?.profileURL)
                .foregroundStyle(.greyFix)
                .frame(width: 40, height: 40)
                .clipShape(Circle())

        }
        .padding(.horizontal, 30)
        .onTapGesture {
            viewModel.send(action: .presentView(.myProfile))
        }
//        .accessibilityElement(children: .combine)
//        .accessibilityHint(Text("내 프로필을 보려면 이중탭하십시오."))
//        .accessibilityAction {
//            viewModel.send(action: .presentView(.myProfile))
//        }
    }
    
    var emptyView: some View {
        VStack {
            VStack(spacing: 3) {
                Text("친구를 추가해보세요.")
                    .foregroundColor(.bkText)
                Text("큐알코드나 검색을 이용해서 친구를 추가해보세요.")
                    .foregroundColor(.greyDeep)
            }
            .font(.system(size: 14))
            .padding(.bottom, 30)
            
            Button {
                viewModel.send(action: .requestContacts)
            } label: {
                Text("친구추가")
                    .font(.system(size: 14))
                    .foregroundColor(.bkText)
                    .padding(.vertical, 9)
                    .padding(.horizontal, 24)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyLight)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let container: DiContainer = .stub
    
    static var previews: some View {
        HomeView(viewModel: .init(container: Self.container, userId: "user1_id"))
            .environmentObject(Self.container)
    }
}
