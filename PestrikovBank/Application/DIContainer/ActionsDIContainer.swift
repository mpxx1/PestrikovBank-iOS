//
//  ActionsDIContainer.swift
//  PestrikovBank
//
//  Created by m on 29.05.2025.
//

class ActionsDIContainer {
    private var voidActions: [String: () -> Void] = [:]
    private var stringActions: [String: (String) -> Void] = [:]

    func registerVoidAction(name: String, action: @escaping () -> Void) {
        voidActions[name] = action
    }

    func getVoidAction(name: String) -> (() -> Void)? {
        return voidActions[name]
    }

    func registerStringAction(name: String, action: @escaping (String) -> Void) {
        stringActions[name] = action
    }

    func getStringAction(name: String) -> ((String) -> Void)? {
        return stringActions[name]
    }
}
