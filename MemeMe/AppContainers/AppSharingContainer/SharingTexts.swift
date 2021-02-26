//
//  SharingTexts.swift
//  MemeMe
//
//  Created by BARAN BATUHAN KARAOGUZ on 26.02.2021.
//

import UIKit

protocol SharingTypeProtocol {
    var displayText     : String?  { get }
    var displayLink     : String?  { get }
    var displayImage    : UIImage? { get }
    var attachmentPath  : String?  { get }
    var attachmentData  : Data?    { get }
}

enum SharingType {
    case image(image: UIImage)
}

extension SharingType : SharingTypeProtocol {
    
    var displayText: String? {
        switch self {
        case .image(_):
            return nil
        }
    }
    
    var displayLink: String? {
        switch self {
        case .image(_):
            return nil
        }
    }
    
    var displayImage: UIImage? {
        switch self {
        case .image(let image):
            return image
        }
    }
    
    var attachmentPath: String? {
        switch self {
        case .image(_):
            return nil
        }
    }
    
    var attachmentData: Data? {
        switch self {
        case .image(_):
            return nil
        }
    }
    
    var subject: String? {
        switch self {
        case .image(_):
            return nil
        }
    }
    
}
