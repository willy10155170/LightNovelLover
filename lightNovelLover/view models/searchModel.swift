//
//  searchModel.swift
//  lightNovelLover
//
//  Created by Shiroha on 2022/1/12.
//

import Foundation
import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var searchText: String
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        
        let action = UIAction { action in
            guard let textField = action.sender as? UITextField else { return }
            searchText = textField.text!
            textField.endEditing(true)
        }
        searchBar.searchTextField.addAction(action, for: .editingDidEndOnExit)
        return searchBar
    }
    
    func updateUIView(_ uiview: UISearchBar, context: Context) {
        
    }
    
    typealias UIViewType = UISearchBar
}
