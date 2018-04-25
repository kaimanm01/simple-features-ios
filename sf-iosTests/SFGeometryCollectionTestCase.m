//
//  SFGeometryCollectionTestCase.m
//  sf-iosTests
//
//  Created by Brian Osborn on 4/25/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SFTestUtils.h"
#import "SFGeometryTestUtils.h"
#import "SFPoint.h"
#import "SFExtendedGeometryCollection.h"

@interface SFGeometryCollectionTestCase : XCTestCase

@end

@implementation SFGeometryCollectionTestCase

-(void) setUp {
    [super setUp];
}

-(void) tearDown {
    [super tearDown];
}

-(void) testMultiPoint {
    
    NSMutableArray<SFPoint *> *points = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++){
        [points addObject:[SFGeometryTestUtils createPointWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
    }
    
    NSMutableArray<SFGeometry *> *geometries = [[NSMutableArray alloc] init];
    [geometries addObjectsFromArray:points];
    
    SFMultiPoint *multiPoint = [[SFMultiPoint alloc] initWithPoints:points];
    SFGeometryCollection *geometryCollection = [[SFGeometryCollection alloc] initWithGeometries:geometries];

    [SFTestUtils assertEqualIntWithValue:[multiPoint numPoints] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualIntWithValue:[multiPoint numGeometries] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualWithValue:multiPoint.geometries andValue2:geometryCollection.geometries];
    
    [SFTestUtils assertTrue:[multiPoint isMultiPoint]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOINT andValue2:[multiPoint collectionType]];
    [SFTestUtils assertFalse:[multiPoint isMultiLineString]];
    [SFTestUtils assertFalse:[multiPoint isMultiCurve]];
    [SFTestUtils assertFalse:[multiPoint isMultiPolygon]];
    [SFTestUtils assertFalse:[multiPoint isMultiSurface]];
    
    [SFTestUtils assertTrue:[geometryCollection isMultiPoint]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOINT andValue2:[geometryCollection collectionType]];
    [SFTestUtils assertFalse:[geometryCollection isMultiLineString]];
    [SFTestUtils assertFalse:[geometryCollection isMultiCurve]];
    [SFTestUtils assertFalse:[geometryCollection isMultiPolygon]];
    [SFTestUtils assertFalse:[geometryCollection isMultiSurface]];
    
    SFMultiPoint *multiPoint2 = [geometryCollection asMultiPoint];
    [SFTestUtils assertEqualWithValue:multiPoint andValue2:multiPoint2];
    [SFTestUtils assertEqualWithValue:multiPoint2 andValue2:[multiPoint asMultiPoint]];
    
    SFGeometryCollection *geometryCollection2 = [multiPoint asGeometryCollection];
    [SFTestUtils assertEqualWithValue:geometryCollection andValue2: geometryCollection2];
    [SFTestUtils assertEqualWithValue:geometryCollection2 andValue2:[geometryCollection asGeometryCollection]];
    
    SFExtendedGeometryCollection *extendedGeometryCollection = [[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection];
    [SFTestUtils assertEqualIntWithValue:SF_GEOMETRYCOLLECTION andValue2:extendedGeometryCollection.geometryType];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOINT andValue2:[extendedGeometryCollection collectionType]];
    [SFTestUtils assertEqualWithValue:extendedGeometryCollection andValue2:[[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection]];
    
}

-(void) testMultiLineString {
    
    NSMutableArray<SFLineString *> *lineStrings = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++){
        [lineStrings addObject:[SFGeometryTestUtils createLineStringWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
    }
    
    NSMutableArray<SFGeometry *> *geometries = [[NSMutableArray alloc] init];
    [geometries addObjectsFromArray:lineStrings];
    
    SFMultiLineString *multiLineString = [[SFMultiLineString alloc] initWithLineStrings:lineStrings];
    SFGeometryCollection *geometryCollection = [[SFGeometryCollection alloc] initWithGeometries:geometries];
    
    [SFTestUtils assertEqualIntWithValue:[multiLineString numLineStrings] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualIntWithValue:[multiLineString numGeometries] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualWithValue:multiLineString.geometries andValue2:geometryCollection.geometries];
    
    [SFTestUtils assertTrue:[multiLineString isMultiLineString]];
    [SFTestUtils assertTrue:[multiLineString isMultiCurve]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTILINESTRING andValue2:[multiLineString collectionType]];
    [SFTestUtils assertFalse:[multiLineString isMultiPoint]];
    [SFTestUtils assertFalse:[multiLineString isMultiPolygon]];
    [SFTestUtils assertFalse:[multiLineString isMultiSurface]];
    
    [SFTestUtils assertTrue:[geometryCollection isMultiLineString]];
    [SFTestUtils assertTrue:[geometryCollection isMultiCurve]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTILINESTRING andValue2:[geometryCollection collectionType]];
    [SFTestUtils assertFalse:[geometryCollection isMultiPoint]];
    [SFTestUtils assertFalse:[geometryCollection isMultiPolygon]];
    [SFTestUtils assertFalse:[geometryCollection isMultiSurface]];
    
    SFMultiLineString *multiLineString2 = [geometryCollection asMultiLineString];
    [SFTestUtils assertEqualWithValue:multiLineString andValue2:multiLineString2];
    [SFTestUtils assertEqualWithValue:multiLineString2 andValue2:[multiLineString asMultiLineString]];
    
    SFGeometryCollection *geometryCollection2 = [multiLineString asGeometryCollection];
    [SFTestUtils assertEqualWithValue:geometryCollection andValue2: geometryCollection2];
    [SFTestUtils assertEqualWithValue:geometryCollection2 andValue2:[geometryCollection asGeometryCollection]];
    
    SFGeometryCollection *multiCurve = [geometryCollection asMultiCurve];
    [SFTestUtils assertEqualWithValue:multiLineString.geometries andValue2: multiCurve.geometries];
    SFGeometryCollection *multiCurve2 = [multiLineString asMultiCurve];
    [SFTestUtils assertEqualWithValue:multiCurve andValue2:multiCurve2];
    
    SFExtendedGeometryCollection *extendedGeometryCollection = [[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection];
    [SFTestUtils assertEqualIntWithValue:SF_MULTICURVE andValue2:extendedGeometryCollection.geometryType];
    [SFTestUtils assertEqualIntWithValue:SF_MULTILINESTRING andValue2:[extendedGeometryCollection collectionType]];
    [SFTestUtils assertEqualWithValue:extendedGeometryCollection andValue2:[[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection]];
    
}

-(void) testMultiPolygon {
    
    NSMutableArray<SFPolygon *> *polygons = [[NSMutableArray alloc] init];
    for(int i = 0; i < 5; i++){
        [polygons addObject:[SFGeometryTestUtils createPolygonWithHasZ:[SFTestUtils coinFlip] andHasM:[SFTestUtils coinFlip]]];
    }
    NSMutableArray<SFGeometry *> *geometries = [[NSMutableArray alloc] init];
    [geometries addObjectsFromArray:polygons];
    
    SFMultiPolygon *multiPolygon = [[SFMultiPolygon alloc] initWithPolygons:polygons];
    SFGeometryCollection *geometryCollection = [[SFGeometryCollection alloc] initWithGeometries:geometries];
    
    [SFTestUtils assertEqualIntWithValue:[multiPolygon numPolygons] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualIntWithValue:[multiPolygon numGeometries] andValue2:[geometryCollection numGeometries]];
    [SFTestUtils assertEqualWithValue:multiPolygon.geometries andValue2:geometryCollection.geometries];
    
    [SFTestUtils assertTrue:[multiPolygon isMultiPolygon]];
    [SFTestUtils assertTrue:[multiPolygon isMultiSurface]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOLYGON andValue2:[multiPolygon collectionType]];
    [SFTestUtils assertFalse:[multiPolygon isMultiPoint]];
    [SFTestUtils assertFalse:[multiPolygon isMultiLineString]];
    [SFTestUtils assertFalse:[multiPolygon isMultiCurve]];
    
    [SFTestUtils assertTrue:[geometryCollection isMultiPolygon]];
    [SFTestUtils assertTrue:[geometryCollection isMultiSurface]];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOLYGON andValue2:[geometryCollection collectionType]];
    [SFTestUtils assertFalse:[geometryCollection isMultiPoint]];
    [SFTestUtils assertFalse:[geometryCollection isMultiLineString]];
    [SFTestUtils assertFalse:[geometryCollection isMultiCurve]];
    
    SFMultiPolygon *multiPolygon2 = [geometryCollection asMultiPolygon];
    [SFTestUtils assertEqualWithValue:multiPolygon andValue2:multiPolygon2];
    [SFTestUtils assertEqualWithValue:multiPolygon2 andValue2:[multiPolygon asMultiPolygon]];
    
    SFGeometryCollection *geometryCollection2 = [multiPolygon asGeometryCollection];
    [SFTestUtils assertEqualWithValue:geometryCollection andValue2: geometryCollection2];
    [SFTestUtils assertEqualWithValue:geometryCollection2 andValue2:[geometryCollection asGeometryCollection]];
    
    SFGeometryCollection *multiSurface = [geometryCollection asMultiSurface];
    [SFTestUtils assertEqualWithValue:multiPolygon.geometries andValue2: multiSurface.geometries];
    SFGeometryCollection *multiSurface2 = [multiPolygon asMultiSurface];
    [SFTestUtils assertEqualWithValue:multiSurface andValue2:multiSurface2];
    
    SFExtendedGeometryCollection *extendedGeometryCollection = [[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection];
    [SFTestUtils assertEqualIntWithValue:SF_MULTISURFACE andValue2:extendedGeometryCollection.geometryType];
    [SFTestUtils assertEqualIntWithValue:SF_MULTIPOLYGON andValue2:[extendedGeometryCollection collectionType]];
    [SFTestUtils assertEqualWithValue:extendedGeometryCollection andValue2:[[SFExtendedGeometryCollection alloc] initWithGeometryCollection:geometryCollection]];
    
}

@end
