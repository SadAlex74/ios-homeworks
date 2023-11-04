//
//  FileManagerService.swift
//  FileManager
//
//  Created by Александр Садыков on 29.10.2023.
//

import Foundation

protocol FileManagerServiceProtocol {
    func contentsOfDirectory() -> [Content]
    func createDirectory(name: String)
    func createFile(imageURL: NSURL, fileName: String)
    func removeContent(name: String)
    func getPath(name: String) -> String
}

final class FileManagerService: (FileManagerServiceProtocol) {
    
    private let pathForFolder: String
    
    init() {
        pathForFolder = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }

    init(pathForFolder: String) {
        self.pathForFolder = pathForFolder
    }

    private  func isDirectory(_ item: String) -> TypeOfFile {
        let path = pathForFolder + "/" + item
        
        var objCBool: ObjCBool = false
        
        FileManager.default.fileExists(atPath: path, isDirectory: &objCBool)
        
        return objCBool.boolValue ? TypeOfFile.folder : TypeOfFile.file
    }
 
    private func getSize(_ item: String) -> String {
        if isDirectory(item) == .file {
            let path = pathForFolder + "/" + item
            let attributes = try! FileManager.default.attributesOfItem(atPath: path)
            let size = attributes[.size] as! Int / 1024
            return "\(size) kb"
        } else {
            return ""
        }
    }
    
    func contentsOfDirectory() -> [Content] {
        let items = (try? FileManager.default.contentsOfDirectory(atPath: pathForFolder)) ?? []
        let content: [Content]
        if Settings.sortingFile { content  = items.sorted().map{item in
                Content(name: item, type: isDirectory(item), size: getSize(item))
            }
        } else {
            content  = items.map{item in
                Content(name: item, type: isDirectory(item), size: getSize(item))
            }
        }
        return content
    }
    
    func createDirectory(name: String) {
        try? FileManager.default.createDirectory(atPath: pathForFolder + "/" + name, withIntermediateDirectories: true)
    }
    
    func createFile(imageURL: NSURL, fileName: String) {
       // let fileName = imageURL.pathComponents?.last
        let endUrl = URL(fileURLWithPath: pathForFolder + "/" + fileName)
        try? FileManager.default.copyItem(at: imageURL as URL, to: endUrl)
    }
    
    func removeContent(name: String) {
        let path = pathForFolder + "/" + name
        try? FileManager.default.removeItem(atPath: path)
    }
    
    func getPath(name: String) -> String {
        pathForFolder + "/" + name
    }
    

}
