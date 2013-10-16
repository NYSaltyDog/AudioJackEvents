//
//  ViewController.m
//  AudioJackEvents
//
//  Created by Kevin Ives on 10/16/13.
//  Copyright (c) 2013 Aquilacom Technologies. All rights reserved.
//

#import "ViewController.h"



//---------->>>>
//
//   //                                                                    ////
//  //////////////////////////////////////////////////////////////////////////
#pragma mark - AUDIO SESSION CALLBACK
//  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//   \\                                                                    \\\\
//
//---------->>>>
void audioRouteChangeListenerCallback (void                      *inUserData,
									   AudioSessionPropertyID    inPropertyID,
									   UInt32                    inPropertyValueSize,
									   const void                *inPropertyValue		)
{
	if (inPropertyID != kAudioSessionProperty_AudioRouteChange) return;
	
	ViewController *viewController          =   (__bridge ViewController *) inUserData;
	CFDictionaryRef	routeChangeDictionary   =   inPropertyValue;
	CFNumberRef routeChangeReasonRef        =   CFDictionaryGetValue (routeChangeDictionary, CFSTR (kAudioSession_AudioRouteChangeKey_Reason));
    
	SInt32 routeChangeReason;
	CFNumberGetValue (routeChangeReasonRef, kCFNumberSInt32Type, &routeChangeReason);
    
	//---------->>>>
    // "Old device unavailable" indicates that a headset was unplugged,
	//	or that the device was removed from a dock connector that supports audio output.
	if (routeChangeReason == kAudioSessionRouteChangeReason_OldDeviceUnavailable){
		// EVENT TRIGGERED
		//---------->>>>
        
		NSLog(@"ALERT HAS BEEN TRIGGERED");
        
        [viewController showEventUnplugged:viewController];
    
		//---------->>>>
		// END EVENT TRIGGERED BLOCK
	}
    
    //---------->>>>
    // "New device available" indicates that a headset was plugged into the jack,
	//	or that the device was plugged into a dock connector that supports audio output.
    if (routeChangeReason == kAudioSessionRouteChangeReason_NewDeviceAvailable)
	{
		// EVENT TRIGGERED
		//---------->>>>
        
		NSLog(@"ALERT HAS BEEN TRIGGERED");
        
        [viewController showEventPluggedIn:viewController];
        
		//---------->>>>
		// END EVENT TRIGGERED BLOCK
	}
}
//---------->>>>
// END: Audio session callback function
//---------->>>>




#pragma mark - INTERFACE
@interface ViewController ()

@end



#pragma mark - IMPLEMENTATION
@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	//  Call Audio Session set up Method
	[self setupAudioSession];
    
    // Call Register Notification Method
	[self registerForNotifications];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//---------->>>>
//
//   //                                                                    ////
//  //////////////////////////////////////////////////////////////////////////
#pragma mark - SET-UP
//  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//   \\                                                                    \\\\
//
//---------->>>>
- (void) setupAudioSession
{
	// Registers this class as the delegate of the audio session.
	[[AVAudioSession sharedInstance] setDelegate: self];
	
	// Register the audio route change listener callback function
	AudioSessionAddPropertyListener (kAudioSessionProperty_AudioRouteChange,audioRouteChangeListenerCallback,(__bridge void *)(self));
	
	// Activate the audio session.
	NSError *activationError = nil;
	[[AVAudioSession sharedInstance] setActive: YES error: &activationError];
}



- (void) registerForNotifications
{
	// Initialize the Notification
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
	
    // Set the observer for the notification type
	[notificationCenter addObserver:self
                           selector:@selector(handle_PlaybackStateChanged:)
                               name:MPMusicPlayerControllerPlaybackStateDidChangeNotification
                             object:_musicPlayer];
    
    // Tell system to begin generating notifications
    [_musicPlayer beginGeneratingPlaybackNotifications];
}







//---------->>>>
//
//   //                                                                    ////
//  //////////////////////////////////////////////////////////////////////////
#pragma mark - ALERTS
//  \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
//   \\                                                                    \\\\
//
//---------->>>>
- (void)showEventUnplugged:(id)sender
{
    //---------->>>>
	NSLog(@"EARPHONES HAVE BEEN UNPLUGGED");
	//---------->>>>
     UIAlertView *eventAlertView = [[UIAlertView alloc] initWithTitle: @"UNPLUG ALERT"
                                                          message: @"Do Something... \nThe Earphones have been removed from the audio jack"
                                                         delegate: self
                                                cancelButtonTitle: @"OK"
                                                otherButtonTitles: nil];
    [eventAlertView show];
}


- (void)showEventPluggedIn:(id)sender  
{
    //---------->>>>
	NSLog(@"EARPHONES HAVE BEEN PLUGGED-IN");
	//---------->>>>
    UIAlertView *eventAlertView = [[UIAlertView alloc] initWithTitle: @"PLUG-IN ALERT"
                                                             message: @"Do Something... \nThe Earphones have been plugged into the audio jack"
                                                            delegate: self
                                                   cancelButtonTitle: @"OK"
                                                   otherButtonTitles: nil];
    [eventAlertView show];
}



@end
