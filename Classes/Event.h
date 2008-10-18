//
//  Event.h
//  Bussy
//
//  Created by Aaron Patterson on 10/13/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
<goalDeviation xsi:type="xsd:int">43200</goalDeviation>
<schedTime xsi:type="xsd:int">66586</schedTime>
<timestamp xsi:type="xsd:long">1223688694648</timestamp>
<goalTime xsi:type="xsd:int">-1</goalTime>
<type xsi:type="xsd:string">d</type>
<distanceToGoal xsi:type="xsd:int">-717</distanceToGoal>
<destination xsi:type="xsd:string">North Seattle - Leary Ave NW and NW Vernon Pl</destination>
*/

@interface Event : NSObject {
  NSNumber * goalDeviation;
  NSNumber * schedTime;
  NSNumber * goalTime;
  NSNumber * distanceToGoal;
  NSNumber * route;
  NSString * type;
  NSString * destination;
}

@property (nonatomic, retain) NSNumber * goalDeviation;
@property (nonatomic, retain) NSNumber * schedTime;
@property (nonatomic, retain) NSNumber * goalTime;
@property (nonatomic, retain) NSNumber * distanceToGoal;
@property (nonatomic, retain) NSNumber * route;

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * destination;

- (NSString *)direction;
- (NSString *)title;
- (NSComparisonResult)schedTimeCompare:(Event *)other;
- (NSComparisonResult)routeCompare:(Event *)other;

@end
