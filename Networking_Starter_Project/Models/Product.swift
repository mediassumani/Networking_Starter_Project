//
//  Product.swift
//  ProductHunt
//
//  Created by Medi Assumani on 1/29/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation


struct Product{
    
    let id: Int
    let name: String
    let tagline: String
    let votesCount: Int
    let commentsCount: Int
    let previewImageURL: String
}

struct ProductList: Decodable {
    let posts : [Product]
}

extension Product: Decodable{
    
    enum ProductKeys: String, CodingKey{
        
        case id = "id"
        case name = "name"
        case tagline = "tagline"
        case voteCounts = "votes_count"
        case commentCounts = "comments_count"
        case thumbnailURL = "screenshot_url"
    }
    
    enum PreviewImageURLKeys: String, CodingKey{
        case imageURL = "850px"
    }
    
    init(from decoder: Decoder) throws {
        
        let productsContainer = try decoder.container(keyedBy: ProductKeys.self)
        
        id = try productsContainer.decode(Int.self, forKey: .id)
        name = try productsContainer.decode(String.self, forKey: .name)
        tagline = try productsContainer.decode(String.self, forKey: .tagline)
        votesCount = try productsContainer.decode(Int.self, forKey: .voteCounts)
        commentsCount = try productsContainer.decode(Int.self, forKey: .commentCounts)
        
        let productThumbnailContainer = try productsContainer.nestedContainer(keyedBy: PreviewImageURLKeys.self, forKey: .thumbnailURL)
        previewImageURL = try productThumbnailContainer.decode(String.self, forKey: .imageURL)
    }
}
