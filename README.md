AudioJackEvents
===============

Use the audio jack to trigger events in your App.

This is a simple demo of how to use Audio Sessions and Notifications in order to interact with the 
audio jack hardware. This demo will trigger an AlertView each time  earphones are either plugged 
into (or removed from) the audio jack.  the demo shows how the system is able to identify the 
differance between plugging into or removing the plug from the jack so that the different events 
can execute different methods. 

The following framworks need to be included in your project in order to make this class work...

#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>
