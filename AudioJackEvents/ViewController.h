//
//  ViewController.h
//  AudioJackEvents
//
//  Created by Kevin Ives on 10/16/13.
//  Copyright (c) 2013 Aquilacom Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>


@interface ViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic, strong)	MPMusicPlayerController	*musicPlayer;

- (void)		showEventUnplugged:			(id)sender;
- (void)		showEventPluggedIn:			(id)sender;

@end
