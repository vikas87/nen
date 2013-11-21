//
//  ViewController.m
//  Renvela
//
//  Created by INMUBPHG2103 on 31/07/13.
//  Copyright (c) 2013 watermelon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myImageView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    myImageView.animationImages =  [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"1.png"],
                                    nil];
    
    // all frames will execute in 1.75 seconds
    myImageView.animationDuration = 0;
    // repeat the annimation forever
    myImageView.animationRepeatCount = 0;
    // start animating
    [myImageView startAnimating];
    // add the animation view to the main window
    [self.view addSubview:myImageView];   //  [campFireView release];
    
    
    NSURL *url = [NSURL fileURLWithPath:@"/dev/null"];
    
  	NSDictionary *settings =   [NSDictionary dictionaryWithObjectsAndKeys:
                               [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                               [NSNumber numberWithInt: kAudioFormatAppleLossless], AVFormatIDKey,
                               [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                               [NSNumber numberWithInt: AVAudioQualityMax],         AVEncoderAudioQualityKey,
                               nil];
    
  	NSError *error;
    
  	recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    
  	if (recorder) {
  		[recorder prepareToRecord];
  		recorder.meteringEnabled = YES;
  		[recorder record];
        levelTimer = [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
  	} else {
  		NSLog(@"%@", [error description]);
    }

}

- (void)levelTimerCallback:(NSTimer *)timer {
	[recorder updateMeters];
    
	const double ALPHA = 0.05;
	double peakPowerForChannel = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
	lowPassResults = ALPHA * peakPowerForChannel + (1.0 - ALPHA) * lowPassResults;
    
    if (lowPassResults > 0.80){
        [self blowDetected:lowPassResults];
    }
}

- (void)blowDetected:(float) level {
    // we don't want every leaf being blown every time in an attempt at a bit of realism
    if(arc4random() % 10 < 3){
        myImageView.animationImages =   [NSArray arrayWithObjects:
                                        [UIImage imageNamed:@"2a.png"],
                                        [UIImage imageNamed:@"2a.png"],
                                        [UIImage imageNamed:@"2b.png"],
                                        [UIImage imageNamed:@"2b.png"],
                                        //                                     [UIImage imageNamed:@"2b.png"],
                                        [UIImage imageNamed:@"2c.png"],
                                        //                                     [UIImage imageNamed:@"2c.png"],
                                        [UIImage imageNamed:@"2c.png"],
                                        [UIImage imageNamed:@"3.png"],
                                        [UIImage imageNamed:@"4.png"],
                                        [UIImage imageNamed:@"4.png"],
                                        [UIImage imageNamed:@"5.png"],
                                        [UIImage imageNamed:@"5.png"],
                                        [UIImage imageNamed:@"6.png"],
                                        [UIImage imageNamed:@"7.png"],
                                        [UIImage imageNamed:@"8.png"],
                                        [UIImage imageNamed:@"9.png"],
                                        [UIImage imageNamed:@"9.png"],
                                        [UIImage imageNamed:@"9.png"],
                                        [UIImage imageNamed:@"9.png"],
                                        [UIImage imageNamed:@"9.png"],
                                        [UIImage imageNamed:@"10.png"],
                                        [UIImage imageNamed:@"11.png"],
                                        [UIImage imageNamed:@"12.png"],
                                        [UIImage imageNamed:@"13.png"],
                                        [UIImage imageNamed:@"14.png"],
                                        [UIImage imageNamed:@"15.png"],
                                        [UIImage imageNamed:@"16.png"],
                                        [UIImage imageNamed:@"17.png"],
                                        nil];
        
        
        // all frames will execute in 1.75 seconds
        myImageView.animationDuration = 4;
        // repeat the annimation forever
        myImageView.animationRepeatCount = 1;
        // start animating
        [myImageView startAnimating];
        // add the animation view to the main window
        [self.view addSubview:myImageView];
        //  [campFireView release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
