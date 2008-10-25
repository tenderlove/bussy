//
//  EventBuilder.m
//  Bussy
//
//  Created by Aaron Patterson on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "EventBuilder.h"
#import "Event.h"

@implementation EventBuilder

@synthesize eventList;
@synthesize currentEvent;
@synthesize characterBuffer;
@synthesize delegate;

-  (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict
{
  if([elementName isEqualToString:@"multiRef"]) {
    [self setCurrentEvent:[[Event alloc] init]];
  }

  [self setCharacterBuffer:[[NSMutableString alloc] init]];
}

-  (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string
{
  if(nil == [self characterBuffer]) return;

  [[self characterBuffer] appendString:string];
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)tagName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
  if([tagName isEqualToString:@"multiRef"]) {
    [[self eventList] addObject:[self currentEvent]];
  }

  if([tagName isEqualToString:@"destination"]) {
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

  [self setCharacterBuffer: nil];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parserError
{
  [delegate performSelector:@selector(showAlert)];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
  [delegate performSelector:@selector(setLoadingBusData:) withObject:NO];
  [delegate performSelector:@selector(setArrivals:) withObject:
    [[self eventList] sortedArrayUsingSelector:@selector(goalTimeCompare:)]];
}

- (EventBuilder *)initWithDelegate:(id)del
{
  [super init];
  [self setCurrentEvent:nil];
  [self setEventList:[[NSMutableArray alloc] init]];
  [self setDelegate:del];
  return self;
}

- (void)dealloc
{
  if(nil != currentEvent) [currentEvent release]; 
  [eventList release];
  [delegate release];
  [super dealloc];
}

@end
