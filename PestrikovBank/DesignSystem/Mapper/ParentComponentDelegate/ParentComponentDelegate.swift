//
//  ParentComponentDelegate.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

final class ParentComponentDelegate {
    weak var delegate: ParentComponent?
    
    init(parentComponent: ParentComponent?) {
        self.delegate = parentComponent
    }
}
