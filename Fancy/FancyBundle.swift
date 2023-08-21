//
//  FancyBundle.swift
//  Fancy
//
//  Created by Jarvis on 2023/8/21.
//

import WidgetKit
import SwiftUI

@main
struct FancyBundle: WidgetBundle {
    var body: some Widget {
        Fancy()
        FancyLiveActivity()
    }
}
