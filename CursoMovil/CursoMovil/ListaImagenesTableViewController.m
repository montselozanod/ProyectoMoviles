//
//  ListaImagenesTableViewController.m
//  CursoMovil
//
//  Created by Eliézer Galván on 4/14/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "ListaImagenesTableViewController.h"
#import "CanvasViewController.h"

@interface ListaImagenesTableViewController ()
{
	NSMutableArray *lista;
}

@end

@implementation ListaImagenesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	lista = [[NSMutableArray alloc] init];
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
    return self.imagenes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
   	cell.textLabel.text = [self.imagenes[indexPath.row] objectForKey:@"nombre"];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	UITableViewCell *cell = (UITableViewCell *)sender;
	NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
	
	CanvasViewController *canvas = [segue destinationViewController];
	canvas.image_url = [self.imagenes[indexPath.row] objectForKey:@"url"];
}

@end
