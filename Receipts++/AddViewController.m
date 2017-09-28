//
//  AddViewController.m
//  Receipts++
//
//  Created by Jaison Bhatti on 2017-09-28.
//  Copyright © 2017 Jaison Bhatti. All rights reserved.
//

#import "AddViewController.h"
#import "AppDelegate.h"

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

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    
    // Dequeue a cell using a common ID string of your choosing
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    // Return cells with data/labels/pretty colors here
    if (row == 0)
    {
        cell.textLabel.text = @"Personal";
    }
    else if (row == 1)
    {
        cell.textLabel.text = @"Travel";
    }
    else if (row == 2)
    {
        cell.textLabel.text = @"Business";
    }
    
    
    return cell;  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellAccessoryCheckmark){
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }else{
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
}



@end
