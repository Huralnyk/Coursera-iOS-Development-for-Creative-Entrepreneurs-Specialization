//
//  ViewController.m
//  DrumKit
//
//  Created by Alexey Huralnyk on 4/5/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "UIButton+Extensions.h"

@interface ViewController ()

@property (strong, nonatomic) AVAudioPlayer *player;

@property (assign, nonatomic) SystemSoundID sample01;
@property (assign, nonatomic) SystemSoundID sample02;
@property (assign, nonatomic) SystemSoundID sample03;
@property (assign, nonatomic) SystemSoundID sample04;
@property (assign, nonatomic) SystemSoundID sample05;
@property (assign, nonatomic) SystemSoundID sample06;

@property (assign, nonatomic, getter=isPlaying) BOOL playing;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSounds];
    [self loadSong];
    [self configureButtons];
}

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(self.sample01);
    AudioServicesDisposeSystemSoundID(self.sample02);
    AudioServicesDisposeSystemSoundID(self.sample03);
    AudioServicesDisposeSystemSoundID(self.sample04);
    AudioServicesDisposeSystemSoundID(self.sample05);
    AudioServicesDisposeSystemSoundID(self.sample06);
}

- (void)loadSounds {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"sample-01" withExtension:@"wav"];
    OSStatus status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_sample01);
    
    if (status != kAudioSessionNoError) {
        [self showAlert];
    }
    
    url = [[NSBundle mainBundle] URLForResource:@"sample-02" withExtension:@"wav"];
    status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_sample02);
    
    if (status != kAudioSessionNoError) {
        [self showAlert];
    }
    
    url = [[NSBundle mainBundle] URLForResource:@"sample-03" withExtension:@"wav"];
    status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_sample03);
    
    if (status != kAudioSessionNoError) {
        [self showAlert];
    }
    
    url = [[NSBundle mainBundle] URLForResource:@"sample-04" withExtension:@"wav"];
    status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_sample04);
    
    if (status != kAudioSessionNoError) {
        [self showAlert];
    }
    
    url = [[NSBundle mainBundle] URLForResource:@"sample-05" withExtension:@"wav"];
    status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_sample05);
    
    if (status != kAudioSessionNoError) {
        [self showAlert];
    }
    
    url = [[NSBundle mainBundle] URLForResource:@"sample-06" withExtension:@"wav"];
    status = AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &_sample06);
    
    if (status != kAudioSessionNoError) {
        [self showAlert];
    }
}


- (void)loadSong {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"wipeout" withExtension:@"mp3"];
    
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (error) {
        self.playButton.enabled = NO;
        self.stopButton.enabled = NO;
    }
}

- (void)configureButtons {
    for (UIButton *button in self.buttons) {
        [button setBackgroundColor:button.backgroundColor forState:UIControlStateNormal];
    }
}

- (void)showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Oops!" message:@"Can't load sound" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)playSample01:(UIButton *)sender {
    AudioServicesPlayAlertSound(self.sample01);
}

- (IBAction)playSample02:(UIButton *)sender {
    AudioServicesPlayAlertSound(self.sample02);
}

- (IBAction)playSample03:(UIButton *)sender {
    AudioServicesPlayAlertSound(self.sample03);
}

- (IBAction)playSample04:(UIButton *)sender {
    AudioServicesPlayAlertSound(self.sample04);
}

- (IBAction)playSample05:(UIButton *)sender {
    AudioServicesPlayAlertSound(self.sample05);
}

- (IBAction)playSample06:(UIButton *)sender {
    AudioServicesPlayAlertSound(self.sample06);
}

- (IBAction)playPauseButtonTapped:(UIButton *)sender {
    if (self.isPlaying) {
        self.playing = NO;
        [self.player pause];
        [sender setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    } else {
        self.playing = YES;
        [self.player play];
        [sender setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
}

- (IBAction)stopButtonTapped:(UIButton *)sender {
    if (self.isPlaying) {
        self.playing = NO;
        [self.player stop];
        [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        self.player.currentTime = 0;
    }
}



@end
