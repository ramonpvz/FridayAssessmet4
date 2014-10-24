//
//  DogsViewController.m
//  Assessment4
//
//  Created by Vik Denic on 8/11/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "DogsViewController.h"
#import "AddDogViewController.h"
#import "EditDogViewController.h"
#import "Dog.h"

@interface DogsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *dogsTableView;
@property NSArray *dogs;

@end

@implementation DogsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Dogs";
    [self loadDogs];
}

-(void) loadDogs {
    
    self.dogs = [self.owner.dogs allObjects];
    
    [self.dogsTableView reloadData];
    
}

#pragma mark - UITableView Delegate Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dogs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Dog *dog = [self.dogs objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"dogCell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", dog.name, dog.color];
    
    cell.detailTextLabel.text = dog.breed;
    
    return cell;
}

- (IBAction)unwindPerson:(UIStoryboardSegue *)segue {
    
    [self loadDogs];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"AddDogSegue"])
    {
        AddDogViewController *addDogVC = segue.destinationViewController;
        addDogVC.owner = self.owner;
    }
    else
    {
        EditDogViewController *editVC = segue.destinationViewController;
        editVC.dog = [self.dogs objectAtIndex:self.dogsTableView.indexPathForSelectedRow.row];
    }
}

@end
