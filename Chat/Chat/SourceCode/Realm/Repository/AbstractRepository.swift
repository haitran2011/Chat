//
//  AbstractRepository.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/7/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

import Realm
import RealmSwift
import RxSwift
import RxRealm

func abstractMethod() -> Never {
    fatalError("abstract method")
}

class AbstractRepository<T> {
    func queryAll() -> Observable<[T]> {
        abstractMethod()
    }
    
    func query(with predicate: NSPredicate,
               sortDescriptors: [NSSortDescriptor] = []) -> Observable<[T]> {
        abstractMethod()
    }
    
    func save(entity: T) -> Observable<Void> {
        abstractMethod()
    }
    
    func delete(entity: T) -> Observable<Void> {
        abstractMethod()
    }
}
