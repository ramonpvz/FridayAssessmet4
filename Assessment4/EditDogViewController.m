//
//  EditViewController.m
//  Assessment4
//
//  Created by GLBMXM0002 on 10/24/14.
//  Copyright (c) 2014 MobileMakers. All rights reserved.
//

#import "EditDogViewController.h"
#import "Dog.h"

@interface EditDogViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *breed;
@property (weak, nonatomic) IBOutlet UITextField *color;

@end

@implementation EditDogViewController


- (IBAction)save:(id)sender {
    
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name.text = self.dog.name;
    self.breed.text = self.dog.breed;
    self.color.text = self.dog.color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
