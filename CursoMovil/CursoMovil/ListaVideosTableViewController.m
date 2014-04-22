//
//  ListaVideosTableViewController.m
//  CursoMovil
//
//  Created by Eliézer Galván on 4/19/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ListaVideosTableViewController.h"
#import "VideosViewController.h"

@interface ListaVideosTableViewController ()

@end

@implementation ListaVideosTableViewController

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
    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
   	cell.textLabel.text = [self.videos[indexPath.row] objectForKey:@"nombre"];
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender;
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	
	VideosViewController *vc = [segue destinationViewController];
	vc.url = [self.videos[indexPath.row] objectForKey:@"url"];
}

@end
