//
//  WishEventModel.swift
//  astkachuk_2PW2
//
//  Created by Artem Tkachuk on 30.11.2024.
//

import EventKit

protocol CalendarManaging {
    func create(eventModel: WishEventModel) -> Bool
}

struct WishEventModel: Codable {
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
}
