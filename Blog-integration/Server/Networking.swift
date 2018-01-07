//
//  Networking.swift
//  Sponsorhuset
//
//  Created by Vlad Krut on 04.10.2017.
//  Copyright © 2017 Vlad Krut. All rights reserved.
//

import Foundation
import Alamofire

class Networking {
    
    func makeRequest(path: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping (Any) -> (), failure: @escaping (SponsorhusetError) -> ()) {
        
        let fullPath = MainAPIUrl + path
        
        makeRequestToFullPath(path: fullPath, method: method, parameters: parameters, headers: headers, success: success, failure: failure)
    }
    
    func makeRequestToFullPath(path: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping (Any) -> (), failure: @escaping (SponsorhusetError) -> ()) {
        
        var encoding: ParameterEncoding = URLEncoding.default
        if method != .get { encoding = JSONEncoding.default }
        
//        (UIApplication.shared.delegate as? AppDelegate)?.setNetworkActivityIndicatorVisible(true)
        
        Alamofire.request(path, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON { response in
            
//            (UIApplication.shared.delegate as? AppDelegate)?.setNetworkActivityIndicatorVisible(false)
            
            switch response.result {
            case .success(let data):
                success(data)
                
            case .failure(let error):
                
                print ("\n\(String(describing: method).uppercased()) \(path)")
                print ("ERROR: \(error.localizedDescription)")
                
                if let parameters = parameters {
                    print ("\nPARAMETERS:")
                    for item in parameters {
                        print (item)
                    }
                } else {
                    print ("\nPARAMETERS: nil")
                }
                
                if let headers = headers {
                    print ("\nHEADERS:")
                    for item in headers {
                        print (item)
                    }
                } else {
                    print ("\nHEADERS: nil")
                }
                
                if let debuggerLink = response.response?.allHeaderFields["X-Debug-Token-Link"] {
                    print("\nDEBUGGER LINK: \n\(debuggerLink)")
                }
                
                var readableData: String?
                
                if let data = response.data {
                    readableData = String(data: data, encoding: .utf8)
                    print("\nREADABLE DATA:\n\(readableData ?? "nil")")
                }
                
                let sponsorhusetError = SponsorhusetError(error: error, readableData: readableData, statusCode: response.response?.statusCode)
                
                DispatchQueue.main.async {
                    failure(sponsorhusetError)
                }
            }
        }
    }
    
    func uploadImageToServer(image: UIImage, parameters: Parameters?, headers: HTTPHeaders?, success: @escaping (Any)->(), failure: @escaping (Error)->()) {
        
        guard let imageData = compressImage(image) else {
            failure(ServerRequestError.errorServer)
            return
        }
        
        let URL = try! URLRequest(url: MainAPIUrl, method: .post, headers: headers)
        
//        (UIApplication.shared.delegate as? AppDelegate)?.setNetworkActivityIndicatorVisible(true)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "file", fileName: "image.jpg", mimeType: "image/jpeg")
        },
            with: URL,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        
//                        (UIApplication.shared.delegate as? AppDelegate)?.setNetworkActivityIndicatorVisible(false)
                        
                        switch response.result {
                        case .success(let data):
                            if let image = UploadedImage(JSONString: JSONString(data: data)) {
                                success(image)
                            } else {
                                failure(ServerRequestError.emptyResponse)
                            }
                            break
                        case .failure(let error):
                            print("Error uploading image to server. Error: \(error.localizedDescription)")
                            failure(ServerRequestError.errorServer)
                        }
                    }
                case .failure( _):
//                    (UIApplication.shared.delegate as? AppDelegate)?.setNetworkActivityIndicatorVisible(false)
                    failure(ServerRequestError.errorServer)
                }
        })
    }
    
    func compressImage(_ image: UIImage) -> Data? {
        
        let actualHeight: CGFloat = image.size.height
        let actualWidth: CGFloat = image.size.width
        let imgRatio: CGFloat = actualWidth/actualHeight
        let maxWidth: CGFloat = 1024.0
        let resizedHeight = maxWidth/imgRatio
        let compressionQuality: CGFloat = 0.5
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData = UIImageJPEGRepresentation(img, compressionQuality)
        UIGraphicsEndImageContext()
        
        return imageData
    }
}

func JSONString(data: Any) -> String {
    
    if let JSONData = try? JSONSerialization.data(withJSONObject: data, options: []) {
        return String(data: JSONData, encoding: .utf8)!
    } else {
        return ""
    }

}
