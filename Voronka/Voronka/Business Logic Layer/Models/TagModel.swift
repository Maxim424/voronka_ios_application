//
//  TagModel.swift
//  Voronka
//
//  Created by Danil Shvetsov on 09.02.2023.
//

import UIKit

struct Tag: Codable {
    let id: Int
    let title: String
}

struct TagCategoriesModel: Codable {
    let categoryId: Int?
    let title: String?
    let tags: [TagModel]?
}

struct TagModel: Codable {
    let tagId: Int?
    let title: String?
}
