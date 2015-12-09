//
//  ViewController.m
//  ComicBookStore
//
//  Created by Alexey Huralnyk on 12/9/15.
//  Copyright © 2015 Alexey Huralnyk. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "ComicBookMO.h"
#import "PersonMO.h"

@interface ViewController () <UINavigationBarDelegate>
@property (nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *publisherField;
@property (weak, nonatomic) IBOutlet UITextField *genreField;
@property (weak, nonatomic) IBOutlet UILabel *persistedData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self updateTitle];
    [self updateLogList];
}

- (IBAction)addComicBookTapped:(id)sender {
    ComicBookMO *cb = [self.appDelegate createComicBookMO];
    
    cb.title = self.titleField.text;
    cb.publisher = self.publisherField.text;
    cb.genre = self.genreField.text;
    
    [self.appDelegate saveContext];
    [self updateTitle];
    [self updateLogList];
}

- (IBAction)clearDataBaseTapped:(id)sender {
    NSManagedObjectContext *moc = [self.appDelegate managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ComicBook"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching ComicBook objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (ComicBookMO *cb in results) {
        [moc deleteObject:cb];
    }
    
    
    request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    results = [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching Person objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    for (PersonMO *p in results) {
        [moc deleteObject:p];
    }
    
    [self updateTitle];
    [self updateLogList];
}

- (void)updateTitle {
    NSManagedObjectContext *moc = [self.appDelegate managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ComicBook"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching ComicBook objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    self.navigationItem.title = [NSString stringWithFormat:@"%lu Item(s)", (unsigned long)results.count];
}

- (void)updateLogList {
    NSManagedObjectContext *moc = [self.appDelegate managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ComicBook"];
    
    NSError *error = nil;
    NSArray *results = [moc executeFetchRequest:request error:&error];
    
    if (!results) {
        NSLog(@"Error fetching ComicBook objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
    
    if (results.count == 0) {
        self.persistedData.text = @"Database is empty";
    } else {
        NSMutableString *buffer = [[NSMutableString alloc] init];
        for (ComicBookMO *cb in results) {
            [buffer appendFormat:@"\n%@", cb];
        }
        self.persistedData.text = buffer;
    }
    
}

- (UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}

@end
