//
//  URL+Category.swift
//  SkierScribbler
//
//  Created by Owen Cruz-Abrams on 10/7/23.
//

import Foundation

extension URL {
    //FIXME: We HAVE to use a Regex instead, b/c otherwise the title can contain the category and cause an error
    var category: ArticleCategory {
        if self.isArticleURL {
            let splits = self.relativeString.split(separator: "/")
            for (index, ix) in splits.enumerated() {
                // The first one is going to be skierscribbler.com
                if index <= 0 {
                    continue
                }
                
                // Check to see if the prior split was the ID (b/c then this next one is the category)
                if Int(splits[index-1]) != nil {
                    // Now loop over categories, and check to see if we can find a category in the text
                    for i in ArticleCategory.allCategories() {
                        // This is a dictionary: `name` is the key, `value` is the... value
                        if ix.lowercased() == i.key {
                            // It matched! Return the value
                            return i.value
                        }
                    }
                }
            }
            
        }
        
        // If it can't be found, return `uncategorized`.
        return .uncategorized
        
    }
    
    var id: Int {
        if self.isArticleURL {
            let splits = self.relativeString.replacingOccurrences(of: "//", with: "/").split(separator: "/").map { sub in
                String(sub)
            }
            for i in splits {
                if let myID = Int(i) {
                    return myID
                }
            }
        }
        return 0
    }
    
    var isArticleURL: Bool {
        guard let reg = FilterUtils.regexes?.last else {
            return false
        }
        if self.relativeString.contains(reg) {
            return true
        } else {
            return false
        }
    }
}

#if DEBUG
extension URL {
    static let sampleArticleURL: Self = URL(string: "https://skierscribbler.com/12125/news/deer-to-vehical-collisions/")!
}
#endif
