//
//  EventBuilder.h
//  Bussy
//
//  Created by Aaron Patterson on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Event;

@interface EventBuilder : NSObject {
  Event * currentEvent;
  NSMutableArray * eventList;
  NSMutableString * characterBuffer;
  id delegate;
}

- (EventBuilder *)initWithDelegate:(id)delegate;

@property (nonatomic, retain) NSMutableArray *eventList;
@property (nonatomic, retain) Event *currentEvent;
@property (nonatomic, retain) NSMutableString *characterBuffer;
@property (nonatomic, retain) id delegate;

@end
