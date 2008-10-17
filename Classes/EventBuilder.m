//
//  EventBuilder.m
//  Bussy
//
//  Created by Aaron Patterson on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EventBuilder.h"
#import "Event.h"

#include <libxml/parser.h>

@implementation EventBuilder

@synthesize eventList;
@synthesize currentEvent;
@synthesize characterBuffer;

void startElement(void *ctx, const xmlChar *name, const xmlChar **attrs)
{
  EventBuilder * self = (EventBuilder *)ctx;

  NSString * tagName = [[NSString alloc] initWithCString:(const char *)name];

    //[responseData appendString:newText];
  if([tagName isEqualToString:@"multiRef"]) {
    [self setCurrentEvent:[[Event alloc] init]];
  }
  [tagName release];

  [self setCharacterBuffer:[[NSMutableString alloc] init]];

}

void charactersFunction(void *ctx, const xmlChar *ch, int len)
{
  EventBuilder * self = (EventBuilder *)ctx;
  NSString * newText = [[NSString alloc] initWithCString:(const char *)ch
                                                  length:len];
  [[self characterBuffer] appendString:newText];
  [newText release];
}

void endElement(void *ctx, const xmlChar *name)
{
  EventBuilder * self = (EventBuilder *)ctx;
  NSString * tagName = [[NSString alloc] initWithCString:(const char *)name];

  if([tagName isEqualToString:@"multiRef"]) {
    [[self eventList] addObject:[self currentEvent]];
  }

  if([tagName isEqualToString:@"destination"]) {
    NSLog([self characterBuffer]);
    [[self currentEvent] setDestination:(NSString *)[self characterBuffer]];
  }

  if([tagName isEqualToString:@"type"]) {
    [[self currentEvent] setType:(NSString *)[self characterBuffer]];
  }

  if([tagName isEqualToString:@"goalDeviation"]) {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [formatter numberFromString:[self characterBuffer]];
    [[self currentEvent] setGoalDeviation:number];
    [formatter release];
  }

  if([tagName isEqualToString:@"schedTime"]) {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [formatter numberFromString:[self characterBuffer]];
    [[self currentEvent] setSchedTime:number];
    [formatter release];
  }

  if([tagName isEqualToString:@"goalTime"]) {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [formatter numberFromString:[self characterBuffer]];
    [[self currentEvent] setGoalTime:number];
    [formatter release];
  }

  if([tagName isEqualToString:@"distanceToGoal"]) {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [formatter numberFromString:[self characterBuffer]];
    [[self currentEvent] setDistanceToGoal:number];
    [formatter release];
  }

  if([tagName isEqualToString:@"route"]) {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [formatter numberFromString:[self characterBuffer]];
    [[self currentEvent] setRoute:number];
    [formatter release];
  }

  /*
  if([[self currentEvent] respondsToSelector:NSSelectorFromString(tagName)]) {
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    NSNumber * number = [formatter numberFromString:[self characterBuffer]];
    [[self currentEvent] performSelector:NSSelectorFromString(setter)
                              withObject:number];
    [formatter release];
  }
  */

  [tagName release];
}

- (EventBuilder *)init
{
  [super init];
  [self setCurrentEvent:nil];
  [self setEventList:[[NSMutableArray alloc] init]];
  return self;
}

- (void)dealloc
{
  if(nil != currentEvent) [currentEvent release]; 
  [eventList release];
  [super dealloc];
}

+ (NSArray *)fromXML:(NSString *)xmlData
{
  [xmlData retain];

  EventBuilder * builder = [[EventBuilder alloc] init];

  xmlSAXHandlerPtr handler = calloc(1, sizeof(xmlSAXHandler));
  handler->startElement = startElement;
  handler->endElement = endElement;
  handler->characters = charactersFunction;

  xmlSAXUserParseMemory(
    handler,
    (void *)builder,
    [xmlData UTF8String],
    [xmlData length]
  );

  [xmlData release];
  free(handler);

  NSMutableArray * eventList = [builder eventList];
  [builder release];

  return (NSArray *)eventList;
}

@end
