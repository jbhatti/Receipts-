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





@end
