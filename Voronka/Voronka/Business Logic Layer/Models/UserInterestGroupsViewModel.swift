//
//  InterestGroupsViewModel.swift
//  Voronka
//
//  Created by Danil Shvetsov on 09.02.2023.
//

import UIKit

struct UserInterestGroupsViewModel: Codable {
    
    let id: Int
    
    let name: String
    
    let tags: [Tag]
    
}
