//
//  RecordingDetail.swift
//  RadioRasclat
//
//  Created by Domenik Töfflinger on 10.03.20.
//  Copyright © 2020 Domenik Töfflinger. All rights reserved.
//

import SwiftUI
import URLImage
import AVFoundation

extension Font {
    static func avenirNextRegular(size: Int) -> Font {
        return Font.custom("AvenirNext-Regular", size: CGFloat(size))
    }
    
    static func avenirNextBold(size: Int) -> Font {
        return Font.custom("AvenirNext-Bold", size: CGFloat(size))
    }
}

struct AudioPlayerControlsView: View {
    private enum PlaybackState: Int {
        case waitingForSelection
        case buffering
        case playing
    }
    
    let player: AVPlayer
    let timeObserver: PlayerTimeObserver
    let durationObserver: PlayerDurationObserver
    let itemObserver: PlayerItemObserver
    @State private var currentTime: TimeInterval = 0
    @State private var currentDuration: TimeInterval = 0
    @State private var state = PlaybackState.waitingForSelection
    
    var body: some View {
        VStack {
            if state == .waitingForSelection {
                Text("Select the show below")
            } else if state == .buffering {
                Text("Buffering...")
            } else {
                Text("Playing...")
            }
            
            Slider(value: $currentTime,
                   in: 0...currentDuration,
                   onEditingChanged: sliderEditingChanged,
                   minimumValueLabel: Text("\(currentTime)"),
                   maximumValueLabel: Text("\(currentDuration)")) {
                    // I have no idea in what scenario this View is shown...
                    Text("seek/progress slider")
            }
            .disabled(state != .playing)
        }
        .padding()
        // Listen out for the time observer publishing changes to the player's time
        .onReceive(timeObserver.publisher) { time in
            // Update the local var
            self.currentTime = time
            // And flag that we've started playback
            if time > 0 {
                self.state = .playing
            }
        }
        // Listen out for the duration observer publishing changes to the player's item duration
        .onReceive(durationObserver.publisher) { duration in
            // Update the local var
            self.currentDuration = duration
        }
        // Listen out for the item observer publishing a change to whether the player has an item
        .onReceive(itemObserver.publisher) { hasItem in
            self.state = hasItem ? .buffering : .waitingForSelection
            self.currentTime = 0
            self.currentDuration = 0
        }
    }
    
    // MARK: Private functions
    private func sliderEditingChanged(editingStarted: Bool) {
        if editingStarted {
            // Tell the PlayerTimeObserver to stop publishing updates while the user is interacting
            // with the slider (otherwise it would keep jumping from where they've moved it to, back
            // to where the player is currently at)
            timeObserver.pause(true)
        }
        else {
            // Editing finished, start the seek
            state = .buffering
            let targetTime = CMTime(seconds: currentTime,
                                    preferredTimescale: 600)
            player.seek(to: targetTime) { _ in
                // Now the (async) seek is completed, resume normal operation
                self.timeObserver.pause(false)
                self.state = .playing
            }
        }
    }
}

/*struct RecordingDetail: View {
    let player = AVPlayer()
    private let items = [(url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
     title: "Song-1"),
    (url: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
     title: "Song-2")]
    
    var recording: Recording
    
    var body: some View {
        VStack {
            URLImage(recording.image,
            content:  {
                $0.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 5))
                    .padding(.top, 5.0)
                .shadow(radius: 5.0)
            })
            Text(recording.title)
            .font(.system(.title, design: .rounded)).fontWeight(.bold)
            Text(recording.description)
                .font(.system(.body, design: .rounded))
            Spacer()
            AudioPlayerControlsView(player: player,
                timeObserver: PlayerTimeObserver(player: player),
                durationObserver: PlayerDurationObserver(player: player),
                itemObserver: PlayerItemObserver(player: player))
            
            List(items, id: \.title) { item in
                Button(item.title) {
                    guard let url = URL(string: item.url) else {
                        return
                    }
                    let playerItem = AVPlayerItem(url: url)
                    self.player.replaceCurrentItem(with: playerItem)
                    self.player.play()
                }
            }
        }
        .onDisappear {
            // When this View isn't being shown anymore stop the player
            self.player.replaceCurrentItem(with: nil)
        }
        .navigationBarTitle(Text(recording.title), displayMode: .inline)
    }
}*/

struct RecordingDetail: View {
    var recording: Recording
    
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()

    var dueDate = Date()
    
    var body: some View {
        ScrollView {
            GeometryReader { geometry in
                ZStack {
                    if geometry.frame(in: .global).minY <= 0 {
                        URLImage(self.recording.image,
                        content:  {
                            $0.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .offset(y: geometry.frame(in: .global).minY/9)
                                .clipped()
                        })
                    } else {
                        URLImage(self.recording.image,
                        content:  {
                            $0.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height + geometry.frame(in: .global).minY)
                                .clipped()
                                .offset(y: -geometry.frame(in: .global).minY)
                        })
                    }
                }
            }
                .frame(height: 350)
            VStack(alignment: .leading) {
                HStack {
                    URLImage(recording.show.image,
                    content:  {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 40, height: 40)
                            .clipped()
                            .cornerRadius(5)
                    })
                    VStack(alignment: .leading) {
                        Text("Radio Rasclat Show:")
                            .font(.avenirNextRegular(size: 14))
                            .foregroundColor(.gray)
                        Text(recording.show.title)
                            .font(.avenirNextBold(size: 14))
                    }
                }
                    .padding(.top, 10)
                Text(recording.title)
                    .font(.avenirNextBold(size: 28))
                    .lineLimit(nil)
                Text("\(dueDate, formatter: Self.taskDateFormat)")
                    .font(.avenirNextRegular(size: 17))
                    .foregroundColor(.gray)
                    .padding(.top, 5)
                Text(recording.description)
                    .font(.avenirNextRegular(size: 17))
                    .lineLimit(nil)
                    .padding(.top, 10)
            }
                .frame(width: 380)
        }
            .edgesIgnoringSafeArea(.top)
    }
}

class ViewFrame: ObservableObject {
    var startingRect: CGRect?
    
    @Published var frame: CGRect {
        willSet {
            if startingRect == nil {
                startingRect = newValue
            }
        }
    }
    
    init() {
        self.frame = .zero
    }
}

struct GeometryGetter: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            AnyView(Color.clear)
                .preference(key: RectanglePreferenceKey.self, value: geometry.frame(in: .global))
        }.onPreferenceChange(RectanglePreferenceKey.self) { (value) in
            self.rect = value
        }
    }
}

struct RectanglePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

/*struct RecordingDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecordingDetail(recording: recordings[4])
        }
    }
}*/

import Combine
class PlayerTimeObserver {
    let publisher = PassthroughSubject<TimeInterval, Never>()
    private weak var player: AVPlayer?
    private var timeObservation: Any?
    private var paused = false
    
    init(player: AVPlayer) {
        self.player = player
        
        // Periodically observe the player's current time, whilst playing
        timeObservation = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 600), queue: nil) { [weak self] time in
            guard let self = self else { return }
            // If we've not been told to pause our updates
            guard !self.paused else { return }
            // Publish the new player time
            self.publisher.send(time.seconds)
        }
    }
    
    deinit {
        if let player = player,
            let observer = timeObservation {
            player.removeTimeObserver(observer)
        }
    }
    
    func pause(_ pause: Bool) {
        paused = pause
    }
}

class PlayerItemObserver {
    let publisher = PassthroughSubject<Bool, Never>()
    private var itemObservation: NSKeyValueObservation?
    
    init(player: AVPlayer) {
        // Observe the current item changing
        itemObservation = player.observe(\.currentItem) { [weak self] player, change in
            guard let self = self else { return }
            // Publish whether the player has an item or not
            self.publisher.send(player.currentItem != nil)
        }
    }
    
    deinit {
        if let observer = itemObservation {
            observer.invalidate()
        }
    }
}

class PlayerDurationObserver {
    let publisher = PassthroughSubject<TimeInterval, Never>()
    private let itemObserver: PlayerItemObserver
    private var itemObserverCancellable: AnyCancellable?
    private var durationObservation: NSKeyValueObservation?
    
    init(player: AVPlayer) {
        itemObserver = PlayerItemObserver(player: player)
        // Listen out for the itemObserver publishing a change to the player's item
        itemObserverCancellable = itemObserver.publisher.sink { hasItem in
            if let existingObserver = self.durationObservation {
                existingObserver.invalidate()
                self.durationObservation = nil
            }
            
            if hasItem {
                // Observe the duration of this new item changing (becoming known)
                self.durationObservation = player.currentItem?.observe(\.duration) { [weak self] item, change in
                    guard let self = self else { return }
                    // Publish the new duration
                    self.publisher.send(item.duration.seconds)
                }
            }
        }
    }
    
    deinit {
        if let observer = durationObservation {
            observer.invalidate()
        }
        
        if let cancellable = itemObserverCancellable {
            cancellable.cancel()
        }
    }
}
