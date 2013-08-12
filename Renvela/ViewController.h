//
//  ViewController.h
//  Renvela
//
//  Created by INMUBPHG2103 on 31/07/13.
//  Copyright (c) 2013 watermelon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface ViewController : UIViewController{
    
    AVAudioRecorder *recorder;
	NSTimer *levelTimer;
	double lowPassResults;
    IBOutlet UIImageView *myImageView;

}
@property(nonatomic,retain)IBOutlet UIImageView *myImageView;
- (void)levelTimerCallback:(NSTimer *)timer;
@end
