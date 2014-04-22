//
//  ListaConsejosTableViewController.m
//  CursoMovil
//
//  Created by Eliézer Galván on 4/19/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ListaConsejosTableViewController.h"

@interface ListaConsejosTableViewController ()

@end

@implementation ListaConsejosTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

	cell.textLabel.text = @"Consejo";
	
	return cell;
}

@end
