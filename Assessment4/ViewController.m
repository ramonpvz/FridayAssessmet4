//
//  ViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "DogsViewController.h"
#import "Owner.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property UIAlertView *addAlert;
@property UIAlertView *colorAlert;
@property NSArray *owners;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dog Owners";
    [self loadOwners];
}

- (void) loadOwners {
    
    NSError *error1;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
    self.owners = [self.managedObjectContext executeFetchRequest:request error:&error1];
    
    if (self.owners.count == 0) {
    
        NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/25/owners.json"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSError *error;
            self.owners = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            for (NSString *_owner in self.owners)
            {
                Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner"inManagedObjectContext:self.managedObjectContext];
                owner.name = _owner;
                [self.managedObjectContext save:&error];
            }
            NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Owner"];
            self.owners = [self.managedObjectContext executeFetchRequest:request error:&error];
            NSLog(@"Owners: %lul", (unsigned long)self.owners.count);
            [self.myTableView  reloadData];
        }];
        
    }
    else {
        [self.myTableView  reloadData];
    }

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    DogsViewController *dogsVC = segue.destinationViewController;
    dogsVC.owner = [self.owners objectAtIndex:self.myTableView.indexPathForSelectedRow.row];
    
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.owners.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Owner *owner = [self.owners objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"myCell"];
    
    cell.textLabel.text = owner.name;

    return cell;
}

#pragma mark - UIAlertView Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //TODO: SAVE USER'S DEFAULT COLOR PREFERENCE USING THE CONDITIONAL BELOW

    if (buttonIndex == 0)
    {
        self.navigationController.navigationBar.tintColor = [UIColor purpleColor];
    }
    else if (buttonIndex == 1)
    {
        self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    }
    else if (buttonIndex == 2)
    {
        self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    }
    else if (buttonIndex == 3)
    {
        self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    }

}

//METHOD FOR PRESENTING USER'S COLOR PREFERENCE
- (IBAction)onColorButtonTapped:(UIBarButtonItem *)sender
{
    self.colorAlert = [[UIAlertView alloc] initWithTitle:@"Choose a default color!"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Purple", @"Blue", @"Orange", @"Green", nil];
    self.colorAlert.tag = 1;
    [self.colorAlert show];
}

@end
