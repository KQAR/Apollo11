//
//  ExtraSafeAreaSpacer.swift
//  Apollo11
//
//  Created by Jarvis on 2023/6/7.
//

import SwiftUI

// MARK: - TopSafeAreaInsetKey

struct TopSafeAreaInsetKey: EnvironmentKey {
    static var defaultValue: CGFloat = .zero
}

// MARK: - BottomSafeAreaInsetKey

struct BottomSafeAreaInsetKey: EnvironmentKey {
    static var defaultValue: CGFloat = .zero
}

extension EnvironmentValues {
    var bottomSafeAreaInset: CGFloat {
        get { self[BottomSafeAreaInsetKey.self] }
        set { self[BottomSafeAreaInsetKey.self] = newValue }
    }

    var topSafeAreaInset: CGFloat {
        get { self[TopSafeAreaInsetKey.self] }
        set { self[TopSafeAreaInsetKey.self] = newValue }
    }
}

// MARK: - ExtraTopSafeAreaInset

public struct ExtraTopSafeAreaSpacer: View {
    @Environment(\.topSafeAreaInset)
    var topSafeAreaInset: CGFloat

    public init() {}

    public var body: some View {
        Spacer(minLength: topSafeAreaInset)
    }
}

// MARK: - ExtraBottomSafeAreaInset

public struct ExtraBottomSafeAreaSpacer: View {
    @Environment(\.bottomSafeAreaInset)
    var bottomSafeAreaInset: CGFloat

    public init() {}

    public var body: some View {
        Spacer(minLength: bottomSafeAreaInset)
    }
}
