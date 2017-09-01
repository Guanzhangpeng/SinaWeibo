//
//  NetWorkTools.swift
//  SinaWeibo
//
//  Created by 郑隋 on 2017/8/28.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Alamofire

enum RequestType : String
{
    case GET = "GET"
    case POST = "POST"
}
class NetWorkTools {

    class func Requst(methodType : RequestType , urlString : String , parameters : [String : AnyObject]? = nil , finishedCallBack :@escaping (_ result : Any)->())
    {
        let type = methodType == .GET ? HTTPMethod.get : HTTPMethod.post
        
        Alamofire.request(urlString, method: type, parameters: parameters).responseJSON { (response) in
            
            var parameStr = "?";
            if let parameters = parameters {
                for (k,v) in parameters
                {
                    parameStr += k+"="+(v as! String)+"&"
                }
            }
            let characterSet = CharacterSet(charactersIn: "&")
            
            parameStr = parameStr.trimmingCharacters(in:characterSet)
            
            STWLog("请求的网页地址:\(urlString)\(parameStr)")
            
            //1.0 校验是否有结果
            guard let result = response.result.value else {
                STWLog(response.result.error)
                return
            }
            
            //2.0 将结果回调出去
            finishedCallBack(result)
        }
    }
}
