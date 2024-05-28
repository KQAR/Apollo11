//
//  Fancy.swift
//  Fancy
//
//  Created by Jarvis on 2023/8/21.
//

import Intents
import Neumorphic
import SwiftUI
import WidgetKit

struct Provider: IntentTimelineProvider {
  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), configuration: ConfigurationIntent(), quoteShareItem: QuoteResItem(hitokoto: ""))
  }

  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), configuration: configuration, quoteShareItem: QuoteResItem(hitokoto: ""))
    completion(entry)
  }

  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//    var entries: [SimpleEntry] = []
//
//    // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//    let currentDate = Date()
//    for hourOffset in 0 ..< 5 {
//      let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//      let entry = SimpleEntry(date: entryDate, configuration: configuration, quoteShareItem: SyncWidgetQuoteShareItem())
//      entries.append(entry)
//    }
//
//    let timeline = Timeline(entries: entries, policy: .atEnd)
//    completion(timeline)

    QuoteService.getQuote(client: NetworkClient()) { quoteResItem in
//      let quoteShareItem = SyncWidgetQuoteShareItem()
//      quoteShareItem.updateQuoteItem(quoteResItem)
      let entry = SimpleEntry(date: Date(), configuration: configuration, quoteShareItem: quoteResItem)
      // refresh the data every two hours
      let expireDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
      let timeline = Timeline(entries: [entry], policy: .after(expireDate))
      completion(timeline)
    }
  }
}

struct SimpleEntry: TimelineEntry {
  let date: Date
  let configuration: ConfigurationIntent
  var quoteShareItem: QuoteResItem
}

struct FancyEntryView: View {
  var entry: Provider.Entry
//  @ObservedObject var quoteShareItem: SyncWidgetQuoteShareItem

  var body: some View {
    ZStack {
      Color.red
      Circle()
        .fill(Color.Neumorphic.main)
        .frame(width: 120, height: 120)
        .softInnerShadow(Circle())
      VStack {
        Text(entry.date, style: .time)
        Text(entry.quoteShareItem.hitokoto)
      }
    }
  }
}

struct Fancy: Widget {
  let kind: String = "Fancy"

  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      FancyEntryView(entry: entry)
    }
    .configurationDisplayName("My Widget")
    .description("This is an example widget.")
  }
}

struct Fancy_Previews: PreviewProvider {
  static var previews: some View {
    FancyEntryView(
      entry: SimpleEntry(
        date: Date(),
        configuration: ConfigurationIntent(),
        quoteShareItem: QuoteResItem(hitokoto: "")
      )
    )
    .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
