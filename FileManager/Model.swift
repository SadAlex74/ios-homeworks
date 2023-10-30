//
//  Model.swift
//  FileManager
//
//  Created by Александр Садыков on 29.10.2023.
//

import Foundation

enum TypeOfFile {
    case folder
    case file
}

struct Content {
    let name: String
    let type: TypeOfFile
}
