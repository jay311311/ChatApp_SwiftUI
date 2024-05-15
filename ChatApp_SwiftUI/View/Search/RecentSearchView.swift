//
//  RecentSearchView.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-14.
//

import SwiftUI

struct RecentSearchView: View {
    @Environment(\.managedObjectContext) var objectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var results: FetchedResults<SearchResult>
    
    var onTapResult: ((String?) -> Void)

    var body: some View {
        VStack(spacing: 0) {
            titleView
                .padding(.bottom, 20)
            
            if results.isEmpty {
                    Text("There is no search history.")
                        .font(.system(size: 10))
                        .foregroundColor(.greyDeep)
                        .padding(.vertical, 54)
                    Spacer()
            } else {
                ScrollView {
                    LazyVStack{
                        ForEach(results, id: \.self) { result in
                            HStack{
                                Button {
                                    onTapResult(result.name)
                                } label: {
                                    Text(result.name ?? "")
                                        .font(.system(size: 14))
                                        .foregroundColor(.bkText)
                                }
                                Spacer()
                                Button {
                                    objectContext.delete(result)
                                    
                                    try? objectContext.save()
                                } label: {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 15, height: 15)
                                }

                            }
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 30)
    }
    
    var titleView: some View {
        HStack {
            Text("Recent Keyword")
                .font(.system(size: 10, weight: .bold))
            Spacer()
        }
    }
}

#Preview {
    RecentSearchView{ _ in
        
    }
}
