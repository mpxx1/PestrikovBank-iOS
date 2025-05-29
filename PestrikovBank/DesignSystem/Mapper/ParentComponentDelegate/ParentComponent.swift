//
//  ParentComponent.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

protocol ParentComponent: AnyObject {
    func childComponents() -> [String:PBComponent]
}
