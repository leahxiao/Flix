//
//  TrailerViewController.m
//  Flix
//
//  Created by Leah Xiao on 6/28/18.
//  Copyright © 2018 Leah Xiao. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *WebView;
//@property NSArray *returnedResults;
//@property NSDictionary *returnedDict;
//@property NSString *returnedKey;


@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchTrailer];
    
    
    
   
    
    
    
    
    
    
    // Do any additional setup after loading the view.
    
}

- (void) fetchTrailer{
    NSString *firstPart = @"https://api.themoviedb.org/3/movie/";
    NSString *transition = [firstPart stringByAppendingString: self.movieInfo];
    NSString *secondPart = @"/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US";
    NSString *finalURLString = [transition stringByAppendingString:secondPart];
    
    NSURL *url = [NSURL URLWithString:finalURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else { // api gave something back, turn the JSON into an objc dict
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *returnedResults = dataDictionary[@"results"];
            NSDictionary *returnedDict = returnedResults[0];
            NSString *returnedKey = returnedDict[@"key"];
            
            NSString *baseURLString = @"https://www.youtube.com/watch?v=";
            NSString *fullTrailerURLString = [baseURLString stringByAppendingString:returnedKey];
            // Convert the url String to a NSURL object.
            NSURL *trailerURL = [NSURL URLWithString:fullTrailerURLString];
            
            // Place the URL in a URL Request.
            NSURLRequest *request = [NSURLRequest requestWithURL:trailerURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                 timeoutInterval:10.0];
            // Load Request into WebView.
            [self.WebView loadRequest:request];
        }
    }];
    
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UIImage *moviePoster = sender;
//    NSDictionary *movie = self.movies[indexPath.row];
//    TrailerViewController *trailerViewController = [segue destinationViewController];
//    TrailerViewController.movie = movie; // just pass over the one movie, not configure views of details of view controller
//    // Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
//}


@end
