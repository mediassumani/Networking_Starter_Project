//
//  Result.swift
//  ProductHunt
//
//  Created by Medi Assumani on 2/16/19.
//  Copyright © 2019 Medi Assumani. All rights reserved.
//

import Foundation

enum Result<T> {
    
    case success(T)
    case failure(Error)

}
