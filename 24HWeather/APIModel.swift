//
//  APIModel.swift
//  24HWeather
//
//  Created by 黃柏瀚 on 2022/6/28.
//

import UIKit
import Alamofire

class APIModel  {
    
    //單例化:防止他人串改
    static var share = APIModel()
    private var apiURL = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-248CA209-B578-4FBE-8A38-FA19CB519DF2&format=JSON&locationName=%E8%87%BA%E5%8C%97%E5%B8%82&elementName=PoP,MinT,MaxT"
    
    private init(){
        
    }
    
    func queryRandomUserAlamofire(completion:@escaping (_ Data:Any?,_ respError: Error?)->())->(){
        let url = apiURL
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: nil).responseJSON { respons in
                    switch respons.result{
                        case .success(_):
                            return completion(respons.data,nil)
                        case .failure(let error):
                            return completion(nil,error)
            }
        }
    }
    
}
