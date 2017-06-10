//
//  Network.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Alamofire
import RxSwift
import ObjectMapper
import RxAlamofire

final class Network<T: ImmutableMappable> {
    
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getMessages(_ path: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .json(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
    func getChannels(_ path: String) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)"
        return RxAlamofire
            .json(.get, absolutePath)
            .debug()
            .observeOn(scheduler)
            .map({ json -> T in
                return try Mapper<T>().map(JSONObject: json)
            })
    }
    
}
