//
//  ViewController.m
//  Receipts++
//
//  Created by Jaison Bhatti on 2017-09-28.
//  Copyright © 2017 Jaison Bhatti. All rights reserved.
//

#import "ViewController.h"
#import "Receipt+CoreDataClass.h"
#import "AppDelegate.h"
#import "AddViewController.h"
#import "Tag+CoreDataClass.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<Receipt *>*receipts;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic, weak) AppDelegate *delegate;
@property (nonatomic) NSArray<Tag *>* tags;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    self.tags = [self.context executeFetchRequest:request error:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.delegate = ((AppDelegate*)[[UIApplication sharedApplication] delegate]);
    self.context = self.delegate.persistentContainer.viewContext;
    [self fetchData];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(fetchData) name:NSManagedObjectContextDidSaveNotification object:nil];
}


#pragma mark Table View DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tags.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Tag *tagX = self.tags[section];
    return tagX.receipts.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Receipt *receipt = self.tags[indexPath.section].receipts.allObjects[indexPath.row];
    cell.textLabel.text = receipt.receiptDescription;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Header title: %@", [self tableView:tableView titleForHeaderInSection:indexPath.section]);
}

#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Cell"]) {
        AddViewController *avc = segue.destinationViewController;
        avc.delegate = self.delegate;
        avc.context = self.context;
        avc.tags = self.tags;
    }
}

#pragma mark Table View Header


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@", self.tags[section].tagName];
}

#pragma mark - Core Data

- (void)fetchData {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    NSSortDescriptor *tagDesc = [NSSortDescriptor sortDescriptorWithKey:@"tagName" ascending:NO];
    request.sortDescriptors = @[tagDesc];
    NSArray <Tag *>*tag = [self.context executeFetchRequest:request error:nil];
    self.tags = tag;
    [self.tableView reloadData];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
