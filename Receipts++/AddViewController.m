//
//  AddViewController.m
//  Receipts++
//
//  Created by Jaison Bhatti on 2017-09-28.
//  Copyright © 2017 Jaison Bhatti. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"
#import "Tag+CoreDataProperties.h"

@interface AddViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *receiptDatePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)addReceiptButton:(UIButton *)sender {
    NSString * receiptDesc = self.descriptionTextField.text;
    Receipt *receipt = [[Receipt alloc] initWithContext:self.context];
    receipt.receiptDescription = receiptDesc;
    NSArray *indexPaths = [self.tableView indexPathsForSelectedRows];
    for (NSIndexPath *path in indexPaths) {
        [receipt addTagsObject:self.tags[path.row]];
    }
    [self.delegate saveContext];
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
    
}


- (IBAction)cancelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];

}


#pragma mark TableView

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Tag *tag = self.tags[row];
    cell.textLabel.text = tag.tagName;
    self.tableView.allowsMultipleSelection = YES;
    
    return cell;  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark)
    {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
    else
   {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
         //self.currentCategory = [taskCategories objectAtIndex:indexPath.row];
    }
}



@end
