//
//  ViewController.swift
//  24HWeather
//
//  Created by 黃柏瀚 on 2022/6/28.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

 
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var popLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        date()
        updateData()
    }

    //API資料
    func updateData() {
            APIModel.share.queryRandomUserAlamofire { response, error in
                if let data = response as? Data{
                    let json = JSON(data)
                    //縣市
                    let city = json["records"]["location"][0]["locationName"].stringValue + " "
                    
                    //降雨機率
                    let POP = json["records"]["location"][0]["weatherElement"][0]["time"][1]["parameter"]["parameterName"].stringValue + "%"
                    //最低溫度
                    let MinT = json["records"]["location"][0]["weatherElement"][1]["time"][1]["parameter"]["parameterName"].stringValue + ""
                    //最高溫度
                    let MaxT = json["records"]["location"][0]["weatherElement"][2]["time"][1]["parameter"]["parameterName"].stringValue + "°C"

                    DispatchQueue.main.async {
                        self.cityLabel.text = city
                        self.temperatureLabel.text = MinT + "～" + MaxT
                        self.popLabel.text = POP
                }
            }

}

}
    
    //時間
    func date() {
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let strNowTime = dateFormatter.string(from: date as Date) as String
        timeLabel.text = strNowTime
    }
}
