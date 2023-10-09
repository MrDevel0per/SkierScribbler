//
//  URL+Category.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/7/23.
//

import Foundation

extension URL {
    var category: String {
        guard let reg = FilterUtils.regexes?.last else {
            return ""
        }
        if self.relativeString.contains(reg) {
            for i in ArticleCategory.allCategories() {
                if self.relativeString.localizedCaseInsensitiveContains(i) {
                    return i
                }
            }
        }
        
        return ""
        
    }
    
    var id: String {
        
    }
    
    var isArticleURL: String {
        
    }
}
