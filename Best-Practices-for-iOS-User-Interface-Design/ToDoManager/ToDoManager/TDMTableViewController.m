//
//  TDMTableViewController.m
//  ToDoManager
//
//  Created by Alexey Huralnyk on 2/21/16.
//  Copyright © 2016 Alexey Huralnyk. All rights reserved.
//

#import "TDMTableViewController.h"
#import <CoreData/CoreData.h>
#import "TDMTableViewCell.h"
#import "ToDoEntity.h"
#import "TDMHandlerToDoEntity.h"

@interface TDMTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSManagedObjectContext *moc;
@property (nonatomic) NSFetchedResultsController *resultsController;

@end

@implementation TDMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Initialization
#

- (NSFetchedResultsController *)resultsController {

    // Lazy instatiation
    if (!_resultsController) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"ToDoEntity"];
        request.predicate = [NSPredicate predicateWithFormat:@"TRUEPREDICATE"];
        request.sortDescriptors = @[
            [NSSortDescriptor sortDescriptorWithKey:@"done" ascending:YES],
            [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:NO],
            [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]
        ];
        _resultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.moc sectionNameKeyPath:nil cacheName:nil];
        _resultsController.delegate = self;
        
        NSError *error;
        BOOL success = [_resultsController performFetch:&error];
        if (!success) {
            @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Couldn't fetch" userInfo:@{NSUnderlyingErrorKey : error}];
        }
        
    }
    
    return _resultsController;
}

#pragma mark - Naviagation
#

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Figure out what To Do Entity to edit
    ToDoEntity *item;
    if ([sender isMemberOfClass:[UIBarButtonItem class]]) {
        // Brand new one
        item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoEntity" inManagedObjectContext:self.moc];
    } else {
        // Exsiting one
        TDMTableViewCell *cell = (TDMTableViewCell *)sender;
        item = cell.item;
    }
    
    id<TDMHandlerMOC, TDMHandlerToDoEntity> child = (id<TDMHandlerMOC, TDMHandlerToDoEntity>)segue.destinationViewController;
    [child setMOC:self.moc];
    [child setToDoItem:item];
}




#pragma mark - Table View Data Source
#

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.resultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultsController.sections[section].numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TDMTableViewCell *cell = (TDMTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    ToDoEntity *item = (ToDoEntity *)[self.resultsController objectAtIndexPath:indexPath];
    [cell setToDoItem:item];
    return cell;
}


#pragma mark - Table View Delegate
#



#pragma mark - MOC Handler
#

- (void)setMOC:(NSManagedObjectContext *)context {
    self.moc = context;
}

#pragma mark - Fetched Results Controller Delegate
#

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
