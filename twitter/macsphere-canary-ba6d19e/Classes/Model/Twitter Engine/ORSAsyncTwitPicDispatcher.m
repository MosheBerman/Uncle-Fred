//
//  ORSAsyncTwitPicDispatcher.h
//  Twitter Engine
//
//  Created by Nicholas Toumpelis on 12/04/2009.
//  Copyright 2008-2009 Ocean Road Software, Nick Toumpelis.
//
//  Version 0.7.1
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy 
//  of this software and associated documentation files (the "Software"), to 
//  deal in the Software without restriction, including without limitation the 
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
//  sell copies of the Software, and to permit persons to whom the Software is 
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in 
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
//  IN THE SOFTWARE.

#import "ORSAsyncTwitPicDispatcher.h"

@implementation ORSAsyncTwitPicDispatcher

// Uploads the picture data to TwitPic
- (void) uploadData:(NSData *)imageData
	   withUsername:(NSString *)username
		   password:(NSString *)password 
		   filename:(NSString *)filename {
	@synchronized(self) {
		NSURL *url = [NSURL URLWithString:@"http://twitpic.com/api/upload"];
		NSMutableURLRequest *postRequest = [NSMutableURLRequest 
			requestWithURL:url
				cachePolicy:NSURLRequestUseProtocolCachePolicy 
					timeoutInterval:21.0];
		
		[postRequest setHTTPMethod:@"POST"];
		
		NSString *stringBoundary = [NSString 
									stringWithString:@"0xKhTmLbOuNdArY"];
		NSString *contentType = [NSString 
				stringWithFormat:@"multipart/form-data; boundary=%@",
								 stringBoundary];
		[postRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
		
		NSMutableData *postBody = [NSMutableData data];
		[postBody appendData:[[NSString stringWithFormat:@"\r\n\r\n--%@\r\n", 
				stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithString:
			@"Content-Disposition: form-data; name=\"source\"\r\n\r\n"] 
							  dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithString:@"canary"] 
							  dataUsingEncoding:NSUTF8StringEncoding]];
		
		[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", 
			stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithString:
			@"Content-Disposition: form-data; name=\"username\"\r\n\r\n"]
							  dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[username dataUsingEncoding:NSUTF8StringEncoding]];
		
		[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",
			stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithString:
			@"Content-Disposition: form-data; name=\"password\"\r\n\r\n"] 
							  dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[password dataUsingEncoding:NSUTF8StringEncoding]];
		
		NSString *mimeType = NULL;
		if ([filename hasSuffix:@".jpeg"] || [filename hasSuffix:@".jpg"] || 
			[filename hasSuffix:@".jpe"]) {
			mimeType = @"image/jpeg";
		} else if ([filename hasSuffix:@".png"]) {
			mimeType = @"image/png";
		} else if ([filename hasSuffix:@".gif"]) {
			mimeType = @"image/gif";
		}	
		
		[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",
			stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithFormat:
		@"Content-Disposition: form-data; name=\"media\"; filename=\"%@\"\r\n", 
			filename] dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithFormat:
			@"Content-Type: %@\r\n", mimeType] 
				dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:[[NSString stringWithString:
			@"Content-Transfer-Encoding: binary\r\n\r\n"] 
				dataUsingEncoding:NSUTF8StringEncoding]];
		[postBody appendData:imageData];
		[postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",
			stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
		
		[postRequest setHTTPBody:postBody];
		
		mainConnection = [[NSURLConnection alloc] initWithRequest:postRequest 
														 delegate:self];
		dataReceived = [NSMutableData data];
	}
}

#pragma mark NSURLConnection delegates for async conn

// NSURLConnection delegates for asynchronous connections

// is called when the connection receives a response from the server.
- (void) connection:(NSURLConnection *)connection 
 didReceiveResponse:(NSURLResponse *)response {
	@synchronized(self) {
		NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		[nc postNotificationName:@"OTEReceivedResponse"
						  object:response];
		[dataReceived setLength:0];
	}
}

// is called when the connection receives some data from the server.
- (void) connection:(NSURLConnection *)connection 
	 didReceiveData:(NSData *)dataReceivedArg {
	@synchronized(self) {
		[dataReceived appendData:dataReceivedArg];
	}
}

// is called when the connection faces some kind of error.
- (void) connection:(NSURLConnection *)connection
   didFailWithError:(NSError *)connectionError {
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc postNotificationName:@"OTEConnectionFailure"
					  object:connectionError];
}

// is called when the data received from the server finishes.
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
	@synchronized(self) {
		NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
		NSError *documentError, *nodeError = NULL;
		NSString *stringNode = [[NSString alloc] initWithData:dataReceived
								encoding:NSUTF8StringEncoding];
		NSXMLDocument *document = [[NSXMLDocument alloc] 
			initWithXMLString:stringNode
				options:NSXMLDocumentTidyXML 
					error:&documentError];
		NSXMLNode *root = [document rootElement];
		NSString *returnedURL = [(NSXMLNode *)[[root 
			nodesForXPath:@".//mediaurl" error:&nodeError] 
							  objectAtIndex:0] stringValue];
		[nc postNotificationName:@"OTEReceivedTwitPicResponse"
						  object:returnedURL];
	}
}

@end
