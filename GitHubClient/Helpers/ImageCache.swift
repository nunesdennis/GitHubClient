import UIKit

protocol ImageCacheProtocol: AnyObject {
    subscript(_ url: URL) -> UIImage? { get set }
}

final class ImageCache: ImageCacheProtocol {
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        
        return cache
    }()
    
    subscript(_ key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        set {
            if newValue == nil {
                cache.removeObject(forKey: key as NSURL)
            } else {
                cache.setObject(newValue!, forKey: key as NSURL)
            }
        }
    }
}
