//
//  PictureModel.swift
//  PicturesNetwork
//
//  Created by OMac on 8/21/19.
//  Copyright © 2019 OMac. All rights reserved.
//

import UIKit
import Foundation

typealias Pictures = [PictureModel]

// MARK: - SearchResponse
class SearchResponse: Codable {
    let total: Int?
    let totalPages: Int?
    let results: Pictures?
    
    enum CodingKeys: String, CodingKey {
        case total = "total"
        case totalPages = "total_pages"
        case results = "results"
    }
    
    init(total: Int?, totalPages: Int?, results: Pictures?) {
        self.total = total
        self.totalPages = totalPages
        self.results = results
    }
}

class PictureModel: Codable {
    let id: String?
    let createdAt, updatedAt: String?
    let width, height: Int?
    let color, pictureDescription, altDescription: String?
    let urls: Urls?
    let links: PictureLinks?
    let likes: Int?
    let likedByUser: Bool?
    let user: User?
    let sponsorship: Sponsorship?
    
    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case pictureDescription = "description"
        case altDescription = "alt_description"
        case urls, links, likes
        case likedByUser = "liked_by_user"
        case user, sponsorship
    }
    
    init(id: String?, createdAt: String?, updatedAt: String?, width: Int?, height: Int?, color: String?, pictureDescription: String?, altDescription: String?, urls: Urls?, links: PictureLinks?, likes: Int?, likedByUser: Bool?, user: User?, sponsorship: Sponsorship?) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.width = width
        self.height = height
        self.color = color
        self.pictureDescription = pictureDescription
        self.altDescription = altDescription
        self.urls = urls
        self.links = links
        self.likes = likes
        self.likedByUser = likedByUser
        self.user = user
        self.sponsorship = sponsorship
    }
}

// MARK: - PictureLinks
class PictureLinks: Codable {
    let linksSelf, html, download, downloadLocation: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
    
    init(linksSelf: String?, html: String?, download: String?, downloadLocation: String?) {
        self.linksSelf = linksSelf
        self.html = html
        self.download = download
        self.downloadLocation = downloadLocation
    }
}

// MARK: - Sponsorship
class Sponsorship: Codable {
    let impressionsID, tagline: String?
    let sponsor: User?
    
    enum CodingKeys: String, CodingKey {
        case impressionsID = "impressions_id"
        case tagline, sponsor
    }
    
    init(impressionsID: String?, tagline: String?, sponsor: User?) {
        self.impressionsID = impressionsID
        self.tagline = tagline
        self.sponsor = sponsor
    }
}

// MARK: - User
class User: Codable {
    let id: String?
    let updatedAt: String?
    let username, name, firstName, lastName: String?
    let twitterUsername: String?
    let portfolioURL: String?
    let bio, location: String?
    let links: UserLinks?
    let profileImage: ProfileImage?
    let instagramUsername: String?
    let totalCollections, totalLikes, totalPhotos: Int?
    let acceptedTos: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username, name
        case firstName = "first_name"
        case lastName = "last_name"
        case twitterUsername = "twitter_username"
        case portfolioURL = "portfolio_url"
        case bio, location, links
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
        case totalCollections = "total_collections"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case acceptedTos = "accepted_tos"
    }
    
    init(id: String?, updatedAt: String?, username: String?, name: String?, firstName: String?, lastName: String?, twitterUsername: String?, portfolioURL: String?, bio: String?, location: String?, links: UserLinks?, profileImage: ProfileImage?, instagramUsername: String?, totalCollections: Int?, totalLikes: Int?, totalPhotos: Int?, acceptedTos: Bool?) {
        self.id = id
        self.updatedAt = updatedAt
        self.username = username
        self.name = name
        self.firstName = firstName
        self.lastName = lastName
        self.twitterUsername = twitterUsername
        self.portfolioURL = portfolioURL
        self.bio = bio
        self.location = location
        self.links = links
        self.profileImage = profileImage
        self.instagramUsername = instagramUsername
        self.totalCollections = totalCollections
        self.totalLikes = totalLikes
        self.totalPhotos = totalPhotos
        self.acceptedTos = acceptedTos
    }
}

// MARK: - UserLinks
class UserLinks: Codable {
    let linksSelf, html, photos, likes: String?
    let portfolio, following, followers: String?
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, photos, likes, portfolio, following, followers
    }
    
    init(linksSelf: String?, html: String?, photos: String?, likes: String?, portfolio: String?, following: String?, followers: String?) {
        self.linksSelf = linksSelf
        self.html = html
        self.photos = photos
        self.likes = likes
        self.portfolio = portfolio
        self.following = following
        self.followers = followers
    }
}

// MARK: - ProfileImage
class ProfileImage: Codable {
    let small, medium, large: String?
    
    init(small: String?, medium: String?, large: String?) {
        self.small = small
        self.medium = medium
        self.large = large
    }
}

// MARK: - Urls
class Urls: Codable {
    let raw, full, regular, small: String?
    let thumb: String?
    
    init(raw: String?, full: String?, regular: String?, small: String?, thumb: String?) {
        self.raw = raw
        self.full = full
        self.regular = regular
        self.small = small
        self.thumb = thumb
    }
}

