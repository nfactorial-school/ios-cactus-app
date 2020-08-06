//
//  Author.swift
//  Cactus
//
//  Created by Тимур Табынбаев on 8/4/20.
//  Copyright © 2020 Тимур Табынбаев. All rights reserved.
//

import Foundation

//{
//  "name": "Steven Grey",
//  "subtitle": "Professor at the Wharton School",
//  "image": "https://pbs.twimg.com/profile_images/1169919000123518978/37QQ8Una_400x400.jpg"
//}
class Author: Decodable {
    let name: String
    let subtitle: String
    let image: String
}
