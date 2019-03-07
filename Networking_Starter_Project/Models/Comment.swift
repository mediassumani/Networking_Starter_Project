//
//  Comment.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/8/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation


struct CommentApiResponse: Decodable {
    let comments: [Comment]
}


struct Comment: Decodable {
    let id: Int
    let body: String
}
