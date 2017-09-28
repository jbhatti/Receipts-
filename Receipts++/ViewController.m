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

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<Receipt *>*receipts;
@property (nonatomic) NSManagedObjectContext *context;
@property (nonatomic, weak) AppDelegate *delegate;
@property (nonatomic) NSArray* tags;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tags = [[NSArray alloc] init];
    self.tags = [NSArray arrayWithObjects:@"Personal", @"Travel", @"Business", nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.delegate = ((AppDelegate*)[[UIApplication sharedApplication] delegate]);
    self.context = self.delegate.persistentContainer.viewContext;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(fetchData) name:NSManagedObjectContextDidSaveNotification object:nil];
}


#pragma mark Table View DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tags.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.receipts.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Receipt *receipt = self.receipts[indexPath.row];
    cell.textLabel.text = receipt.receiptDescription;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Header title: %@",  [self tableView:tableView titleForHeaderInSection:indexPath.section]);
}

#pragma mark segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Cell"]) {
        AddViewController *avc = segue.destinationViewController;
        avc.delegate = self.delegate;
        avc.context = self.context;
    }
}

#pragma mark Table View Header


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *result = [self.tags objectAtIndex:section];
        return result;
}



#pragma mark - Core Data

- (void)fetchData {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Receipt"];
    NSSortDescriptor *titleDesc = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:NO];
    request.sortDescriptors = @[titleDesc];
    NSArray <Receipt *>*receipt = [self.context executeFetchRequest:request error:nil];
    self.receipts = receipt;
    [self.tableView reloadData];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

@end
