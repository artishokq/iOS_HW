//
//  WishEventModel.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 30.11.2024.
//

import Foundation

struct WishEventModel: Codable {
    var title: String = "Title"
    var description: String = "Description"
    var startDate: String
    var endDate: String
}
