//
//  Url.swift
//  iosChallenge
//
//  Created by puyue on R 3/08/28.
//

internal struct Url {
    static let baseUrl = "http://api.currencylayer.com" // 切记千万不能 https 加 s 一定无法访问 文档是错的 或者 http://apilayer.net/api/
    static let all_country = "list? access_key = "
    static let access_key = "f6fbf49394a6f17e75e64ef2662a89b6"
    
    
    static let get_all_county = "http://api.currencylayer.com/list?access_key=f6fbf49394a6f17e75e64ef2662a89b6"
    static let get_all_rate_base_USD = "http://api.currencylayer.com/live?access_key=f6fbf49394a6f17e75e64ef2662a89b6&source=USD"
    static let get_rate_USDJPY = "http://api.currencylayer.com/live?access_key=f6fbf49394a6f17e75e64ef2662a89b6&source=USD&currencies=JPY"
}


// &format=1可加可不加 加了就会显示成人类好看的格式 但是对代码无用

