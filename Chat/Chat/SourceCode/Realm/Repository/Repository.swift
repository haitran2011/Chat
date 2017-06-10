//
//  Repository.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift
import RxSwift
import RxRealm

final class Repository<T:RealmRepresentable>: AbstractRepository<T> where T == T.RealmType.DomainType, T.RealmType: Object {
    
    private let configuration: Realm.Configuration
    
    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }

    init(configuration: Realm.Configuration) {
        self.configuration = configuration
    }
    
    override func queryAll() -> Observable<[T]> {
        return Observable.deferred {
            let realm = self.realm
            let objects = realm.objects(T.RealmType.self)
            
            return Observable.array(from: objects)
                .mapToDomain()
            }
    }
}
