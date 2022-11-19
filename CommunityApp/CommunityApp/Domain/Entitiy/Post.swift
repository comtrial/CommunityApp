//
//  Post.swift
//  CommunityApp
//
//  Created by kimseongjun on 2022/11/09.
//

import Foundation

struct PostService: Codable {
    var post: String
    var author: String
    var tag: String
    var images: [String]
}

struct ImagePostService: Codable {
    var url: String
}
