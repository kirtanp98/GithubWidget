//
//  NormalGithubWidget.swift
//  GithubWidgetsExtension
//
//  Created by Kirtan Patel on 1/9/21.
//

import WidgetKit
import SwiftUI
import Intents

struct ClassicProvider: IntentTimelineProvider {
    
    let fetcher = DataFetcher()
    
    func placeholder(in context: Context) -> SimpleNormalEntry {
        SimpleNormalEntry(date: Date(), configuration: NormalConfigurationIntent(), contribution: [], background: nil, light: Color.githubGreen, dark: Color.githubGreen, accentColor: .gray)
    }

    func getSnapshot(for configuration: NormalConfigurationIntent, in context: Context, completion: @escaping (SimpleNormalEntry) -> ()) {
        let entry = SimpleNormalEntry(date: Date(), configuration: configuration, contribution: [], background: nil, light: Color.githubGreen, dark: Color.githubGreen, accentColor: .gray)
        completion(entry)
    }

    func getTimeline(for configuration: NormalConfigurationIntent, in context: Context, completion: @escaping (Timeline<SimpleNormalEntry>) -> ()) {
        var entries: [SimpleNormalEntry] = []
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
        
        if let userName = configuration.user {
            print(userName)
            if userName.isEmpty {
                let currentUser = UserInfoFetcher()
                currentUser.getCurrentUserInfo() { state in
                    let fetchUser = UserDataFetcher();
                    
                    fetchUser.fetchData(user: currentUser.userName) { contributions in
                        let entry = SimpleNormalEntry(date: currentDate, configuration: configuration, contribution: contributions, background: widgetBackground, light: lightColor, dark: darkColor, accentColor: .gray)
                        entries.append(entry)
                        let timeline = Timeline(entries: entries, policy: .atEnd)
                        completion(timeline)
                    }
                }
            } else {
                let fetchUser = UserDataFetcher();
                
                fetchUser.fetchData(user: userName) { contributions in
                    let entry = SimpleNormalEntry(date: currentDate, configuration: configuration, contribution: contributions, background: widgetBackground, light: lightColor, dark: darkColor, accentColor: .gray)
                    entries.append(entry)
                    let timeline = Timeline(entries: entries, policy: .atEnd)
                    completion(timeline)
                }
            }
            
        } else {
            let currentUser = UserInfoFetcher()
            currentUser.getCurrentUserInfo() { state in
                let fetchUser = UserDataFetcher();
                
                fetchUser.fetchData(user: currentUser.userName) { contributions in
                    let entry = SimpleNormalEntry(date: currentDate, configuration: configuration, contribution: contributions, background: widgetBackground, light: lightColor, dark: darkColor, accentColor: .gray)
                    entries.append(entry)
                    let timeline = Timeline(entries: entries, policy: .atEnd)
                    completion(timeline)
                }
            }
        }

    }
    
    func getColorPalette(for config: NormalConfigurationIntent) -> Palette? {
        guard let id = config.colorPalette?.identifier else { return nil }
        
        guard let colorPalette = fetcher.getColorByID(uuid: id) else { return nil }
        
        return colorPalette
    }
    
    
    func getBackground(for config: NormalConfigurationIntent) -> Background? {
        guard let id = config.background?.identifier else { return nil }
        
        guard let background = fetcher.getBackgroundByID(uuid: id) else { return nil }
        
        return background
    }
}

struct SimpleNormalEntry: TimelineEntry {
    let date: Date
    let configuration: NormalConfigurationIntent
    let contribution: [Contribute]
    let background: Background?
    let light: [Color]
    let dark: [Color]
    let accentColor: Color
}


struct NormalGithubWidgetsEntryView : View {
    var entry: ClassicProvider.Entry

    var body: some View {
        ClassicGridWidget(background: entry.background, light: entry.light, dark: entry.dark, contribution: entry.contribution)
    }
}

struct NormalGithubWidget: Widget {
    let kind: String = "NormalGithubWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: NormalConfigurationIntent.self, provider: ClassicProvider()) { entry in
            NormalGithubWidgetsEntryView(entry: entry)
        }
        .configurationDisplayName("Contribution Widget")
        .description("This widget shows the recent most calendar contributions.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
