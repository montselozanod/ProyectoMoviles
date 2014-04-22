//
//  CanvasViewController.h
//  CursoMovil
//
//  Created by Eliézer Galván on 4/2/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanvasViewController : UIViewController{

	CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
	
    BOOL mouseSwiped;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSString *image_url;

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

@property (strong, nonatomic) UIBarButtonItem *guardarBtn;
@property (strong, nonatomic) UIBarButtonItem *shareFBBtn;
@property (strong, nonatomic) UIBarButtonItem *shareTWBtn;

//color buttons actions
- (IBAction)blueAction:(id)sender;
- (IBAction)purpleAction:(id)sender;
- (IBAction)pinkAction:(id)sender;
- (IBAction)redAction:(id)sender;
- (IBAction)orangeAction:(id)sender;
- (IBAction)yellowAction:(id)sender;
- (IBAction)greenAction:(id)sender;
- (IBAction)whiteAction:(id)sender;

@end