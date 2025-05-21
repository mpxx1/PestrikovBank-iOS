//
//  AppAuthState.swift
//  PestrikovBank
//
//  Created by m on 14.04.2025.
//

public enum AuthState {
    case loggedIn(UserImpl)
    case loading
    case loggedOut
}
