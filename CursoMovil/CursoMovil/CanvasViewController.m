//
//APRENDIZAJE VERDE - CUIDANDO EL AMBIENTE
//Mobile Development Course Project
//
//Copyright (C) 2014 - ITESM
//
//This program is free software: you can redistribute it and/or modify
//it under the terms of the GNU General Public License as published by
//the Free Software Foundation, either version 3 of the License, or
//(at your option) any later version.
//
//This program is distributed in the hope that it will be useful,
//but WITHOUT ANY WARRANTY; without even the implied warranty of
//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//GNU General Public License for more details.
//
//You should have received a copy of the GNU General Public License
//along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//
//Authors:
//
//ITESM representatives
//Ing. Martha Sordia Salinas <msordia@itesm.mx>
//Dr. Juan Arturo Nolazco Flores <jnolazco@itesm.mx>
//Ing. Maria Isabel Cabrera Cancino <marisa.cabrera@tecvirtual.mx>
//
//
//ITESM students (developers)
//Eliezer Galvan <a01190876@itesm.mx>
//Montserrat Lozano <a01088686@itesm.mx>
//Adrian Rangel <a01190871@itesm.mx>

#import "CanvasViewController.h"
#import <Social/Social.h>
#import "ManejoBD.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	//Set up navbar buttons
	self.guardarBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save30.png"] style:UIBarButtonItemStylePlain target:self action:@selector(guardarImagen)];
	self.shareFBBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"facebook30.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareFB)];
	self.shareTWBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"twitter30.png"] style:UIBarButtonItemStylePlain target:self action:@selector(shareTW)];
	
	self.navigationItem.rightBarButtonItems = @[self.guardarBtn,self.shareFBBtn,self.shareTWBtn];
	
	//Set up color properties
	red = 0.0/255.0;
    green = 0.0/255.0;
    blue = 0.0/255.0;
	brush = 15.0;
	
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

-(void)viewDidDisappear:(BOOL)animated
{
    ManejoBD *bd = [ManejoBD instancia];
	[bd initUsuario];

	//Point test for act 3
	if(self.source==0){//agua
		if([bd hasMod4Act3]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod4Act3:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==1){//reciclaje
		if([bd hasMod2Act3]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod2Act3:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==2){//biodiversidad
		if([bd hasMod3Act3]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod3Act3:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}else if(self.source==3){//renovables
		if([bd hasMod1Act3]==[NSNumber numberWithInt:0]){
			[bd addPuntos:[NSNumber numberWithInt:100]];
			[bd setMod1Act3:[NSNumber numberWithInt:1]];
			[[[UIAlertView alloc] initWithTitle:@"Felicidades!" message:@"Has ganado 100 puntos!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
		}
	}
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