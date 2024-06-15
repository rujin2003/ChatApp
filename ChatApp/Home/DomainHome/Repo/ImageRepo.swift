//
//  ImageRepo.swift
//  ChatApp
//
//  Created by Rujin on 15/06/24.
//

import Foundation
import SwiftUI

protocol ImageDownloadProtocol {
    func getImage(urlstring: String)async -> UIImage?
}
