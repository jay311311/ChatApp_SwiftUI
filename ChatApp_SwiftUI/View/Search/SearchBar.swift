//
//  SearchBar.swift
//  ChatApp_SwiftUI
//
//  Created by Jooeun Kim on 2024-05-14.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var shouldBecomeFirstResponder: Bool
    
    var onClickSearchBtn: (() -> Void)?
    
    init(text: Binding<String>,
         shouldBecomeFirstResponder: Binding<Bool>,
         onClickSearchBtn: (() -> Void)?) {
        self._text = text
        self._shouldBecomeFirstResponder = shouldBecomeFirstResponder
        self.onClickSearchBtn = onClickSearchBtn
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func makeCoordinator() -> Coordinate {
        return Coordinate(text: $text,
                          shouldBecomeFirstResponder: $shouldBecomeFirstResponder,
                          onClickSearchBtn: onClickSearchBtn)
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        updateSearchText(uiView, context: context)
        updateBecomeFirstResponder(uiView, context: context)
    }
    
    private func updateSearchText(_ searchBar: UISearchBar, context: Context) {
        context.coordinator.setSearchText(searchBar, text: text)
    }
    
    private func updateBecomeFirstResponder(_ searchBar: UISearchBar, context: Context) {
        guard searchBar.canBecomeFirstResponder else { return }
        
        DispatchQueue.main.async {
            if shouldBecomeFirstResponder {
                guard !searchBar.isFirstResponder else { return }
                searchBar.becomeFirstResponder()
            } else {
                guard searchBar.isFirstResponder else { return }
                searchBar.resignFirstResponder()
            }
        }
    }


}

extension SearchBar {
    class Coordinate: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var shouldBecomeFirstResponder: Bool
        var onClickSearchBtn: (() -> Void)?
        
        init(text: Binding<String>,
             shouldBecomeFirstResponder: Binding<Bool>,
             onClickSearchBtn: (() -> Void)?) {
            self._text = text
            self._shouldBecomeFirstResponder = shouldBecomeFirstResponder
            self.onClickSearchBtn = onClickSearchBtn
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text =  searchText
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            shouldBecomeFirstResponder = true
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            shouldBecomeFirstResponder = false
        }
        
        func setSearchText(_ searchBar: UISearchBar, text: String) {
            searchBar.text = text
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            onClickSearchBtn?()
        }
    }
}
