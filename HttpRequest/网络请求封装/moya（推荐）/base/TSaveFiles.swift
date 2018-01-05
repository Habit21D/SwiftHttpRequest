//
//  YJSaveFiles.swift
//  yjzx2017
//
//  Created by jin on 2017/12/27.
//  Copyright © 2017年 yjzx2017. All rights reserved.
//

import Foundation

class TSaveFiles {
    
    class func save(path: String, data: Data) {
        let pathURL = path
        //拿到一个本地文件的URL
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        url?.appendPathComponent("cache/")
        if let urlStr = url?.absoluteString, manager.isExecutableFile(atPath: urlStr) == false {
            try? manager.createDirectory(at: url!, withIntermediateDirectories: true, attributes: nil)
        }
        url?.appendPathComponent(pathURL)
        do {
            try data.write(to: url!)
//            print("保存到本地\(path)")
        } catch {
//            print("保存到本地文件失败")
        }
    }
    
    class func read(path: String) -> Data? {
        let pathURL = path
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        url?.appendPathComponent("cache/\(pathURL)")
        if let dataRead = try? Data(contentsOf: url!) {
            return dataRead
        } else {
//            print("文件不存在，读取本地文件失败")
        }
        return nil
    }
    
    class func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        url?.appendPathComponent("cache")
        do {
            try? manager.removeItem(at: url!)
        }
    }
}
