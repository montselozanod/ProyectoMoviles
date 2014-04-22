//
//  CanvasViewController.m
//  CursoMovil
//
//  Created by Eliézer Galván on 4/2/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import "CanvasViewController.h"
#import <Social/Social.h>

@interface CanvasViewController ()

@end

@implementation CanvasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	//Set up navbar buttons
	self.guardarBtn = [[UIBarButtonItem alloc] initWithTitle:@"Guardar" style:UIBarButtonItemStylePlain target:self action:@selector(guardarImagen)];
	self.shareFBBtn = [[UIBarButtonItem alloc] initWithTitle:@"Facebook" style:UIBarButtonItemStylePlain target:self action:@selector(shareFB)];
	self.shareTWBtn = [[UIBarButtonItem alloc] initWithTitle:@"Tweeter" style:UIBarButtonItemStylePlain target:self action:@selector(shareTW)];
	
	self.navigationItem.rightBarButtonItems = @[self.guardarBtn,self.shareFBBtn,self.shareTWBtn];
	
	//Set up color properties
	red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
	brush = 10.0;
	
	//Start spinner
	[self.spinner setHidesWhenStopped:YES];
	[self.spinner startAnimating];
	
	dispatch_async(dispatch_get_global_queue(0,0), ^{
		NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.image_url]];
		if ( data == nil )
			return;
		dispatch_async(dispatch_get_main_queue(), ^{
			self.mainImage.image = [UIImage imageWithData: data];
			[self.spinner stopAnimating];
		});
	});
}

- (void)viewDidUnload
{
    [self setMainImage:nil];
    [self setTempDrawImage:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma-mark Drawing methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = NO;
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.mainImage];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    mouseSwiped = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.mainImage];
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.tempDrawImage setAlpha:1.0];
    UIGraphicsEndImageContext();
    
    lastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!mouseSwiped) {
        UIGraphicsBeginImageContext(self.view.frame.size);
        [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.tempDrawImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    UIGraphicsBeginImageContext(self.mainImage.frame.size);
    [self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    [self.tempDrawImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height) blendMode:kCGBlendModeNormal alpha:1.0];
    self.mainImage.image = UIGraphicsGetImageFromCurrentImageContext();
    self.tempDrawImage.image = nil;
    UIGraphicsEndImageContext();
}

#pragma-mark Color changes

- (IBAction)blueAction:(id)sender
{
	red = 32.0/255.0;
	green = 63.0/255.0;
	blue = 251.0/255.0;
}

- (IBAction)purpleAction:(id)sender
{
	red = 124.0/255.0;
	green = 66.0/255.0;
	blue = 251.0/255.0;
}

- (IBAction)pinkAction:(id)sender
{
	red = 207.0/255.0;
	green = 62.0/255.0;
	blue = 251.0/255.0;
}

- (IBAction)redAction:(id)sender
{
	red = 184.0/255.0;
	green = 38.0/255.0;
	blue = 45.0/255.0;
}

- (IBAction)orangeAction:(id)sender
{
	red = 249.0/255.0;
	green = 143.0/255.0;
	blue = 37.0/255.0;
}

- (IBAction)yellowAction:(id)sender
{
	red = 253.0/255.0;
	green = 225.0/255.0;
	blue = 50.0/255.0;
}

- (IBAction)greenAction:(id)sender
{
	red = 60.0/255.0;
	green = 209.0/255.0;
	blue = 37.0/255.0;
}

- (IBAction)whiteAction:(id)sender
{
	red = 255.0/255.0;
	green = 255.0/255.0;
	blue = 255.0/255.0;
}

#pragma-mark Save image to library

-(void)guardarImagen
{
	UIGraphicsBeginImageContextWithOptions(self.mainImage.bounds.size, NO, 0.0);
	[self.mainImage.image drawInRect:CGRectMake(0, 0, self.mainImage.frame.size.width, self.mainImage.frame.size.height)];
	UIImage *SaveImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	UIImageWriteToSavedPhotosAlbum(SaveImage, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//Delegate for image saved in library
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Hubo un error guardando la imagen."  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Cerrar", nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Listo!" message:@"La imagen ha sido guardada en el album de fotos."  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Cerrar", nil];
        [alert show];
    }
}

#pragma-mark Social

-(void)shareFB{
	
	if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
	{
		SLComposeViewController *fbComposer = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
		
		//set the initial text message
		[fbComposer setInitialText:@"Aprendiendo sobre el ambiente!"];
		[fbComposer addImage: self.mainImage.image];
		
		//present the composer to the user
		[self presentViewController:fbComposer animated:YES completion:nil];
		
	}else {
		UIAlertView *alertView = [[UIAlertView alloc]
								  initWithTitle:@"Facebook Error"
								  message:@"No hay una cuenta registrada!"
								  delegate:self
								  cancelButtonTitle:@"OK"
								  otherButtonTitles: nil];
		[alertView show];
		
	}
}

- (void)shareTW{

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetController = [SLComposeViewController
                                                    composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        //set the initial text message
        [tweetController setInitialText:@"Aprendiendo sobre el ambiente!"];
		[tweetController addImage:self.mainImage.image];
        
        //present the controller to the user
        [self presentViewController:tweetController animated:YES completion:nil];
    }
    else{
		UIAlertView *alertView = [[UIAlertView alloc]
								  initWithTitle:@"twitter Error"
								  message:@"No hay una cuenta registrada!"
								  delegate:self
								  cancelButtonTitle:@"OK"
								  otherButtonTitles: nil];
		[alertView show];
		
    }
	
}

@end