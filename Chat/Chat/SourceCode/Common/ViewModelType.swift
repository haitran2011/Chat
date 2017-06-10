//
//  ViewModelType.swift
//  Chat
//
//  Created by Alexey Shtanko on 6/6/17.
//  Copyright © 2017 Shtanko. All rights reserved.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
