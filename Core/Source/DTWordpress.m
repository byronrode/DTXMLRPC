//
//  DTWordpress.m
//  WordpressDemo
//
//  Created by Oliver Drobnik on 22.03.13.
//  Copyright (c) 2013 Drobnik KG. All rights reserved.
//

#import "DTWordpress.h"
#import "DTXMLRPC.h"

@implementation DTWordpress

- (void)getUsersBlogsWithCompletion:(void(^)(NSArray *blogs, NSError *error))completion
{
    NSAssert(_userName, @"User Name needs to be set");
    NSAssert(_password, @"Password needs to be set");
    
    NSArray *parameters = @[@(-1), _userName, _password];
    
    DTXMLRPCRequest *request = [[DTXMLRPCRequest alloc] initWithMethodName:@"metaWeblog.getUsersBlogs" parameters:parameters];
    
    [self sendRequest:request completion:^(DTXMLRPCResponse *response) {
        if (completion)
        {
            NSArray *blogs = nil;
            NSError *error = response.error;
            
            if (!error)
            {
                blogs = [response.parameters objectAtIndex:0];
            }
            
            completion(blogs, error);
        }
    }];
}

- (void)getCategoriesWithCompletion:(void(^)(NSArray *categories, NSError *error))completion
{
    NSAssert(_userName, @"User Name needs to be set");
    NSAssert(_password, @"Password needs to be set");
    
    NSArray *parameters = @[@(-1), _userName, _password];
    
    DTXMLRPCRequest *request = [[DTXMLRPCRequest alloc] initWithMethodName:@"metaWeblog.getCategories" parameters:parameters];
    
    [self sendRequest:request completion:^(DTXMLRPCResponse *response) {
        if (completion)
        {
            NSArray *categories = nil;
            NSError *error = response.error;
            
            if (!error)
            {
                categories = [response.parameters objectAtIndex:0];
            }
            
            completion(categories, error);
        }
    }];
}

- (void)getPostWithIdentifier:(NSUInteger)identifier completion:(void(^)(NSDictionary *content, NSError *error))completion
{
    NSAssert(_userName, @"User Name needs to be set");
    NSAssert(_password, @"Password needs to be set");
    
    NSArray *parameters = @[@(identifier), _userName, _password];
    
    DTXMLRPCRequest *request = [[DTXMLRPCRequest alloc] initWithMethodName:@"metaWeblog.getPost" parameters:parameters];
    
    [self sendRequest:request completion:^(DTXMLRPCResponse *response) {
        if (completion)
        {
            NSDictionary *content = nil;
            NSError *error = response.error;
            
            if (!error)
            {
                content = [response.parameters objectAtIndex:0];
            }
            
            completion(content, error);
        }
    }];
}

- (void)newPostWithContent:(NSDictionary *)content shouldPublish:(BOOL)shouldPublish completion:(void(^)(NSInteger postID, NSError *error))completion
{
    NSAssert(_userName, @"User Name needs to be set");
    NSAssert(_password, @"Password needs to be set");
    NSAssert(content, @"Content needs to be set");
    
    NSArray *parameters = @[@(1), _userName, _password, content, [NSNumber numberWithBool:shouldPublish]];
    
    DTXMLRPCRequest *request = [[DTXMLRPCRequest alloc] initWithMethodName:@"metaWeblog.newPost" parameters:parameters];
    
    [self sendRequest:request completion:^(DTXMLRPCResponse *response) {
        if (completion)
        {
            NSString *newPostIdentifier = nil;
            NSError *error = response.error;
            
            if (!error)
            {
                newPostIdentifier = [response.parameters objectAtIndex:0];
            }
            
            completion([newPostIdentifier integerValue], error);
        }
    }];
}

@end
