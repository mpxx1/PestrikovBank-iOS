//
//  AppConfig.swift
//  PestrikovBank
//
//  Created by m on 16.05.2025.
//

import Foundation

public final class AppConfig {
    static func apiBaseURL() -> String {
        guard let apiBaseURL = Bundle.main.object(forInfoDictionaryKey: "ApiBaseURL") as? String else {
            fatalError("ApiBaseURL must not be empty in plist")
        }
        return apiBaseURL
    }
}
