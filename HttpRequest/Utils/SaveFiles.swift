//  文件保存

import Foundation

class SaveFiles {

    static let systemCache: URL? = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("netCache", isDirectory: true)

    class func getPath(path: String) -> URL? {
        let pathURL = handlePathUrl(path)
        let manager = FileManager.default
        var url = systemCache
        if let urlStr = systemCache?.absoluteString, manager.isExecutableFile(atPath: urlStr) == false {
            try? manager.createDirectory(at: url!, withIntermediateDirectories: true, attributes: nil)
        }
        url?.appendPathComponent(pathURL)
        return url
    }

    class func save(path: String, data: Data) {
        if let url = getPath(path: path) {
            do {
                try data.write(to: url)
                print("保存成功")
            } catch {
                print("保存到本地文件失败")
            }
        }
    }
    
    class func read(path: String) -> Data? {
        if let url = getPath(path: path), let dataRead = try? Data(contentsOf: url) {
             print("读取本地文件成功")
            return dataRead
        } else {
            print("文件不存在，读取本地文件失败")
        }
        return nil
    }
    
    class func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        if let url = systemCache {
            do {
                try? FileManager.default.removeItem(at: url)
            }
        }

    }
    
    class func handlePathUrl(_ url: String) -> String {
        return url.replacingOccurrences(of: "/", with: "")
    }
}
