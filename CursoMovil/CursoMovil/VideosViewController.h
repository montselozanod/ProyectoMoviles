//
//  VideosViewController.h
//  CursoMovil
//
//  Created by Eliézer Galván on 3/28/14.
//  Copyright (c) 2014 ITESM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideosViewController : UIViewController

@property (strong, nonatomic) NSString *url;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
