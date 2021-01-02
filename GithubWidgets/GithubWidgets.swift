//
//  GithubWidgets.swift
//  GithubWidgets
//
//  Created by Kirtan Patel on 12/20/20.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    let fetcher = DataFetcher()
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent(), contribution: [], background: nil, light: Color.githubGreen, dark: Color.githubGreen)
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration, contribution: [], background: nil, light: Color.githubGreen, dark: Color.githubGreen)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        var lightColor = Color.githubGreen
        var darkColor = Color.githubGreen
        
        var widgetBackground: Background? = nil
        
        if let colors = getColorPalette(for: configuration) {
            lightColor = colors.lightColorArray
            darkColor = colors.darkColorArray
        }
        
        if let wBackground = getBackground(for: configuration) {
            widgetBackground = wBackground
        }
        
        let poo = UserDataFetcher();
        
        poo.fetchData(user: "kirtanp98") { contributions in
                        
            let entry = SimpleEntry(date: currentDate, configuration: configuration, contribution: contributions, background: widgetBackground, light: lightColor, dark: darkColor)
            entries.append(entry)
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }

    }
    
    func getColorPalette(for config: ConfigurationIntent) -> Palette? {
        guard let id = config.colorPalette?.identifier else { return nil }
        
        guard let colorPalette = fetcher.getColorByID(uuid: id) else { return nil }
        
        return colorPalette
    }
    
    
    func getBackground(for config: ConfigurationIntent) -> Background? {
        guard let id = config.background?.identifier else { return nil }
        
        guard let background = fetcher.getBackgroundByID(uuid: id) else { return nil }
        
        return background
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let contribution: [Contribute]
    let background: Background?
    let light: [Color]
    let dark: [Color]
}

struct GithubWidgetsEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        CalendarWidget(background: entry.background, light: entry.light, dark: entry.dark, contribution: entry.contribution)
    }
}

@main
struct GithubWidgets: Widget {
    let kind: String = "GithubWidgets"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            GithubWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Minimal Contribution Widget")
        .description("This widget shows the recent most calendar contributions.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

//struct GithubWidgets_Previews: PreviewProvider {
//    static var previews: some View {
//        GithubWidgetsEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent(), contribution: []))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
